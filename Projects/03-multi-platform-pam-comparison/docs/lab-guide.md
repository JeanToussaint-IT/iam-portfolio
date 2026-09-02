# Lab Guide — Multi-Platform PAM Comparison

**Goal:** Implement equivalent JIT privileged access on two platforms and produce a defensible decision framework.

## Step 1 — Entra ID side (role-based, time-boxed)

Portal path: **Entra ID → Identity Governance → Privileged Identity Management → Microsoft Entra roles → Settings → select role → Edit**. Configure: max duration 4 hours, require MFA, require justification, require approval. (Reuse or extend [Project 01](../../01-zero-trust-identity-lab/)'s PIM work.) Run one full activation cycle and export the audit log via **PIM → Resource audit**.

## Step 2 — Okta side (session-based, step-up)

In your free Okta Developer org: **Directory → Groups → Add Group**, create "Privileged-Admins." Then **Security → Authentication Policies → Add policy** → add a rule targeting that group requiring "Password / IdP + Possession factor" with "re-authenticate every: 1 hour." Assign the policy to a sensitive application. Test by signing in as a member and confirming the step-up prompt.

## Step 3 — Articulate the mechanism difference precisely

This is the intellectual core of the project and what makes it interview-worthy. Entra ID PIM time-boxes a **role assignment** — the permission itself is temporary and disappears on expiry. Okta's Authentication Policy gates the **session** — the group membership (and thus permission) is permanent, but reaching the protected resource requires satisfying a stronger factor at authentication time. Both reduce risk from stolen credentials; only PIM eliminates the standing permission. Being able to state that distinction cleanly is worth more than either configuration on its own.

## Step 4 — The decision framework

Write a one-page framework answering: given an organization's profile, which tool(s) would you recommend and why? Structure it as diagnostic questions rather than a product ranking:

- Is the estate Microsoft-centric, multi-cloud, or heavily legacy/on-prem? (Drives Entra ID vs. Okta vs. "you need a governance layer regardless.")
- How many non-human/service accounts hold privileged credentials? (Above a few hundred, CyberArk's vaulting becomes hard to substitute.)
- Is there a regulatory requirement to prove access certification and cross-system SoD? (This is the SailPoint trigger.)
- Is session recording required for compliance or forensics? (CyberArk PSM, or Okta OPA for server access.)
- What's the realistic operational maturity? (Recommending an enterprise IGA platform to a 40-person startup with no identity team is a wrong answer even if the features fit.)

## Step 5 — Test the framework against three org profiles

See [`comparison-matrix.md`](comparison-matrix.md) for the worked table.

## Verify

Your repo should contain PIM and Okta configuration screenshots side by side, a completed comparison matrix, and three worked org-profile recommendations that apply your own framework.
