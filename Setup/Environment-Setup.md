# Environment Setup

Every project in this portfolio runs in a free, isolated lab tenant — never a work or production tenant. A misconfigured Conditional Access policy in a real company tenant can lock every employee out at once; this has happened at real companies and made headlines.

## 1. Microsoft Entra ID lab tenant (required for Projects 01, 02, 03, 04)

**Goal:** get hands-on access to an actual Entra ID directory.

1. Go to [azure.microsoft.com/free](https://azure.microsoft.com/free) and sign up (a phone number and card for identity verification are required; the free tier will not auto-charge you).
2. During signup, Azure creates a default Entra ID tenant for you automatically — note the tenant name, e.g. `yourname.onmicrosoft.com`.
3. Sign in to the [Azure Portal](https://portal.azure.com) and search for "Microsoft Entra ID" in the top search bar.
4. On the Overview blade, record your **Tenant ID** (a GUID) — you'll need this constantly for scripting and Graph API calls.
5. Go to **Users → All Users** and confirm you see your own account listed as the tenant's first Global Administrator.
6. Go to **Microsoft Entra ID → Licenses → All Products**, and if eligible, activate a free **Microsoft Entra ID P2 trial** — this unlocks PIM and Identity Protection, which Projects 01, 03, and 04 depend on.

**Verify:** you can see your tenant name and Tenant ID on the Entra ID Overview page, and your account is listed as Global Administrator.

## 2. Okta Developer org (required for Project 03)

**Goal:** get hands-on in Okta so you can speak to both major platforms from direct experience, not just theory.

1. Go to [developer.okta.com/signup](https://developer.okta.com/signup) and create a free Okta Developer Edition org (no credit card required).
2. Sign in to the Okta Admin Console and go to **Directory → People → Add Person** to create test users mirroring the ones in your Entra ID tenant.
3. Go to **Directory → Groups → Add Group** and create a group with a Group Rule so membership updates automatically — mirroring your Entra ID dynamic group setup.
4. Go to **Applications → Browse App Catalog** and add a sample SAML application to the group.
5. Go to **Security → Authentication Policies** to configure MFA/step-up requirements.

**Verify:** the end-user dashboard shows the app tile, and opening it enforces the MFA prompt.

## Tools

- **GitHub account** — every project publishes here.
- **Microsoft Graph PowerShell SDK** — `Install-Module Microsoft.Graph -Scope CurrentUser` (needed for Project 02 and PIM automation).
- A **draw.io / diagrams.net** account is optional — this portfolio uses Mermaid diagrams instead, which GitHub renders natively with no external tooling.

## A note on scope

Never use a work or production tenant for any of these labs, and never run simulated attacks (Project 04) against anything you don't own.
