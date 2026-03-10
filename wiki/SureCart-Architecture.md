# SureCart Architecture (Simplified)

## The Two-Part System

SureCart has two main parts that work together:

### 1. The Cloud Platform (`api.surecart.com`)
This is the **brain** — it stores all the important data:
- Products, prices, and variants
- Customers and their payment methods
- Orders and purchases
- Subscriptions and invoices
- Payment processing connections (Stripe, PayPal, etc.)

**Key point:** All transactional data lives here, NOT in WordPress.

### 2. The WordPress Plugin
This is the **face** — it handles everything the customer and admin sees:
- Checkout forms (where customers buy things)
- Product pages (where customers browse)
- Customer portal (where customers manage their account)
- Admin dashboard (where store owners manage their business)
- Integrations (connecting with LearnDash, BuddyBoss, etc.)

## How They Talk to Each Other

```
Customer's Browser ←→ WordPress Plugin ←→ SureCart Platform (api.surecart.com)
                                        ←→ Payment Processor (Stripe, PayPal, etc.)
```

1. **Customer visits the store** → WordPress renders the page
2. **Customer starts checkout** → Plugin creates a draft checkout on the platform
3. **Customer fills in details** → Each field update is sent to the platform
4. **Customer pays** → Platform processes payment through Stripe/PayPal/etc.
5. **Payment succeeds** → Platform creates the purchase and fires webhooks
6. **Plugin receives webhook** → Grants access in integrations (LearnDash, etc.)

## Key Concepts

### Checkout Flow
The checkout is the most complex part. It goes through these states:
1. **Draft** — checkout form loaded, nothing filled in yet
2. **Updating** — customer is filling in fields
3. **Finalizing** — customer clicked "Pay"
4. **Paying** — payment being processed
5. **Confirming** — payment confirmed, creating purchase
6. **Confirmed** — all done, redirecting to thank you page

### Webhooks
Think of webhooks as "notifications" from the platform to the plugin:
- "Hey, someone just made a purchase!" → Plugin grants integration access
- "Hey, a subscription just renewed!" → Plugin updates access
- "Hey, a purchase was refunded!" → Plugin revokes integration access

Webhooks require:
- HTTPS (SSL) — won't work on HTTP sites
- The site must be publicly accessible (not behind a password)
- Action Scheduler must be running (handles background processing)

### Integrations
Integrations connect SureCart to other plugins:
- **LearnDash** — grant course access when someone buys
- **BuddyBoss** — add to groups when someone buys
- **MemberPress** — activate membership when someone buys
- **WordPress roles** — change user role when someone buys

They all work the same way: purchase created → grant access, purchase revoked → revoke access.

### Customer ↔ WordPress User
When someone completes a checkout:
- If they already have a WordPress account (matching email), the SureCart customer is linked to it
- If they don't, a new WordPress account may be created
- This link is important because integrations grant access to the WordPress user

## Entity Relationships (What's Connected to What)

```
Store (Account)
│
├── Products
│   └── Prices (how much things cost)
│       └── Variants (different options like size, color)
│
├── Customers (linked to WordPress Users)
│   └── Payment Methods (saved cards, PayPal, etc.)
│
├── Checkouts → when completed, become:
│   ├── Orders (the transaction record)
│   ├── Purchases (what was bought — triggers integrations)
│   └── Subscriptions (recurring purchases)
│       └── Periods (each billing cycle)
│
├── Invoices (billing records)
│
├── Coupons & Promotions (discounts)
│
└── Licenses (for software products)
    └── Activations (where the license is used)
```

## Where to Find Things in the Code

| What | Where |
|------|-------|
| WordPress plugin | `surecart-wp/` |
| Platform (API) | `surecart/` |
| Plugin models (Products, Orders, etc.) | `surecart-wp/app/src/Models/` |
| REST controllers | `surecart-wp/app/src/Controllers/Rest/` |
| Checkout form components | `surecart-wp/packages/components/` |
| Block rendering | `surecart-wp/packages/blocks-next/` |
| Integrations | `surecart-wp/app/src/Integrations/` |
| Webhook handling | `surecart-wp/app/src/WordPress/Webhooks/` |
