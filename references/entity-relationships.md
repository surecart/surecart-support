# Entity Relationships

```
Account (the shop/store)
├── Product → Price → Variant
├── Customer ↔ WordPress User (linked during checkout)
│     └── Payment Method (saved cards, etc.)
├── Checkout → Line Items → Purchase
│     ├── Discount (from Coupon or Promotion)
│     ├── Shipping Choice
│     └── Payment Intent → Charge
├── Order (created from finalized Checkout)
│     └── Fulfillment
├── Subscription → Period (billing cycle)
├── Invoice
├── License → Activation
└── Affiliation → Referral
```
