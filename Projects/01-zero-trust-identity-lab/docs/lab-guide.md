# Lab Guide — Zero Trust Identity Lab

**Goal:** Build, document, and publish a defensible Zero Trust identity environment.

## Phase 1 — Foundation and safety net

Create your break-glass account **first**, before any Conditional Access policy exists: a cloud-only Global Administrator with a long random password stored offline.

Portal path: **Microsoft Entra ID → Users → New user → Create new user**. Set "Auto-generate password" off and supply a 32+ character random string. Then **Entra ID → Roles and administrators → Global Administrator → Add assignments** → select the account → Assignment type: **Active, Permanently assigned**.

This is intentionally the opposite of everything else you'll build — document that contradiction in `design-decisions.md`, because an interviewer will ask about it, and the correct answer is that break-glass must not depend on the JIT system it exists to rescue you from.

```powershell
# Verify your break-glass account exists and is cloud-only before proceeding
Connect-MgGraph -Scopes "User.Read.All","RoleManagement.Read.Directory"
Get-MgUser -Filter "startswith(userPrincipalName,'breakglass')" |
  Select-Object DisplayName, UserPrincipalName, OnPremisesSyncEnabled
# OnPremisesSyncEnabled must be null/false — a synced account can be broken by on-prem outage
```

Initialize your GitHub repo with this project's folder structure and commit now — incremental commit history shows real work.

## Phase 2 — Attributes are the foundation of everything

Create 4-5 test users with realistic **Department** and **Job Title** attributes set (**Properties → Job information**). This matters more than it looks: dynamic group rules, later automation, and access reviews all key off these attributes. Garbage attributes produce garbage access — this is the practical meaning of "identity data quality," a phrase that appears in senior IAM job descriptions.

```powershell
# Bulk-create test users with the attributes your dynamic group will use
$users = @(
  @{Name='Alex Editor';   UPN='alex.editor';   Dept='Post-Production'; Title='Editor'},
  @{Name='Sam Colorist';  UPN='sam.colorist';  Dept='Post-Production'; Title='Colorist'},
  @{Name='Jordan PM';     UPN='jordan.pm';     Dept='Post-Production'; Title='Project Manager'},
  @{Name='Riley Finance'; UPN='riley.finance'; Dept='Finance';         Title='Analyst'}
)
$domain = 'yourtenant.onmicrosoft.com'
foreach ($u in $users) {
  $pp = @{ Password='TempP@ssw0rd2026!'; ForceChangePasswordNextSignIn=$true }
  New-MgUser -DisplayName $u.Name -UserPrincipalName "$($u.UPN)@$domain" `
    -MailNickname $u.UPN.Replace('.','') -AccountEnabled -PasswordProfile $pp `
    -Department $u.Dept -JobTitle $u.Title
}
# Riley Finance is your control: she must NOT land in the Post-Production group
```

> Always include a negative-control user like Riley Finance. Proving a rule correctly **excludes** someone is stronger evidence than proving it includes people — it demonstrates you tested the boundary, not just the happy path.

Build a dynamic security group with the rule `(user.department -eq "Post-Production")`; confirm membership auto-populates. Write in `design-decisions.md` why you chose dynamic over manual membership.

## Phase 3 — Scope is the whole lesson

Create resource group `rg-post-production` and assign the group the **Reader** role scoped to it — **not** the subscription. Verify with **Check access** that nothing broader leaked.

Portal path: your resource group → **Access control (IAM) → Add → Add role assignment**. The critical detail is the scope selector at the top of the blade — assigning at subscription scope when you meant resource group scope is the single most common real-world over-permissioning mistake, and it's invisible unless you check.

```json
// Custom role: can start/restart a VM, cannot delete or reconfigure it
// Save as scripts/vm-restart-operator.json
{
  "Name": "VM Restart Operator",
  "IsCustom": true,
  "Description": "Start and restart VMs only. No delete, no config changes.",
  "Actions": [
    "Microsoft.Compute/virtualMachines/start/action",
    "Microsoft.Compute/virtualMachines/restart/action",
    "Microsoft.Compute/virtualMachines/read"
  ],
  "NotActions": [],
  "AssignableScopes": [ "/subscriptions/<your-subscription-id>" ]
}
```

```powershell
# Deploy it:
New-AzRoleDefinition -InputFile .\scripts\vm-restart-operator.json
```

Write and assign the custom **VM Restart Operator** role — a role you authored yourself is a top-tier interview artifact.

## Phase 4 — The Report-only discipline

Build all three Conditional Access policies before enabling any of them. Portal path: **Entra ID → Security → Conditional Access → Policies → New policy**.

| Policy | Assignment | Grant control |
|---|---|---|
| CA001-Require-MFA-AllUsers | All users, EXCLUDE break-glass | Require MFA |
| CA002-Block-Legacy-Auth | All users, EXCLUDE break-glass; client apps = legacy | Block access |
| CA003-Compliant-Device-Admins | Directory roles: User Admin, Global Admin | Require compliant or hybrid-joined device |

Read results at **Entra ID → Monitoring → Sign-in logs → click a sign-in → Conditional Access tab**, which shows each policy and whether it would have applied, been satisfied, or blocked. Validate all three, screenshot the results, **then** flip each to On.

> Common failure: your CA policy shows "Not applied" in the logs and you assume it's broken. Usually the sign-in simply didn't match the conditions (wrong app, wrong client type, or you're the excluded break-glass account). Read the per-condition breakdown before changing anything — misdiagnosing this and loosening a working policy is how real over-permissioning happens.

## Phase 5 — Prove the JIT loop closes

Portal path: **Entra ID → Identity Governance → Privileged Identity Management → Microsoft Entra roles → Assignments → Add assignments** (set **Eligible**), then **Settings → [role] → Edit** to configure activation requirements.

Assign **User Administrator** as **Eligible** (not Active) to a test user. Configure activation: require MFA, justification, and approval; cap duration at 4 hours. Run the full cycle (request → approve → activate → expire).

The deliverable is not the configuration — it's the **Audit history** screenshot showing request, approval, activation, and expiry as a connected chain.

## Phase 6 — Publish

Write the README (problem → architecture → what's implemented), finish `design-decisions.md`, push, and write your LinkedIn post announcing it.

## Verify

Your repo should contain:
- A rendered Mermaid diagram (`docs/architecture.md`)
- A completed `design-decisions.md`
- Three screenshots: dynamic group membership, Report-only CA validation logs, and the complete PIM audit trail

## Troubleshooting

**Dynamic group empty after 5+ minutes** — check the rule syntax (attribute names are case-sensitive) and confirm the users actually have the attribute populated, not blank.

**PIM options greyed out** — your P2 trial has expired or was never activated (**Entra ID → Licenses**).

**Custom role won't deploy** — the `AssignableScopes` subscription ID is wrong, or you lack Owner/User Access Administrator at that scope.

**Locked yourself out despite planning not to** — sign in with the break-glass account, which is why you built it in Phase 1. If you skipped Phase 1, you may need to open a Microsoft support ticket — the expensive lesson this project is designed to teach you cheaply.
