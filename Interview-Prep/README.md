# Interview Prep

Personal prep notes, kept alongside the portfolio so everything lives in one place. Sourced from the career-paths guidance and the four flagship projects.

## Typical title progression

Help Desk / IT Support → IAM Administrator (Junior) → IAM Administrator (Senior) / PAM Engineer → IAM/Identity Security Engineer → IAM Architect / Identity & Access Lead.

## What to have ready for interviews

- A published GitHub portfolio with at least [Project 01](../Projects/01-zero-trust-identity-lab/) (Zero Trust Identity Lab), ready to screen-share live — this is the single highest-leverage thing you can bring.
- A walkthrough of your lab tenant: users, dynamic groups, custom RBAC role, Conditional Access policy, and PIM configuration.
- Your offboarding automation script from [Project 02](../Projects/02-automated-identity-lifecycle-pipeline/), and an explanation of why each step matters.
- A clear, correct explanation of AuthN vs. AuthZ, and RBAC vs. Entra roles vs. Azure RBAC — these fundamentals are tested constantly, even for senior roles.
- One real or scenario-based story of an access decision you made and the trade-off you weighed (least privilege vs. usability is the classic tension).

## Common interview questions to rehearse

- "Walk me through what happens, step by step, from a user typing their password to being granted access to an app."
- "How would you design offboarding for a contractor with a known end date?"
- "What's the difference between Eligible and Active in PIM, and why does that distinction matter?"
- "A user reports they can't access a resource they think they should have. Walk me through how you'd troubleshoot it."
- "What would you do differently if you were designing access for a highly regulated environment vs. a fast-moving startup?"

---

## Project 01 — Zero Trust Identity Lab

**Resume bullets this project earns:**
- "Designed and deployed a Zero Trust access model in Microsoft Entra ID combining scoped RBAC, three-policy Conditional Access enforcement, and JIT privileged access via PIM to eliminate standing administrative privilege."
- "Authored a custom Azure RBAC role restricting VM operations to start/restart only, replacing over-permissioned built-in role assignments."
- "Implemented Conditional Access using a Report-only rollout methodology, preventing the tenant-wide lockout risk common to untested policy changes."

**Interview questions to rehearse:**
- "Walk me through this project." — Structure: problem → architecture → one concrete end-to-end example → what you'd add with more time.
- "Why did you scope the custom role that way?" — Because delete rights weren't justified by the use case, and Contributor would have been convenience over least privilege.
- "What was the hardest part?" — Getting Conditional Access rule logic right without locking yourself out, which is exactly why you validated in Report-only first.

## Project 02 — Automated Identity Lifecycle Pipeline

**Resume bullets this project earns:**
- "Built an idempotent identity lifecycle automation pipeline in PowerShell and Microsoft Graph, handling joiner, mover, and leaver events with full session revocation and structured audit logging."
- "Reduced manual offboarding steps to a single command, eliminating the residual-access risk of ticket-driven, human-dependent deprovisioning."
- "Implemented least-privilege API scoping and dry-run validation in production-pattern automation scripts."

**Interview angle:** be ready to explain, unprompted, why the MOVER function's removal step is the actual point of the project — most candidates only get joiner/leaver right and treat mover as a field update.

## Project 03 — Multi-Platform PAM Comparison

**Resume bullets this project earns:**
- "Implemented and compared Just-In-Time privileged access across Microsoft Entra ID PIM and Okta, documenting architectural trade-offs between role-based and session-based activation models."
- "Authored a vendor-selection decision framework for privileged access tooling spanning Entra ID, Okta, SailPoint, and CyberArk, validated against multiple organizational profiles."

**Interview angle:** be precise about the PIM-vs-Okta mechanism difference (time-boxed role vs. session-gated step-up) — that precision is what makes this project interview-worthy, not the configuration itself. Be equally precise about what you built hands-on vs. researched (SailPoint/CyberArk).

## Project 04 — Incident Response Simulation

**Resume bullets this project earns:**
- "Executed a full incident response lifecycle against a simulated identity compromise, from Identity Protection detection through containment, eradication, and post-incident reporting."
- "Authored a reusable identity-incident runbook covering triage criteria, containment sequencing, and escalation paths."
- "Implemented preventive Conditional Access and consent-restriction controls derived from incident root-cause analysis."

**Interview angle:** lead with the runbook, not the incident report — it's the artifact that proves you can make a whole team faster, not just that you handled one event.
