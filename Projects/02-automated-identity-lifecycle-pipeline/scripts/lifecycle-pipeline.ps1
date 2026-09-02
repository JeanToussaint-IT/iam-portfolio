<#
.SYNOPSIS
    Automated Identity Lifecycle Pipeline — Joiner / Mover / Leaver (JML) automation
    against Microsoft Entra ID via Microsoft Graph PowerShell.

.DESCRIPTION
    Reads a mock HR source (employees.csv) and routes each row to the correct
    lifecycle function based on status and whether the user already exists.
    Idempotent: re-running against unchanged data produces only SKIP log entries.
    Supports -WhatIf for safe dry-run validation before any write action.

.NOTES
    Run in an isolated lab tenant only. Never point this at a production tenant.
#>

param([switch]$WhatIf)

# ---- Connect with least-privilege scopes -----------------------------------
Connect-MgGraph -Scopes `
  "User.ReadWrite.All", `
  "Group.ReadWrite.All", `
  "Directory.AccessAsUser.All"

# Verify what you actually got — scopes can be reduced by admin consent policy
(Get-MgContext).Scopes

$domain = 'yourtenant.onmicrosoft.com'   # TODO: replace with your lab tenant domain
$logPath = ".\logs\lifecycle-audit.csv"
New-Item -ItemType Directory -Force -Path (Split-Path $logPath) | Out-Null

function Write-Log {
  param($Action, $Target, $Detail)
  $entry = [pscustomobject]@{
    Timestamp = (Get-Date).ToString('o'); Action = $Action
    Target    = $Target;                  Detail = $Detail
    Operator  = (Get-MgContext).Account
  }
  $entry | Export-Csv -Path $logPath -Append -NoTypeInformation
  Write-Host "[$Action] $Target — $Detail"
}

function New-RandomPassword {
  -join ((48..57) + (65..90) + (97..122) | Get-Random -Count 20 | ForEach-Object {[char]$_}) + "!Aa1"
}

# ---- JOINER ------------------------------------------------------------------
function Invoke-Joiner {
  param($Row, $Domain, [switch]$WhatIf)
  $upn = "$($Row.UPN)@$Domain"
  $existing = Get-MgUser -Filter "userPrincipalName eq '$upn'" -ErrorAction SilentlyContinue
  if ($existing) { Write-Log 'SKIP' $upn 'Already exists (idempotent)'; return }
  if ($WhatIf) { Write-Log 'WHATIF' $upn 'Would create user'; return }

  $pp = @{ Password = (New-RandomPassword); ForceChangePasswordNextSignIn = $true }
  $new = New-MgUser -DisplayName $Row.DisplayName -UserPrincipalName $upn `
           -MailNickname $Row.UPN.Replace('.','') -AccountEnabled `
           -PasswordProfile $pp -Department $Row.Department -JobTitle $Row.JobTitle `
           -EmployeeId $Row.EmployeeID
  Write-Log 'JOINER' $upn "Created, id=$($new.Id)"
}

# ---- MOVER (the step everyone forgets is the removal) ------------------------
function Invoke-Mover {
  param($Row, $Domain, [switch]$WhatIf)
  $upn  = "$($Row.UPN)@$Domain"
  $user = Get-MgUser -Filter "userPrincipalName eq '$upn'" -Property Id,Department,JobTitle
  if (-not $user) { return }
  if ($user.Department -eq $Row.Department -and $user.JobTitle -eq $Row.JobTitle) {
    Write-Log 'SKIP' $upn 'No change (idempotent)'; return
  }
  $oldDept = $user.Department
  if ($WhatIf) { Write-Log 'WHATIF' $upn "Would move $oldDept -> $($Row.Department)"; return }

  Update-MgUser -UserId $user.Id -Department $Row.Department -JobTitle $Row.JobTitle

  # THE STEP EVERYONE FORGETS: strip access tied to the OLD role
  $stale = Get-MgUserMemberOf -UserId $user.Id |
    Where-Object { $_.AdditionalProperties.displayName -like "*$oldDept*" }
  foreach ($g in $stale) {
    Remove-MgGroupMemberByRef -GroupId $g.Id -DirectoryObjectId $user.Id
    Write-Log 'MOVER-REVOKE' $upn "Removed stale group $($g.AdditionalProperties.displayName)"
  }
  Write-Log 'MOVER' $upn "Moved $oldDept -> $($Row.Department)"
}

# ---- LEAVER: disable -> revoke sessions -> strip groups -----------------------
function Invoke-Leaver {
  param($Row, $Domain, [switch]$WhatIf)
  $upn  = "$($Row.UPN)@$Domain"
  $user = Get-MgUser -Filter "userPrincipalName eq '$upn'" -Property Id,AccountEnabled
  if (-not $user) { return }
  if (-not $user.AccountEnabled) { Write-Log 'SKIP' $upn 'Already disabled'; return }
  if ($WhatIf) { Write-Log 'WHATIF' $upn 'Would disable + revoke + strip groups'; return }

  Update-MgUser -UserId $user.Id -AccountEnabled:$false          # 1. stop new sign-ins
  Revoke-MgUserSignInSession -UserId $user.Id                    # 2. kill live tokens

  $groups = Get-MgUserMemberOf -UserId $user.Id                  # 3. strip access
  foreach ($g in $groups) {
    try {
      Remove-MgGroupMemberByRef -GroupId $g.Id -DirectoryObjectId $user.Id -ErrorAction Stop
      Write-Log 'LEAVER-REVOKE' $upn "Removed from $($g.AdditionalProperties.displayName)"
    } catch { Write-Log 'WARN' $upn "Dynamic group, cannot remove directly" }
  }
  Write-Log 'LEAVER' $upn 'Disabled, sessions revoked, groups stripped'
}

# ---- Driver: one pass over the HR file routes every row to the right function --
Import-Csv .\employees.csv | ForEach-Object {
  if ($_.Status -eq 'Terminated') {
    Invoke-Leaver -Row $_ -Domain $domain -WhatIf:$WhatIf
  } else {
    $exists = Get-MgUser -Filter "userPrincipalName eq '$($_.UPN)@$domain'" -ErrorAction SilentlyContinue
    if ($exists) { Invoke-Mover -Row $_ -Domain $domain -WhatIf:$WhatIf }
    else         { Invoke-Joiner -Row $_ -Domain $domain -WhatIf:$WhatIf }
  }
}
