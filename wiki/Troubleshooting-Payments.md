# Troubleshooting Payment Problems

## General Payment Diagnosis

Ask the customer:
1. **What payment processor?** (Stripe, PayPal, Mollie, Razorpay, Paystack)
2. **What payment method?** (credit card, bank transfer, wallet, etc.)
3. **What's the exact error message?**
4. **Is this a new purchase or a recurring payment (subscription renewal)?**
5. **What country are they in?** (some processors have regional limitations)

## Test Mode vs. Live Mode

**Most common issue:** Payment processor is in test mode, or customer is using test credentials on a live checkout.

**How to check:**
- SureCart Admin → Settings → Payment Processors
- Look for "Test Mode" indicator
- Test mode payments use test card numbers (e.g., Stripe's `4242 4242 4242 4242`)

**Fix:** Toggle the processor to live mode, or use test card numbers if testing.

## Stripe Issues

### Card declined
**Common decline codes:**
| Code | Meaning | Customer action |
|------|---------|----------------|
| `card_declined` | Generic decline | Contact bank or try another card |
| `insufficient_funds` | Not enough balance | Use a different card |
| `expired_card` | Card is expired | Use a valid card |
| `incorrect_cvc` | Wrong CVC/CVV | Re-enter the 3-digit code on the back |
| `processing_error` | Stripe processing issue | Wait and retry |
| `authentication_required` | 3D Secure needed | Complete the authentication popup |

### 3D Secure / SCA (Strong Customer Authentication)
**Symptoms:** Payment fails with "authentication required" or popup doesn't appear
**Common causes:**
- Browser popup blocker preventing the 3DS iframe
- Mobile browser not supporting the 3DS flow
- Card issuer requiring 3DS but checkout not handling it
**Fix:**
- Disable popup blockers
- Try a different browser
- If 3DS popup appears but fails, the card issuer is declining — contact bank

### Currency mismatch
**Symptoms:** "Currency not supported" or unexpected amounts
**Fix:** Ensure the product price currency matches the Stripe account's supported currencies

### Stripe account not fully set up
**Symptoms:** "Account not activated" errors
**Fix:** Customer's Stripe account needs to complete onboarding at dashboard.stripe.com

## PayPal Issues

### "PayPal window closes immediately"
**Common causes:**
- PayPal account not properly connected in SureCart settings
- Browser blocking the PayPal popup
- PayPal account restricted or suspended
**Fix:**
- Re-connect PayPal in SureCart settings
- Disable popup blockers
- Check PayPal account status at paypal.com

### "PayPal payment pending"
**Cause:** PayPal sometimes holds payments for review (especially new accounts)
**Fix:** This is a PayPal-side issue. Customer should check their PayPal account status.

### Currency not supported by PayPal
**Fix:** Verify the product price currency is in PayPal's supported currencies list

## Mollie Issues

### Payment method not showing
**Cause:** Mollie enables payment methods per account. The method may not be activated.
**Fix:** Customer needs to activate the payment method in their Mollie dashboard.

### Redirect loop after payment
**Cause:** Webhook URL or redirect URL misconfigured
**Fix:** Check SureCart → Settings → Payment Processors → Mollie connection

## Razorpay Issues

### "Payment failed" on Indian cards
**Common causes:**
- UPI/netbanking timeout (customer didn't complete in time)
- RBI compliance issues
**Fix:** Customer should retry; ensure they complete the bank verification within the time limit

### International cards failing
**Cause:** Razorpay account may not have international payments enabled
**Fix:** Enable international payments in the Razorpay dashboard

## Paystack Issues

### "Transaction failed"
**Common causes:**
- Card not supported (Paystack primarily supports Nigerian banks)
- Transaction limit exceeded
**Fix:** Check Paystack dashboard for the specific decline reason

## Subscription Renewal Payment Failures

If a recurring payment fails:
1. The subscription enters `past_due` status
2. SureCart/the processor will retry automatically (typically 3-4 times over 1-2 weeks)
3. After all retries fail, the subscription is canceled

**See also:** [Subscription Issues](Troubleshooting-Subscriptions)

## Escalation Criteria

Escalate to engineering when:
- Payment was charged but SureCart shows no record of it
- A payment processor integration error (not a customer card issue)
- Consistent failures across multiple customers with the same processor
- 3D Secure flow is broken for all customers (not just one card)
