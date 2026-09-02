# How to use this template

This repo is scaffolded around four flagship IAM lab projects, using the "universal repo structure" pattern below for every project. Delete this file once your repo is filled in — it's just instructions for you, not part of the portfolio.

## The rules that make a portfolio work

- Document the WHY as you build, not after — interviewers ask "why did you choose that," and reconstructed reasoning sounds reconstructed. Each project's `docs/design-decisions.md` has the specific prompts to answer as you go.
- Publish to GitHub publicly, with a README that opens with the business problem, not the tech stack.
- Screenshot every checkpoint as you go — screenshots are the proof-of-work that makes a write-up credible. Each project's `screenshots/README.md` lists exactly what to capture.
- Write one LinkedIn post per completed project — inbound recruiter interest from public, well-documented work is real and common.
- Never use a work or production tenant. Every project here runs in a free lab tenant (see `Setup/Environment-Setup.md`).

## Universal project structure

```
project-name/
├── README.md                 (problem → architecture → what's implemented)
├── docs/
│   ├── architecture.md       (Mermaid diagram — GitHub renders it live)
│   ├── design-decisions.md   (your WHY for every choice)
│   └── lab-guide.md          (phase-by-phase build steps + troubleshooting)
├── screenshots/               (proof of each checkpoint)
└── scripts/                   (any JSON, PowerShell, or config artifacts)
```

Use Mermaid syntax for diagrams inside `docs/architecture.md` — GitHub renders it as a live diagram with no external tooling, no image files to maintain, and it stays version-controlled alongside the code.

## Which project(s) to build

Build Project 01 (Zero Trust Identity Lab) first, always — it's the foundation every IAM role expects to see. Then pick **one** of Projects 02-04 based on your target role:

- **Project 02** (Automated Identity Lifecycle Pipeline) for automation/engineering titles.
- **Project 03** (Multi-Platform PAM Comparison) for PAM-specialist titles.
- **Project 04** (Incident Response Simulation) for SecOps-hybrid titles.

Two deep, well-documented projects beat four shallow ones. All four are scaffolded here so you can choose; completing all four isn't required for a strong portfolio.

## Workflow for each project

1. Do the lab in your free lab tenant (see `Setup/Environment-Setup.md`).
2. Take screenshots at each checkpoint listed in that project's `screenshots/README.md`.
3. Answer the prompts in `docs/design-decisions.md` as you go, not afterward.
4. Fill in the project's top-level `README.md` — problem, architecture link, what's implemented (check off the list), proof-it-works screenshots, design-decisions link.
5. Flip the status in the root `README.md`'s Projects table.
6. Write a LinkedIn post about it.

## Screenshots — a few tips

- Redact anything sensitive: real tenant names, real emails/usernames that aren't test accounts, subscription IDs, license keys. Crop or blur before committing.
- Prefer PNG. Keep filenames lowercase-with-hyphens.

## Push it to GitHub

```bash
cd iam-portfolio
git init
git add .
git commit -m "Initial IAM portfolio structure"
git branch -M main
git remote add origin https://github.com/<your-username>/iam-portfolio.git
git push -u origin main
```
