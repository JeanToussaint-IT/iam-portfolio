# Comparison Matrix & Decision Framework

## Capability comparison

| Capability | Entra ID PIM | Okta | SailPoint | CyberArk |
|---|---|---|---|---|
| Primary model | Time-boxed role activation | Session-based step-up auth | Governance & certification | Credential vaulting |
| Approval workflow | Native | Via Okta Workflows/OIG | Native, multi-stage | Native (dual control) |
| Human privileged access | Strong | Strong | Governs, doesn't broker | Strong |
| Service/non-human accounts | Limited | Limited | Governs entitlements | Core strength |
| Session recording | No | OPA only | No | Core strength (PSM) |
| Credential rotation | No | Ephemeral certs (OPA) | No | Core strength (CPM) |
| Cross-system SoD | No | OIG (limited) | Core strength | No |
| Licensing tier | Entra ID P2 | Okta + OPA/OIG add-on | Enterprise | Enterprise |
| Hands-on in this project | Yes | Yes | Researched | Researched |

> The last row is deliberate and important. Explicitly labeling what you researched versus implemented converts a potential credibility gap into a demonstration of intellectual honesty — a trait interviewers weight heavily for security roles, where overclaiming is a genuine risk indicator.

## Decision framework — diagnostic questions

1. Is the estate Microsoft-centric, multi-cloud, or heavily legacy/on-prem?
2. How many non-human/service accounts hold privileged credentials?
3. Is there a regulatory requirement to prove access certification and cross-system SoD?
4. Is session recording required for compliance or forensics?
5. What's the realistic operational maturity of the identity team?

## Tested against three org profiles

| Org profile | Recommendation |
|---|---|
| 250-person Microsoft-centric firm, M365 + Azure, light regulation | Entra ID P2 with PIM. Adding SailPoint/CyberArk here is over-engineering — the built-in governance is sufficient at this maturity. |
| Multi-cloud startup, AWS + GCP + 40 SaaS tools, no Microsoft footprint | Okta as IdP with SCIM provisioning; consider OPA for server access. No natural Entra ID hub exists to build around. |
| Regional bank, 8,000 staff, mainframe + Entra ID, SOX obligations | Entra ID for SSO + SailPoint for cross-system certification and SoD + CyberArk for service accounts and session recording. All three, each doing a distinct job. |

[ TODO — once you've built the Entra ID and Okta sides, replace this note with your own worked reasoning for each profile, in your own words, as if explaining it live in an interview. ]
