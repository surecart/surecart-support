# Usage Guide

## Starting the Assistant

**Mac:** Open Terminal and type `sc-support`
**Windows:** Double-click "SureCart Support" on your Desktop

The assistant automatically updates all code and docs before starting (takes ~3 seconds).

## Asking Questions

Just type your question in plain English:

- "Customer says their checkout is stuck on the payment screen"
- "What happens when a subscription renewal fails?"
- "How do I help a customer change their payment method?"
- "What does error code `checkout.finalize.payment_failed` mean?"
- "Customer using Stripe says their payment was declined but their card works elsewhere"

## Using Slash Commands

Type these commands for guided workflows:

| Command | What it does |
|---------|-------------|
| `/troubleshoot` | Walks you through diagnosing a customer issue step by step |
| `/lookup-api` | Looks up API endpoint documentation |
| `/search-docs` | Searches the SureCart help docs |
| `/trace-flow` | Traces how a feature works through the code |

### Examples
- `/troubleshoot` → then describe the customer's issue
- `/lookup-api subscriptions` → looks up subscription API docs
- `/search-docs how to add a coupon` → searches docs for coupon info
- `/trace-flow checkout finalization` → traces the checkout process

## Tips for Getting Better Answers

1. **Be specific**: "Checkout fails after entering credit card" is better than "checkout broken"
2. **Include error messages**: Copy-paste any error codes or messages the customer sees
3. **Mention the payment processor**: "Stripe", "PayPal", "Mollie", etc.
4. **Mention the integration**: "LearnDash", "BuddyBoss", "MemberPress", etc.
5. **Ask follow-up questions**: The assistant remembers your conversation

## Ending a Session

- Type `/clear` to start a fresh conversation (keeps the session open)
- Press `Ctrl + C` to exit completely
- On Windows, just close the window

## When to Escalate

The assistant will tell you when to escalate, but in general, escalate when:
- The issue involves a data inconsistency between the plugin and platform
- A bug is confirmed in the code
- The issue requires a code fix, not a configuration change
- The customer is a high-priority account and needs immediate help
