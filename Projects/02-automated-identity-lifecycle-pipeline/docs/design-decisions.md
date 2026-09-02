# Design Decisions — Automated Identity Lifecycle Pipeline

## Why least-privilege Graph scopes instead of `Directory.ReadWrite.All`

[ TODO — `Directory.ReadWrite.All` is what most tutorials use because it's easier, but it grants far more than this script needs. Explain what scopes you actually requested (`User.ReadWrite.All`, `Group.ReadWrite.All`, `Directory.AccessAsUser.All`) and why you scoped down. This is the kind of detail that signals security maturity rather than tutorial-following. ]

## Why the MOVER function explicitly removes stale access, not just updates the department field

[ TODO — most implementations treat "mover" as an afterthought. Explain why leaving old-role group memberships in place is a privilege-creep bug, not a minor gap, and how your function computes what to remove. ]

## Why the LEAVER sequence is disable → revoke sessions → strip groups, in that exact order

[ TODO — a disabled account with a live refresh token can still work for up to an hour. Explain why `Revoke-MgUserSignInSession` has to run immediately after disabling, not instead of it. ]

## Why idempotency mattered enough to test explicitly

[ TODO — explain what you did to prove re-running the script against unchanged data produces zero changes, and why automation that can't be safely re-run is automation nobody will trust in production. ]

## Why a `-WhatIf` / dry-run mode

[ TODO — explain how dry-run mode let you validate the script safely before it touched anything, and what you checked in WhatIf output before a real run. ]

## What I'd add next

[ TODO — e.g. webhook-driven triggering instead of a scheduled CSV read, richer conflict handling, integration with an actual HRIS sandbox. ]
