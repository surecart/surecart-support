# Common Error Codes

## Checkout Errors

| Error Code | Meaning | Common Cause | Resolution |
|------------|---------|-------------|------------|
| `checkout.not_found` | Checkout session doesn't exist | Expired or invalid checkout ID | Start a new checkout |
| `checkout.expired` | Checkout session timed out | Customer left the page open too long | Start a new checkout |
| `checkout.locked` | Checkout being processed | Double-click on pay button | Wait and refresh |
| `checkout.finalize.failed` | Finalization failed | Various — check sub-error | See specific error below |
| `checkout.finalize.payment_failed` | Payment was declined | Card declined, insufficient funds | Try another payment method |
| `checkout.finalize.validation_failed` | Form validation failed | Missing required fields | Fill in all required fields |
| `checkout.finalize.price_not_found` | Product price missing | Price archived or deleted | Check product configuration |
| `checkout.already_finalized` | Checkout already completed | Duplicate submission | Check for existing order |

## Payment Errors

| Error Code | Meaning | Common Cause | Resolution |
|------------|---------|-------------|------------|
| `payment.declined` | Payment was declined | Card issue | Contact bank or try another card |
| `payment.authentication_required` | 3D Secure needed | Card requires verification | Complete the 3DS popup |
| `payment.processor_error` | Processor-side error | Temporary processor issue | Wait and retry |
| `payment.currency_not_supported` | Currency mismatch | Product currency vs processor | Check processor currency settings |
| `payment.amount_too_small` | Amount below minimum | Below processor minimum (usually $0.50) | Increase the price |
| `payment.amount_too_large` | Amount above maximum | Above processor limit | Split into multiple transactions |

## Subscription Errors

| Error Code | Meaning | Common Cause | Resolution |
|------------|---------|-------------|------------|
| `subscription.not_found` | Subscription doesn't exist | Invalid subscription ID | Check the subscription ID |
| `subscription.canceled` | Already canceled | Customer or system canceled | Cannot resume a canceled subscription |
| `subscription.renewal_failed` | Renewal payment failed | Payment method expired/declined | Update payment method |
| `subscription.upgrade_failed` | Plan change failed | Payment for difference failed | Check payment method |

## Webhook Errors

| Error Code | Meaning | Common Cause | Resolution |
|------------|---------|-------------|------------|
| `webhook.signature_invalid` | Signature mismatch | Secret changed or body modified | Re-connect SureCart |
| `webhook.delivery_failed` | Couldn't reach the site | Site down, firewall, or no SSL | Check site accessibility |
| `webhook.processing_failed` | PHP error during processing | Plugin/theme conflict | Check PHP error logs |
| `webhook.timeout` | Processing took too long | Slow server or heavy processing | Check server performance |

## API Errors

| Error Code | Meaning | Common Cause | Resolution |
|------------|---------|-------------|------------|
| `unauthorized` | Invalid API token | Token expired or wrong | Re-connect SureCart |
| `forbidden` | No permission | Account doesn't have access | Check account permissions |
| `not_found` | Resource not found | Invalid ID or deleted | Verify the resource exists |
| `rate_limited` | Too many requests | Excessive API calls | Wait and reduce request frequency |
| `validation_error` | Invalid data | Required field missing or wrong format | Check the error details for specifics |
| `server_error` | Platform error | Internal platform issue | Wait and retry; escalate if persistent |

## Integration Errors

| Error Code | Meaning | Common Cause | Resolution |
|------------|---------|-------------|------------|
| `integration.not_configured` | Integration not set up | Missing mapping or connection | Configure in SureCart → Integrations |
| `integration.plugin_not_active` | Partner plugin inactive | LearnDash/etc. not activated | Activate the plugin |
| `integration.access_grant_failed` | Couldn't grant access | Content doesn't exist or user missing | Check content and user mapping |
| `integration.access_revoke_failed` | Couldn't revoke access | User not in the system | Check user exists in partner plugin |

## Customer/User Errors

| Error Code | Meaning | Common Cause | Resolution |
|------------|---------|-------------|------------|
| `customer.not_found` | Customer doesn't exist | Invalid customer ID | Check the customer ID |
| `customer.email_exists` | Email already in use | Duplicate account | Log in with existing account |
| `customer.user_link_failed` | Couldn't link to WP user | User creation failed | Check WP user settings |

## How to Use This Reference

1. Get the exact error code or message from the customer
2. Look it up in the tables above
3. Follow the resolution steps
4. If the resolution doesn't work, use `/troubleshoot` for guided diagnosis
5. If still unresolved, escalate to engineering with:
   - The exact error code
   - Steps to reproduce
   - Customer's account info (email, store URL)
   - Payment processor being used
   - Browser and device info
