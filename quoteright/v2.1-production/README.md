# QuoteRight v2.1 production foundation

This folder contains the backend/data foundation for moving QuoteRight from browser-only MVP storage to a real SaaS.

## Architecture
- Next.js App Router for the production application.
- Supabase Auth for account sessions.
- Supabase Postgres for profiles, customers and quotes.
- Row Level Security ensures users can only access their own records.
- Netlify can deploy the Next.js application with the standard `next build` / `.next` settings.

## Required setup
1. Create a Supabase project.
2. Run `schema.sql` in the Supabase SQL Editor.
3. Add `NEXT_PUBLIC_SUPABASE_URL` and `NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY` to the deployment environment.
4. Build the Next.js application against these tables.
5. Add billing credentials only after the account/database flow is tested.

No credentials, secrets, or production customer data belong in GitHub.
