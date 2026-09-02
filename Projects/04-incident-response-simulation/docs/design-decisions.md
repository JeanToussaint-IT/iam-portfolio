# Design Decisions — Incident Response Simulation

## Why simulate rather than describe a hypothetical

[ TODO — explain why hands-on evidence (an actual risk detection you triggered and resolved) is stronger than a description of how you'd theoretically respond. ]

## Why disabling the account wasn't enough on its own

[ TODO — explain the live refresh token problem and why `Revoke-MgUserSignInSession` had to run as a separate, immediate step. ]

## Why the runbook, not the incident report, is the deliverable you'd lead with in an interview

[ TODO — explain the difference between proving you handled one incident and proving you can make a team faster at handling all future ones. ]

## What I'd add next

[ TODO — e.g. automating detection-to-ticket via Logic Apps/Graph webhooks, extending the simulation to a second attack pattern (e.g. token theft), integrating with a SIEM for correlation. ]
