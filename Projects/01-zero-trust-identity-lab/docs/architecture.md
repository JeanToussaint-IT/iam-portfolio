# Architecture — Zero Trust Identity Lab

```mermaid
flowchart TB
    subgraph Identities
        U1[Editor / Colorist / PM Users]
        BG[Break-Glass Account<br/>excluded from all CA policies]
    end
    subgraph Groups[Dynamic Security Groups]
        G1[Post-Production<br/>dept = Post-Production]
    end
    subgraph RBAC[Least-Privilege Access]
        R1[Reader — scoped to rg-post-production]
        R2[Custom Role: VM Restart Operator<br/>start/restart only, no delete]
    end
    subgraph CA[Conditional Access]
        C1{Compliant Device?} --> C2{MFA Satisfied?}
        C2 --> C3{Sign-in Risk?} --> C4[Block Legacy Auth]
    end
    subgraph PIM[Privileged Identity Management]
        P1[Eligible: User Administrator] --> P2[MFA + Justification + Approval]
        P2 --> P3[Active — time-boxed, audited]
    end
    U1 --> G1 --> R1 & R2 --> RES[rg-post-production]
    U1 --> CA --> RES
    U1 -.eligible.-> P1
    P3 -.time-boxed.-> RES
    BG -.excluded.-> CA
```

**The story:** no identity has standing access to anything it doesn't need daily. Access is either tightly scoped by RBAC, gated by Conditional Access signals, or time-boxed through PIM — and the one account that bypasses all of it (break-glass) is isolated and monitored instead.

> Note: the "Post-Production" department and roles (Editor / Colorist / Project Manager) used throughout this lab are a placeholder scenario borrowed from the book this template is based on — swap in whatever fictional (or real, anonymized) org/department makes sense to you. What matters for the portfolio is the pattern: attribute-driven dynamic groups → scoped RBAC → Conditional Access → PIM.
