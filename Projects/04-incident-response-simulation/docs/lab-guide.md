# Lab Guide — Incident Response Simulation

**Goal:** Run a complete IR lifecycle against a simulated identity compromise and produce a reusable runbook.

> ⚠️ Simulate only within your own isolated lab tenant, using test accounts you created. Never run simulated attacks against a production tenant, an employer's environment, or any system you don't own.

1. Enable **Microsoft Entra ID Protection** and configure a risk-based Conditional Access policy so risky sign-ins trigger a response.
2. **SIMULATE** — using a test account in your own tenant only, generate a detectable signal: e.g. sign in via a VPN/Tor exit to trigger an atypical-location or anonymous-IP risk detection, or register a test OAuth app requesting broad scopes to simulate consent phishing.
3. **DETECT** — locate the event in **Identity Protection → Risky sign-ins** and in **Sign-in logs**. Screenshot the risk detection with its risk level and the signals that produced it.
4. **TRIAGE** — write your triage decision explicitly: what made this an incident rather than a routine access ticket?
5. **CONTAIN** — disable the account and run `Revoke-MgUserSignInSession`. Document why disabling alone is insufficient (live refresh tokens survive it).
6. **ERADICATE** — if simulating consent phishing, remove the illicit OAuth grant via **Enterprise applications → Permissions**, and reset credentials.
7. **RECOVER** — re-enable the account with a forced password change and confirm the user can authenticate under the correct policy.
8. **REPORT** — write a one-page incident report: timeline with timestamps, scope of impact, containment actions, root cause, and the specific preventive control you'd implement.
9. **PREVENT** — actually implement that control (e.g. restrict user consent to verified publishers, or tighten the risk policy) and screenshot it as evidence you closed the loop.
10. **RUNBOOK** — convert the whole exercise into a reusable one-page playbook another analyst could follow: numbered steps, decision points, and escalation criteria. See [`runbook-template.md`](runbook-template.md).

## Verify

Your repo should contain the risk detection screenshot, a timestamped incident report, evidence of the implemented preventive control, and a standalone runbook document.

## Real-world scenario: why the runbook is the real deliverable

Plenty of candidates can describe an incident they read about. Very few arrive with a runbook they wrote themselves, tested end-to-end, and can hand to an interviewer. The report proves you handled one incident; the runbook proves you can make an entire team faster at handling all future ones — which is precisely the difference between an analyst who executes tickets and one who gets promoted to design the process. Lead with the runbook when you present this project.
