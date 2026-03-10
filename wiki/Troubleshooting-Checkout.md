# Troubleshooting Checkout Issues

## How Checkout Works

The checkout is a multi-step process with a state machine:

```
draft → updating → finalizing → paying → confirming → paid → confirmed → redirecting
```

**Terminal/error states:** `expired`, `locked`, `test_mode_restricted`, `failure`

Each state transition can fail. The key is identifying WHERE the checkout got stuck.

## Quick Diagnosis

Ask the customer:
1. **What screen are they on?** (form, payment, blank page, error message)
2. **What error do they see?** (copy the exact message)
3. **What payment method?** (credit card, PayPal, etc.)
4. **What browser?** (Chrome, Safari, Firefox, etc.)

## Common Issues by State

### Stuck on "Draft" — Form won't load
**Symptoms:** Blank checkout form, spinner that never stops, "Unable to load checkout"
**Common causes:**
- JavaScript error on the page (conflicting plugin or theme)
- API token not configured (SureCart not connected to an account)
- Product or price is archived/deleted
**What to check:**
- Is SureCart connected? (WP Admin → SureCart → Settings)
- Is the product still active on the platform?
- Are there JavaScript errors in the browser console? (Right-click → Inspect → Console tab)

### Stuck on "Updating" — Can't fill in fields
**Symptoms:** Fields don't respond, "updating" never finishes, timeout errors
**Common causes:**
- Network connectivity issues between the site and api.surecart.com
- Server timeout settings too low
- Caching plugin caching API responses
**What to check:**
- Can the site reach api.surecart.com? (try accessing from server)
- Is there a caching plugin? (disable and retry)
- Are server timeouts reasonable? (at least 30 seconds)

### Stuck on "Finalizing" — Clicked Pay but nothing happens
**Symptoms:** "Processing" spinner that never stops, no error shown
**Common causes:**
- Payment processor timeout
- 3D Secure/SCA popup blocked by browser
- JavaScript error during finalization
- Payment method validation failure
**What to check:**
- Is 3D Secure required for this card/region? (popup may be hidden)
- Any browser extensions blocking scripts?
- Check browser console for errors

### Fails at "Paying" — Payment declined
**Symptoms:** Error message about payment failure
**Common causes:** See [Payment Problems](Troubleshooting-Payments) runbook
**Quick checks:**
- Is the payment processor in test mode vs. live mode?
- Is the card/PayPal account valid?
- Is the currency supported by the processor?

### Fails at "Confirming" — Payment went through but no confirmation
**Symptoms:** Payment charged but customer sees error, no order created
**This is critical — escalate if:**
- Customer was charged but no purchase was created
- This is a data inconsistency issue
**What to check:**
- Check the SureCart admin for the order
- Check the payment processor dashboard (Stripe, PayPal) for the charge
- The confirmation step links the Customer to a WordPress User — user creation may have failed

### "Expired" state
**Cause:** Checkout session timed out (left open too long without activity)
**Fix:** Customer needs to start a new checkout. This is expected behavior.

### "Locked" state
**Cause:** Checkout is being processed and is temporarily locked to prevent duplicate submissions
**Fix:** Wait a moment and refresh. If stuck, the lock may have failed to release — escalate.

### "Test mode restricted" state
**Cause:** Trying to use test payment methods on a live checkout, or vice versa
**Fix:** Ensure the checkout mode matches the payment processor mode

## Browser-Specific Issues

### Safari — Checkout doesn't load
**Cause:** Safari's strict privacy settings can block cross-origin requests
**Fix:** Customer should try disabling "Prevent cross-site tracking" in Safari settings, or use Chrome

### Mobile browsers — Layout broken
**Cause:** Stencil web components may not render correctly on older mobile browsers
**Fix:** Check if the customer's browser is up to date

## Plugin/Theme Conflicts

Checkout issues are often caused by:
- **Caching plugins** caching dynamic checkout pages (WP Super Cache, W3 Total Cache, etc.)
- **Security plugins** blocking API requests (Wordfence, Sucuri, etc.)
- **Optimization plugins** minifying/combining JS incorrectly (Autoptimize, WP Rocket JS)
- **Theme JavaScript** conflicting with checkout components

**How to test:** Ask the customer (or their developer) to:
1. Switch to a default theme (Twenty Twenty-Four)
2. Disable all plugins except SureCart
3. Try the checkout again
4. If it works, re-enable plugins one by one to find the conflict

## Escalation Criteria

Escalate to engineering when:
- Payment was charged but no purchase/order was created
- Checkout enters an unexpected state not listed above
- Issue is reproducible with all plugins disabled and a default theme
- Issue only happens on a specific PHP or WordPress version
