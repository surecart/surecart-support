# Checkout Flow

1. Customer opens checkout form → **Draft checkout** created
2. Customer fills in details → each field **updates** the draft
3. Customer clicks Pay → checkout enters **finalizing** state
4. Payment processed → checkout enters **paying** → **confirming**
5. Success → **Purchase created** → webhooks fire → integrations trigger
6. Customer redirected to confirmation page

**State machine:** `draft` → `updating` → `finalizing` → `paying` → `confirming` → `paid` → `confirmed` → `redirecting`
**Terminal/error states:** `expired`, `locked`, `test_mode_restricted`, `failure`

## Payment Processors

Supported: **Stripe**, **PayPal**, **Mollie**, **Razorpay**, **Paystack**, **Manual**
Each has different capabilities and error patterns.
