# Frequently Asked Questions

## Setup & Usage

**Q: Do I need to be a developer to use this?**
No! The assistant is designed for support team members. Just type your question in plain English.

**Q: How do I update the tool?**
Updates are automatic. Every time you type `sc-support`, it pulls the latest version.

**Q: Can I break anything?**
No. The assistant is read-only. It cannot modify any files, code, or data.

**Q: How much does this cost?**
The tool uses our team's Claude subscription. There's no additional cost per person.

**Q: Can I use this on my phone or tablet?**
No, it requires a computer with a terminal/command line.

**Q: What if I get an error when launching?**
See [Troubleshooting Setup](Troubleshooting-Setup) for common issues and fixes.

**Q: How do I start a fresh conversation?**
Type `/clear` to reset the conversation context.

**Q: Can the assistant access customer data?**
No. It only reads code and documentation. Use the SureCart admin dashboard for customer data.

## Common Support Questions

**Q: Where is customer data stored?**
All customer data (orders, subscriptions, payments) is stored on `api.surecart.com`, NOT in WordPress. The WordPress plugin only handles the UI.

**Q: What payment processors does SureCart support?**
Stripe, PayPal, Mollie, Razorpay, and Paystack. Each has different capabilities.

**Q: How does the checkout flow work?**
1. Customer opens checkout form (WordPress plugin renders it)
2. Draft checkout is created on the platform
3. Customer fills in details (each field update is sent to the platform)
4. Customer clicks "Pay" → payment is processed → checkout is finalized
5. Purchase is created → webhooks fire → integrations trigger

**Q: What's the difference between a Checkout and an Order?**
A Checkout is the process (cart + payment). An Order is the result after successful payment.

**Q: How do webhooks work?**
When something happens on the platform (purchase created, subscription renewed, etc.), the platform sends a notification to the WordPress plugin. The plugin processes it and triggers integrations.

**Q: Why is a webhook failing?**
Common reasons: SSL certificate issues, site is down, firewall blocking, signature mismatch. Ask the assistant `/troubleshoot` for guided diagnosis.

**Q: How do integrations work (LearnDash, BuddyBoss, etc.)?**
When a purchase is created/revoked, the plugin grants/revokes access in the connected service. Each integration maps SureCart products to the service's content (courses, groups, etc.).
