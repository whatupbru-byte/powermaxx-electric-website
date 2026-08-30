# QuoteRight Pre-Launch

## Product
- Free project estimate calculator
- Contractor dashboard
- Quotes and customer records
- Search/filter-ready quote workflow
- Quote preview/print
- Pro plan positioning

## Production stack
- Next.js App Router + TypeScript
- Supabase Auth + Postgres + Row Level Security
- Stripe Checkout + Customer Portal + signed webhooks
- Netlify deployment
- Transactional email provider
- Analytics

## Required private configuration before launch
- Supabase project URL and publishable key
- Supabase database migration applied
- Auth redirect URLs configured
- Stripe production account and product/price IDs
- Stripe webhook endpoint + signing secret
- Netlify environment variables
- Email provider credentials/domain verification
- Analytics measurement ID
- Custom domain

## Billing rules
Stripe is the source of truth for subscription status. The app mirrors billing state in a protected database table for access checks and UI. Webhooks must be signature-verified.

## Launch gates
1. Test signup, logout, password reset.
2. Verify RLS with two separate test users.
3. Create/edit/delete quotes and customers.
4. Generate/print quote preview.
5. Complete Stripe test checkout and portal flow.
6. Test webhook events and subscription access changes.
7. Verify email delivery.
8. Run mobile/desktop QA.
9. Confirm analytics events.
10. Deploy production and verify custom domain/HTTPS.

## Revenue model
Free: calculator and limited saved quotes.
Pro: CAD $9.99/month with unlimited quotes, customers, branded documents and future automation features.

No production secret belongs in Git. Use deployment environment variables only.
