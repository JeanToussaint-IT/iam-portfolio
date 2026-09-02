# Design Decisions — Zero Trust Identity Lab

Write these as you build, not after — interviewers ask "why did you choose that," and reconstructed reasoning sounds reconstructed. Each prompt below is a decision the lab guide asks you to make; replace the `[ TODO ]` with your own reasoning once you've actually made the call.

## Why a break-glass account, and why it's the one exception to everything else

[ TODO — the break-glass account is intentionally the opposite of every other pattern in this lab: standing, permanent Global Admin access with no MFA gate and no time-boxing. Explain why that contradiction is correct: break-glass must not depend on the JIT/CA system it exists to rescue you from. ]

## Why dynamic group membership over manual

[ TODO — explain why you chose a dynamic rule (e.g. `user.department -eq "Post-Production"`) instead of manually adding members. Hint: it scales without a human remembering to update it, and it ties access directly to identity data quality. ]

## Why a hand-authored custom role instead of a built-in role

[ TODO — explain why "VM Restart Operator" (start/restart only, no delete) is more defensible than assigning Contributor. What could Contributor do that this use case didn't justify? ]

## Why the scope was the resource group, not the subscription

[ TODO — the single most common real-world over-permissioning mistake is assigning at the wrong scope. Explain how you verified the assignment landed at `rg-post-production` and not higher, and what `Check access` showed. ]

## Why every Conditional Access policy was built and validated in Report-only mode first

[ TODO — explain the risk Report-only mode avoids (tenant-wide lockout from an untested policy), and what you looked for in the Conditional Access tab of the sign-in logs before flipping each policy to On. ]

## Why Eligible (not Active) for the PIM role assignment

[ TODO — explain the difference between Eligible and Active assignments, and why granting standing Active access would have defeated the point of this entire project. ]

## What I'd do differently with more time

[ TODO — e.g. Graph automation for group/role assignment, Identity Protection risk-based policies, scheduled access reviews for the custom role. ]
