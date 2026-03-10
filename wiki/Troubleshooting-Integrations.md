# Troubleshooting Integration Issues

## How Integrations Work

SureCart integrations follow a simple pattern:

1. **Purchase created** → `surecart/purchase_created` action fires → integration **grants access**
2. **Purchase revoked** (refund/cancellation) → `surecart/purchase_revoked` action fires → integration **revokes access**
3. **Purchase invoked** (re-activated) → `surecart/purchase_invoked` action fires → integration **re-grants access**

Each integration maps SureCart products to the third-party service's content (courses, groups, memberships, etc.).

## General Diagnosis

Ask the customer:
1. **Which integration?** (LearnDash, BuddyBoss, MemberPress, etc.)
2. **What's not working?** (access not granted, not revoked, or wrong access)
3. **Did the purchase complete?** (check SureCart admin for the order)
4. **When did they purchase?** (is the purchase recent or old?)

## Common Issues (All Integrations)

### Access not granted after purchase

**Check 1: Did the purchase actually complete?**
- SureCart Admin → Orders → look for the order
- If no order exists, the checkout didn't complete (see [Checkout Issues](Troubleshooting-Checkout))

**Check 2: Is the integration enabled?**
- SureCart → Integrations → is the integration active?

**Check 3: Is the product mapped?**
- SureCart → Integrations → click the integration
- Is the SureCart product mapped to the correct course/group/etc.?

**Check 4: Is the integration plugin active?**
- WP Admin → Plugins → is LearnDash/BuddyBoss/etc. activated?

**Check 5: Did the webhook process?**
- The integration triggers via webhook events
- See [Webhook Failures](Troubleshooting-Webhooks) if webhooks aren't working

**Check 6: Is the WordPress user linked?**
- The integration grants access to a WordPress user
- The customer must be linked to a WP user (happens during checkout confirmation)
- If the customer has no linked WP user, access can't be granted

### Access not revoked after refund/cancellation

Same checks as above, but for the `purchase_revoked` event.

**Additional check:** Was the refund processed through SureCart? If refunded directly in Stripe/PayPal without going through SureCart, the revocation event may not fire.

### Wrong access level granted

**Cause:** Usually a mapping issue — the wrong product is mapped to the wrong content
**Fix:** Review the integration mapping in SureCart → Integrations

## LearnDash Specific

### Course access not granted
- Is the LearnDash course published and not in draft?
- Is the SureCart product mapped to the correct LearnDash course?
- Is the student's WordPress user account created?

### Course progress reset after renewal
- This shouldn't happen — renewals don't reset progress
- If it does, escalate as a potential bug

### Group enrollment not working
- Is the LearnDash Group feature enabled?
- Is the product mapped to a Group (not just a Course)?

## BuddyBoss Specific

### Group access not granted
- Is the BuddyBoss group created and active?
- Is the product mapped to the correct group?
- Is the user's BuddyBoss profile created?

### Access persists after cancellation
- Check if the `purchase_revoked` webhook fired
- BuddyBoss group removal may not trigger immediately — check Action Scheduler

## MemberPress Specific

### Membership not activated
- Is the MemberPress membership level configured?
- Is the product mapped to the correct membership?
- Are there conflicting MemberPress rules?

## WordPress User Role Integration

### User role not assigned after purchase
- Is the role mapping configured in SureCart → Integrations?
- Does the target role exist in WordPress?
- Is the user already assigned a higher-priority role?

### User role not removed after revocation
- WordPress doesn't have a standard "remove role" mechanism
- The integration typically sets the user back to "Subscriber" role
- Check the integration settings for the revocation role

## Manual Re-sync

If an integration is out of sync:
1. Go to SureCart Admin → the customer's purchases
2. The purchase should show the integration status
3. Some integrations have a "re-sync" or "re-process" option
4. If not, the admin may need to manually grant access in the third-party service

## Escalation Criteria

Escalate to engineering when:
- Integration hook (`purchase_created`/`purchase_revoked`) fires but the integration code errors out
- Mapping is correct but access is still not granted/revoked
- Integration works for some products but not others with identical configuration
- Access is being granted to the wrong user
- Integration causes PHP fatal errors
