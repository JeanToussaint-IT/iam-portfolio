# Project 04: Incident Response Simulation

A full detect-contain-eradicate-report cycle run against a simulated identity attack in your own tenant. This is the project that signals you can handle the security operations half of hybrid IAM/SecOps job postings — the ones that pay well precisely because they need both skill sets in one person.

**Status:** 🔲 Not started · **Budget:** 10-14 hours

**Prerequisites:** [Project 01](../01-zero-trust-identity-lab/)'s tenant with Entra ID P2 (Identity Protection).

> ⚠️ Simulate only within your own isolated lab tenant, using test accounts you created. Never run simulated attacks against a production tenant, an employer's environment, or any system you don't own — that's the line between a portfolio project and a career-ending incident.

## Problem

IAM and SecOps skill sets increasingly overlap, and hiring managers want to see that a candidate can not only configure identity controls but also detect, contain, and learn from a real identity-based incident.

## Architecture

See [`docs/architecture.md`](docs/architecture.md) for the full diagram.

## What's Implemented

- [ ] Entra ID Protection enabled with a risk-based Conditional Access policy
- [ ] A simulated, safely-generated risk signal (e.g. atypical-location sign-in, or a test OAuth app requesting broad scopes)
- [ ] Detection evidence from Identity Protection and Sign-in logs
- [ ] A written triage decision
- [ ] Containment: account disable + session revocation
- [ ] Eradication: illicit OAuth grant removed, credentials reset
- [ ] Recovery: account re-enabled under the correct policy
- [ ] A one-page incident report (timeline, scope, root cause, preventive control)
- [ ] The preventive control actually implemented, with evidence
- [ ] A reusable, standalone runbook

*(See [`docs/lab-guide.md`](docs/lab-guide.md) for the full build.)*

## Proof It Works

[ TODO — embed the risk detection screenshot, the timestamped incident report, and evidence of the implemented preventive control once captured. ]

## Design Decisions

See [`docs/design-decisions.md`](docs/design-decisions.md).

## Why the runbook is the real deliverable

Plenty of candidates can describe an incident they read about. Very few arrive with a runbook they wrote themselves, tested end-to-end, and can hand to an interviewer. The report proves you handled one incident; the runbook proves you can make an entire team faster at handling all future ones — lead with the runbook when you present this project. See [`docs/runbook-template.md`](docs/runbook-template.md).

## Portfolio capstone

If you build more than one of these four projects, add a single top-level profile README (or expand this repo's root README) linking them with one line each explaining the skill it demonstrates. A hiring manager landing on your portfolio should understand your entire capability set in under thirty seconds.

## Tools Used

Microsoft Entra ID Protection (P2) · Conditional Access · Sign-in logs · Enterprise applications (OAuth grants)

## Full Documentation

- [Phase-by-phase lab guide](docs/lab-guide.md)
- [Architecture diagram](docs/architecture.md)
- [Design decisions](docs/design-decisions.md)
- [Runbook template](docs/runbook-template.md)
- [Interview prep for this project](../../Interview-Prep/README.md#project-04--incident-response-simulation)
