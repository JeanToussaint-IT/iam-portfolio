# Architecture — Multi-Platform PAM Comparison

```mermaid
flowchart TB
    REQ[Privileged Access Request]
    subgraph MS[Microsoft Entra ID]
        M1[Eligible Assignment] --> M2[MFA + Justification + Approval]
        M2 --> M3[Time-boxed Active Role]
    end
    subgraph OK[Okta]
        O1[Group + Authentication Policy] --> O2[Step-up: Okta Verify / FastPass]
        O2 --> O3[Scoped App / Server Access]
    end
    subgraph ENT[Enterprise Layer — documented, not built]
        S1[SailPoint: governs BOTH,<br/>cross-system SoD + certifications]
        C1[CyberArk: vaults service accounts,<br/>rotates + records sessions]
    end
    REQ --> MS & OK
    MS & OK -.governed by.-> S1
    MS & OK -.credentials vaulted by.-> C1
```

**The mechanism difference, precisely:** Entra ID PIM time-boxes a **role assignment** — the permission itself is temporary and disappears on expiry. Okta's Authentication Policy gates the **session** — the group membership (and thus permission) is permanent, but reaching the protected resource requires satisfying a stronger factor at authentication time. Both reduce risk from stolen credentials; only PIM eliminates the standing permission.
