# Architecture — Automated Identity Lifecycle Pipeline

```mermaid
flowchart LR
    HR[HR Source<br/>employees.csv or webhook] --> ENG{Lifecycle Engine<br/>PowerShell + Graph}
    ENG -->|New row| J[JOINER<br/>create user, set attributes,<br/>assign license, force MFA reg]
    ENG -->|Changed dept| M[MOVER<br/>update attributes, recalc groups,<br/>REMOVE stale access]
    ENG -->|Missing/flagged| L[LEAVER<br/>disable, revoke sessions,<br/>strip groups, transfer ownership]
    J & M & L --> LOG[(Audit log<br/>timestamped CSV/JSON)]
    J & M & L --> ENTRA[(Microsoft Entra ID)]
```

**Why the HR source is external:** real pipelines read from Workday, SuccessFactors, or an HR database. The mock CSV here is architecturally identical — a source of truth external to the identity system that drives every change. Never let the identity system itself be the source of truth for who works there; that's the design flaw that creates orphaned accounts.
