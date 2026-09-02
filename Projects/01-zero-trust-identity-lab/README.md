# Project 01: Zero Trust Identity Lab

A hands-on Microsoft Entra ID environment implementing least-privilege access, Conditional Access policy design, and Just-In-Time privileged access via PIM. This is the strongest entry-level IAM portfolio piece — it exercises the four things job postings ask for most: least privilege, Zero Trust policy design, JIT privileged access, and documented reasoning.

**Status:** 🔲 Not started · **Budget:** 10-15 hours across 1-2 weeks

**Prerequisites:** a free Azure tenant with Entra ID P2 trial (see [`../../Setup/Environment-Setup.md`](../../Setup/Environment-Setup.md)) and a GitHub account.

## Problem

Most breaches trace to standing privilege and unconditional trust: an account with more access than it needs, all the time, requiring no extra verification to use it. This lab implements the inverse.

## Architecture

See [`docs/architecture.md`](docs/architecture.md) for the full diagram (renders live on GitHub).

> The one-sentence story to tell while pointing at the diagram: *"No identity has standing access to anything it doesn't need daily — access is either tightly scoped by RBAC, gated by Conditional Access signals, or time-boxed through PIM, and the one account that bypasses all of it is isolated and monitored."*

## What's Implemented

- [ ] Dynamic security groups driven by user attributes
- [ ] Reader role scoped to a single resource group + a hand-authored custom role permitting VM start/restart with no delete rights
- [ ] Three Conditional Access policies, validated in Report-only mode before enabling
- [ ] PIM Just-In-Time activation with MFA, justification, and approval
- [ ] Isolated break-glass account excluded from all Conditional Access policies

*(Check these off as you complete each phase — see [`docs/lab-guide.md`](docs/lab-guide.md) for the full build.)*

## Proof It Works

[ TODO — embed your 3 required screenshots here once captured (see `screenshots/` for the exact list): dynamic group membership, Report-only CA validation logs, and the complete PIM audit trail. ]

## Design Decisions

See [`docs/design-decisions.md`](docs/design-decisions.md) — every choice here optimizes for auditable least privilege over convenience.

## What I'd Add Next

- Graph automation for group/role assignment (see [Project 02](../02-automated-identity-lifecycle-pipeline/))
- Identity Protection risk-based policies (see [Project 04](../04-incident-response-simulation/))
- Scheduled access reviews for the custom role

## Tools Used

Microsoft Entra ID · Entra ID P2 · Conditional Access · Privileged Identity Management (PIM) · Azure RBAC · Microsoft Graph PowerShell

## Full Documentation

- [Phase-by-phase lab guide + troubleshooting](docs/lab-guide.md)
- [Architecture diagram](docs/architecture.md)
- [Design decisions](docs/design-decisions.md)
- [Interview prep for this project](../../Interview-Prep/README.md#project-01--zero-trust-identity-lab)
