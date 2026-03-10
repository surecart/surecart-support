# Troubleshooting Subscription Issues

## Subscription Lifecycle

```
active → past_due → canceled
                  → trialing (if trial period)
                  → paused (if pause enabled)
```

- **Active:** Payment current, subscription running normally
- **Past Due:** Payment failed, retrying automatically
- **Canceled:** Subscription ended (by customer, admin, or failed payments)
- **Trialing:** In free trial period, no charges yet
- **Paused:** Temporarily paused by customer or admin

## Common Issues

### Subscription shows "Past Due"

**What's happening:** The latest renewal payment failed. The system will retry automatically.

**Retry schedule:** Typically 3-4 attempts over 1-2 weeks (varies by payment processor)

**What to tell the customer:**
1. Their card on file may have expired or been declined
2. They should update their payment method in the customer portal
3. The subscription will automatically retry with the new payment method

**How to update payment method:**
- Customer portal → Subscriptions → click the subscription → Update Payment Method
- Or: SureCart admin → Customers → find customer → edit payment method

### Subscription not renewing

**Check 1:** Is the subscription status "active"? (not canceled or paused)
**Check 2:** Is the payment method valid and not expired?
**Check 3:** Is the payment processor connected and in the correct mode?
**Check 4:** Are webhooks working? (renewal is triggered by the platform, not WordPress)

See: [Webhook Failures](Troubleshooting-Webhooks) if webhooks aren't processing

### Customer can't cancel subscription

**Common causes:**
- Cancellation is disabled in SureCart settings
- The customer portal page is missing or misconfigured
- JavaScript error on the portal page

**What to check:**
- SureCart → Settings → Customer Portal → is cancellation enabled?
- Is the customer portal page published and accessible?
- Can the customer log into their account?

**Admin workaround:** Cancel from SureCart admin → Subscriptions → find and cancel

### Upgrade/Downgrade not working

**What happens during an upgrade/downgrade:**
1. Customer selects new plan in the portal
2. Proration is calculated (credit for unused time on current plan)
3. New plan price is charged (minus proration credit)
4. Subscription updated to new plan

**Common issues:**
- **Proration confusion:** Customer sees an unexpected charge amount (explain proration)
- **Plan not available:** The target price/plan may be archived or not configured for switching
- **Payment fails:** Upgrade requires a payment for the price difference, which can fail

### Subscription access not granted/revoked

This is an integration issue. When a subscription is:
- **Created/renewed** → `purchase_created` fires → integrations grant access
- **Canceled/expired** → `purchase_revoked` fires → integrations revoke access

If access isn't changing, see [Integration Issues](Troubleshooting-Integrations)

### Customer charged but subscription shows canceled

**This is serious — possible data inconsistency.**

**Quick check:**
1. Check the payment processor dashboard (Stripe/PayPal) — was the payment actually captured?
2. Check SureCart admin — is there an order/charge for this amount?
3. Check webhook logs — did the renewal webhook fail to process?

**If the charge exists but subscription is canceled:** This may be a webhook processing failure. The renewal event from the platform may not have been processed by WordPress.

**Escalate if:** Payment was captured but the subscription status wasn't updated.

### Trial period issues

**Trial not starting:** Check if the price has a trial period configured on the platform
**Trial ending early:** Trial end date is set when the subscription is created and doesn't change
**Charged during trial:** This shouldn't happen — escalate if a customer is charged during an active trial

## Subscription Billing Cycle

- Billing happens on the platform (api.surecart.com), not in WordPress
- WordPress is notified via webhooks after each billing event
- The plugin fires `surecart/subscription_renewed` after processing the webhook

## Escalation Criteria

Escalate to engineering when:
- Customer charged but subscription status not updated
- Proration calculation appears incorrect
- Trial period ending at the wrong time
- Subscription stuck in a state that can't be resolved through admin
- Cancellation processed but customer still being charged
