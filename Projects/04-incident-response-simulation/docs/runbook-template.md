# Runbook — Identity Compromise Response

*Fill this in as you complete the lab; this is meant to be usable by someone else, not just a record of what you did.*

## Trigger

[ TODO — what detection fires this runbook? e.g. "Identity Protection risk level = Medium or High on a risky sign-in." ]

## Triage criteria

[ TODO — the specific signals that distinguish an incident from a routine ticket. ]

## Containment steps (in order)

1. [ TODO — e.g. disable the account (`Update-MgUser -AccountEnabled:$false`) ]
2. [ TODO — e.g. revoke active sessions (`Revoke-MgUserSignInSession`) — required even after disabling, because a live refresh token survives a disable ]
3. [ TODO ]

## Eradication steps

[ TODO — e.g. revoke illicit OAuth grants via Enterprise applications → Permissions; reset credentials. ]

## Recovery steps

[ TODO — e.g. re-enable with forced password change; confirm sign-in succeeds under the correct Conditional Access policy. ]

## Escalation criteria

[ TODO — at what point does this stop being something one analyst handles alone? e.g. confirmed lateral movement, privileged account involved, more than N accounts affected. ]

## Preventive control checklist

[ TODO — the specific control implemented as a result of this incident, and how to verify it's active. ]

## Incident report — worked example

*(Fill in with your actual simulated incident, timestamps redacted/adjusted as needed.)*

| Field | Detail |
|---|---|
| Detected | [ TODO — timestamp ] |
| Account | [ TODO — test account, anonymized if needed ] |
| Risk signal | [ TODO — e.g. atypical location, anonymous IP ] |
| Triage decision | [ TODO ] |
| Containment actions | [ TODO ] |
| Eradication actions | [ TODO ] |
| Root cause | [ TODO ] |
| Preventive control implemented | [ TODO ] |
