# Trace Flow

Trace how a feature works through the SureCart codebase end-to-end.

## When to use
When a support team member needs to understand how a specific feature or process works internally, to better diagnose issues or explain behavior to customers.

## Instructions

### Step 1: Identify the Flow
Determine which flow to trace. Common flows:
- Checkout process (draft → finalize → purchase)
- Subscription renewal
- Webhook processing
- Integration sync (purchase → grant access)
- Customer-user linking
- Payment processing
- Coupon/discount application

### Step 2: Trace the Plugin Side
Search `.repos/surecart-wp/` for:
- **Entry point** — REST controller, block, or hook that starts the flow
- **Processing** — services, models, and middleware involved
- **Output** — what happens at the end (redirect, webhook, integration trigger)

### Step 3: Trace the Platform Side
Search `.repos/surecart/` for:
- **API endpoint** — controller handling the request
- **Business logic** — services processing the request
- **Side effects** — webhooks fired, emails sent, etc.

### Step 4: Present the Flow
Explain the flow as a numbered sequence in plain English:
1. What triggers it
2. What happens at each step
3. What can go wrong at each step
4. What the end result is

Use simple language. Avoid code jargon. Think of it as explaining "what happens when a customer clicks Pay" to someone who doesn't write code.

Include file paths for reference, but focus the explanation on the behavior, not the code.
