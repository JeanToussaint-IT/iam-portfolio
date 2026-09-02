# Project 03: Multi-Platform PAM Comparison

A hands-on comparison implementing equivalent Just-In-Time privileged access in both Entra ID PIM and Okta, plus a written decision framework covering SailPoint and CyberArk. This project proves multi-vendor fluency that employers explicitly screen for — most candidates are single-platform, so this is a differentiator.

**Status:** 🔲 Not started · **Budget:** 10-14 hours

**Prerequisites:** Entra ID P2 tenant, and a free Okta Developer org (see [`../../Setup/Environment-Setup.md`](../../Setup/Environment-Setup.md)).

## Problem

Most IAM candidates only have hands-on experience with one identity platform, but real environments are rarely single-vendor. Employers screen for candidates who can speak accurately to how different platforms achieve similar security outcomes through genuinely different mechanisms.

## Architecture

See [`docs/architecture.md`](docs/architecture.md) for the full diagram.

## What's Implemented

- [ ] PIM configured in Entra ID for a directory role: Eligible + MFA + justification + approval
- [ ] Equivalent JIT-style control in Okta: privileged group + Authentication Policy requiring a possession factor at every sign-in
- [ ] A precise written explanation of the mechanism difference (role-based time-boxing vs. session-based step-up)
- [ ] A comparison matrix covering Entra ID PIM, Okta, SailPoint, and CyberArk
- [ ] A one-page decision framework, tested against three fictional org profiles

*(See [`docs/lab-guide.md`](docs/lab-guide.md) for the full build and [`docs/comparison-matrix.md`](docs/comparison-matrix.md) for the matrix.)*

## Proof It Works

[ TODO — embed PIM and Okta configuration screenshots side by side once captured. ]

## Design Decisions

See [`docs/design-decisions.md`](docs/design-decisions.md).

## A note on honesty

Be explicit about what you built hands-on versus what you researched. *"I implemented JIT in Entra ID and Okta directly, and documented how SailPoint and CyberArk would layer on top based on their published architecture"* is a credible, senior-sounding answer. Overclaiming hands-on CyberArk/SailPoint experience is the fastest way to lose an interview when the follow-up question comes.

## Publishing this one differently

This project's natural format is a written technical article, not just a repo. Consider publishing the comparison matrix and decision framework on LinkedIn, Medium, or dev.to, and linking this repo for the configuration screenshots — comparison content reliably outperforms tutorial content for reach.

## Tools Used

Microsoft Entra ID PIM · Okta (Developer org) · SailPoint (researched) · CyberArk (researched)

## Full Documentation

- [Phase-by-phase lab guide](docs/lab-guide.md)
- [Architecture diagram](docs/architecture.md)
- [Design decisions](docs/design-decisions.md)
- [Comparison matrix + decision framework](docs/comparison-matrix.md)
- [Interview prep for this project](../../Interview-Prep/README.md#project-03--multi-platform-pam-comparison)
