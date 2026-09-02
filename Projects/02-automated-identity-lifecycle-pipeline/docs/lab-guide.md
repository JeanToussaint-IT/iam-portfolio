# Lab Guide — Automated Identity Lifecycle Pipeline

**Goal:** Automate joiner, mover, and leaver processing end-to-end with a real audit log.

## Step 1 — Build the mock HR source

See [`scripts/employees.csv`](../scripts/employees.csv) — columns: `EmployeeID, DisplayName, UPN, Department, JobTitle, Manager, Status (Active/Terminated)`.

## Step 2 — Connect with least-privilege scopes

Request only the scopes you actually use — document why you didn't request `Directory.ReadWrite.All`.

```powershell
Connect-MgGraph -Scopes `
  "User.ReadWrite.All", `
  "Group.ReadWrite.All", `
  "Directory.AccessAsUser.All"

# Verify what you actually got — scopes can be reduced by admin consent policy
(Get-MgContext).Scopes
```

## Step 3 — The JOINER function

`New-MgUser` with attributes from the CSV, `ForceChangePasswordNextSignIn`, and (in a real tenant) license assignment. See [`scripts/lifecycle-pipeline.ps1`](../scripts/lifecycle-pipeline.ps1) for the full working function.

## Step 4 — The MOVER function (where the real skill shows)

Detect a changed Department, update the user, and **explicitly verify stale group memberships are removed** — this removal step is what real organizations forget, causing privilege creep.

## Step 5 — The LEAVER function

Order matters here and interviewers test it: disable first (stops new sign-ins), then revoke sessions (kills tokens already issued — a disabled account with a live refresh token can still work for up to an hour), then strip group memberships, then handle data ownership.

## Step 6 — Logging and the driver loop

Every action writes a timestamped record (who, what, when, result) to a CSV audit file. The driver loop reads the CSV once and routes each row to the correct function.

## Building in idempotency and dry-run

Add a check at the top of each function: if the target state already matches, log `SKIP` and return — don't act. Add a `-WhatIf` switch that logs what *would* happen without calling any write cmdlet.

## Proving idempotency (the test that impresses)

Run the script twice against unchanged data. The second run must produce only `SKIP` entries and change nothing. Screenshot both runs side by side — this single piece of evidence demonstrates you understand that automation which can't be safely re-run is automation nobody will trust in production.

## Testing all three paths

Test joiner, mover, and leaver end-to-end, capturing `Get-MgUserMemberOf` output **before and after** each run as evidence. Record a 3-5 minute screen-capture demo of a live run — this video is your strongest asset for this project.

## Verify

Your repo should show:
- A before/after `Get-MgUserMemberOf` comparison with empty group membership for the leaver
- `AccountEnabled` is `False` for the leaver, and no post-run sign-ins succeed
- An audit log containing a complete timestamped record of every action taken

## Real-world scenario: why the removal step is the whole point

Most candidates who build a JML script implement joiner and leaver correctly and treat mover as an afterthought — just updating the department field. But privilege creep, where an employee accumulates access across every role they've ever held, is one of the most common findings in real access audits and a direct enabler of insider risk. A mover function that explicitly removes access tied to the previous role, and logs what it removed, demonstrates that you understand the actual governance problem rather than just the mechanics of the API.

## Troubleshooting

**"Insufficient privileges"** — your Graph scopes are missing or admin consent wasn't granted; check `(Get-MgContext).Scopes` against what the cmdlet requires.

**Can't remove a user from a group** — it's a dynamic group; membership is rule-computed, so you change the attribute, not the membership. Your script should catch this and log it rather than crash.

**Leaver still has access minutes later** — you disabled but didn't revoke sessions; this is exactly the gap `Revoke-MgUserSignInSession` closes.

**Script partially completed then failed** — this is why logging every action matters; your audit CSV tells you exactly where to resume.
