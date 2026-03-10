# Troubleshoot

Guided diagnostic workflow for customer issues.

## When to use
When a support team member describes a customer problem and needs help diagnosing it.

## Instructions

Follow this step-by-step diagnostic process:

### Step 1: Classify the Issue
Based on the description, classify into one of:
- **Checkout** — can't complete purchase, form errors, stuck states
- **Payment** — declined, processor errors, currency issues
- **Webhook** — data not syncing, events not firing, integration not triggering
- **Subscription** — renewal failures, cancellation issues, upgrade/downgrade problems
- **Integration** — LearnDash, BuddyBoss, etc. not granting/revoking access
- **Account/Auth** — login issues, customer-user sync problems
- **Other** — describe and investigate

### Step 2: Check the Runbook
Search the wiki docs in `.repos/surecart-support.wiki/` for the matching troubleshooting page:
- Checkout → `Troubleshooting-Checkout.md`
- Payment → `Troubleshooting-Payments.md`
- Webhook → `Troubleshooting-Webhooks.md`
- Subscription → `Troubleshooting-Subscriptions.md`
- Integration → `Troubleshooting-Integrations.md`

Read the relevant runbook and follow its diagnostic steps.

### Step 3: Search Code & Docs
Search the codebase for the specific error, function, or flow mentioned:
- Search `surecart-wp/` for plugin-side code
- Search `surecart/` for platform-side code
- Search `surecart-docs/` for official documentation
- Use the surecart-docs MCP for additional doc searches

### Step 4: Provide Resolution
Give the support person:
1. **What's likely happening** — plain English explanation
2. **What to check** — specific things to verify with the customer
3. **How to fix** — step-by-step resolution
4. **If that doesn't work** — escalation path

### Step 5: Escalation Check
If the issue requires engineering attention, clearly state:
- Why it needs escalation
- What information to include in the escalation
- Suggested priority level
