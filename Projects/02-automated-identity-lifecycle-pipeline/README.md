# Project 02: Automated Identity Lifecycle Pipeline

An end-to-end Joiner-Mover-Leaver (JML) automation built on Microsoft Graph PowerShell. This is the project that separates administrator titles from engineer titles: it proves you can code, not just click, and JML automation is the single most universally needed capability in IAM operations.

**Status:** 🔲 Not started · **Budget:** 12-18 hours

**Prerequisites:** [Project 01](../01-zero-trust-identity-lab/)'s tenant, Microsoft Graph PowerShell SDK.

## Problem

Manual joiner/mover/leaver processing doesn't scale and doesn't stay consistent — especially the "mover" case, which most implementations get wrong by only updating a department field and never removing access tied to the old role. That's a privilege-creep machine, and privilege creep is one of the most common findings in real access audits.

## Architecture

See [`docs/architecture.md`](docs/architecture.md) for the full diagram.

## What's Implemented

- [ ] Mock HR source (`employees.csv`) as the external source of truth
- [ ] JOINER function — creates the user, sets attributes, assigns a temp password, forces MFA registration
- [ ] MOVER function — updates attributes **and explicitly strips stale group access** tied to the old role
- [ ] LEAVER function — disables the account, revokes live sessions, strips group memberships, logs data-ownership transfer
- [ ] Idempotency — re-running against unchanged data produces zero changes
- [ ] Structured, timestamped audit logging (CSV) for every action
- [ ] `-WhatIf` / dry-run mode

*(Check these off as you build — see [`docs/lab-guide.md`](docs/lab-guide.md) for the full walkthrough and [`scripts/`](scripts/) for the working code.)*

## Proof It Works

[ TODO — embed screenshots once captured: before/after `Get-MgUserMemberOf` output for a leaver, and the idempotency test (two runs side by side, second run producing only SKIP entries). A 3-5 minute screen-capture demo of a live run is your strongest asset for this project — link it here once recorded. ]

## Design Decisions

See [`docs/design-decisions.md`](docs/design-decisions.md).

## Tools Used

Microsoft Graph PowerShell SDK · Microsoft Entra ID · CSV-based mock HR source

## Full Documentation

- [Phase-by-phase lab guide + troubleshooting](docs/lab-guide.md)
- [Architecture diagram](docs/architecture.md)
- [Design decisions](docs/design-decisions.md)
- [Working PowerShell script](scripts/lifecycle-pipeline.ps1)
- [Sample mock HR source](scripts/employees.csv)
- [Interview prep for this project](../../Interview-Prep/README.md#project-02--automated-identity-lifecycle-pipeline)
