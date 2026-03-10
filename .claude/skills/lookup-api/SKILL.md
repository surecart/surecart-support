# Lookup API

Look up SureCart API endpoint documentation.

## When to use
When a support team member needs to understand an API endpoint, its parameters, or expected behavior.

## Instructions

### Step 1: Identify the Resource
Determine which API resource the user is asking about (e.g., checkouts, products, subscriptions, customers, orders, etc.)

### Step 2: Search Documentation
1. Use the surecart-docs MCP server to search for the endpoint
2. Search `.repos/surecart-docs/` for relevant documentation files
3. Search `.repos/surecart/` for the platform-side controller/route definitions

### Step 3: Search Plugin Code
Search `.repos/surecart-wp/app/src/Models/` for the matching model to understand:
- The API endpoint URL
- Available query parameters
- How the plugin calls this endpoint

### Step 4: Present the Information
Provide in a clear, non-technical format:
- **Endpoint** — what it does in plain English
- **Common parameters** — what can be filtered/sorted
- **Common errors** — what goes wrong and why
- **Related endpoints** — other endpoints often used together

Keep explanations simple — the audience is support staff, not developers.
