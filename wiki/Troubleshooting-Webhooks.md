# Troubleshooting Webhook Failures

## How Webhooks Work in SureCart

1. Something happens on the platform (purchase created, subscription renewed, etc.)
2. Platform sends an HTTP POST to the WordPress plugin's webhook endpoint
3. Plugin validates the signature (HMAC-SHA256)
4. Payload is stored in the `surecart_incoming_webhooks` database table
5. Processed asynchronously via Action Scheduler
6. Fires WordPress actions (e.g., `surecart/purchase_created`)
7. Integrations listen to these actions and do their thing

## Prerequisites for Webhooks

- **SSL required:** Webhooks only work on sites with HTTPS (SSL certificate). They are skipped on HTTP/localhost.
- **Site must be publicly accessible:** The platform needs to reach the WordPress site
- **Action Scheduler must be running:** Uses WP cron or the Action Scheduler system

## Common Issues

### Webhooks not firing at all

**Check 1: Is the site on HTTPS?**
- Webhooks require SSL. If the site is on HTTP, webhooks won't register.
- Fix: Install an SSL certificate (most hosts offer free Let's Encrypt)

**Check 2: Is the site publicly accessible?**
- Staging sites behind password protection or VPNs can't receive webhooks
- Fix: Temporarily remove access restrictions, or whitelist SureCart's IPs

**Check 3: Is SureCart properly connected?**
- WP Admin → SureCart → Settings → check the API connection
- If disconnected, webhooks won't be registered

**Check 4: Firewall blocking webhook requests?**
- Security plugins (Wordfence, Sucuri) may block incoming POST requests
- Fix: Whitelist the SureCart webhook endpoint in the firewall rules

### Webhooks received but not processing

**Check 1: Action Scheduler working?**
- Go to WP Admin → Tools → Scheduled Actions (or Action Scheduler)
- Look for pending/failed SureCart actions
- If there are many "pending" actions, WP cron may not be running

**Check 2: WP Cron disabled?**
- Some hosts disable WP Cron (`DISABLE_WP_CRON` in wp-config.php)
- If disabled, a system cron must be set up to call wp-cron.php
- Fix: Set up a real cron job, or re-enable WP Cron

**Check 3: PHP errors during processing?**
- Check the site's PHP error log for fatal errors during webhook handling
- A fatal error during processing will leave the webhook in a failed state

### Webhook signature validation failures

**Symptoms:** "Invalid signature" errors in logs
**Common causes:**
- Webhook secret changed or mismatched
- Proxy/load balancer modifying the request body
- WAF (Web Application Firewall) stripping headers

**Fix:**
- Re-connect SureCart to refresh the webhook secret
- Check if a CDN/proxy is modifying POST request bodies
- Whitelist the webhook endpoint in the WAF

### Integrations not triggering after webhook

**Symptoms:** Webhook is received and processed, but LearnDash/BuddyBoss/etc. doesn't grant access
**Common causes:**
- Integration not properly configured (product not mapped)
- Integration plugin not active
- Integration listening for wrong event

**What to check:**
- SureCart → Integrations — is the integration enabled?
- Is the product mapped to the correct course/group/etc.?
- Is the integration plugin installed and active?

See also: [Integration Issues](Troubleshooting-Integrations)

## Key Webhook Events

| Event | When it fires |
|-------|--------------|
| `purchase_created` | New purchase completed |
| `purchase_revoked` | Purchase refunded or reversed |
| `purchase_invoked` | Purchase re-activated |
| `purchase_updated` | Purchase details changed |
| `subscription_renewed` | Subscription billing cycle completed |
| `customer_updated` | Customer details changed |
| `account_updated` | Store/account settings changed |

## Debugging Steps

1. **Check webhook logs:** SureCart admin may show webhook delivery status
2. **Check Action Scheduler:** WP Admin → Tools → Scheduled Actions
3. **Check PHP error log:** Look for fatal errors during webhook processing
4. **Check the platform:** The SureCart dashboard may show webhook delivery attempts and failures
5. **Test with a new purchase:** Create a test purchase to see if the webhook fires

## Escalation Criteria

Escalate to engineering when:
- Webhook signature validation consistently fails (not a configuration issue)
- Webhooks are received but Action Scheduler silently drops them
- Platform shows webhooks as delivered but WordPress never receives them
- A specific webhook event type consistently fails while others work
