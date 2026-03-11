# Webhook System

- Platform sends webhooks to the plugin when events happen (purchase created, subscription renewed, etc.)
- Webhooks require SSL (won't work on localhost/HTTP)
- Signature validation uses HMAC-SHA256
- Processed asynchronously via Action Scheduler
- Key events: `purchase_created`, `purchase_revoked`, `subscription_renewed`, `customer_updated`

# Integration System

When a purchase is created → plugin grants access in connected services (LearnDash courses, BuddyBoss groups, etc.)
When a purchase is revoked → plugin revokes that access.
