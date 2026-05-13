# Sana3y Demo Accounts

These accounts are seeded by `backend/src/scripts/seed.ts` and augmented by
`backend/src/scripts/seed-demo.ts`. They are intended for sales walkthroughs and
investor demos against the seeded demo database — not for production use.

To populate them locally:

```bash
cd backend
npm run seed:all     # base seed + demo augmentation
```

## Admin (Super Admin)

| Field    | Value                  |
|----------|------------------------|
| Email    | `admin@sana3y.com`     |
| Password | `Admin@123`            |
| Role     | `admin`                |
| Use for  | Dashboard, KYC queue, finance, audit log, broadcasts |

## Customer

| Field    | Value                       |
|----------|-----------------------------|
| Email    | `mohamed@example.com`       |
| Password | `Customer@123`              |
| Role     | `customer`                  |
| Use for  | Browse craftsmen, create requests, chat, rate jobs |

## Craftsman (verified, approved)

| Field    | Value                                |
|----------|--------------------------------------|
| Email    | `abdullah.plumber@example.com`       |
| Password | `Craftsman@123`                      |
| Role     | `craftsman`                          |
| Status   | `approved`                           |
| Use for  | Inbound jobs, send quotes, wallet, withdraw |

## Demo Craftsmen Pool (after `seed:demo`)

18 additional craftsmen are added with the email pattern
`craftsmanN@sana3y.demo` and password `Craftsman@123`, spread across all 10
service categories with locations jittered around الباجور (30.4522, 30.9667).
They are useful for showing list pagination, geo-search radius, and category
filters in the customer app.

## Notes for demos

- All passwords intentionally weak so the demo presenter can sign in quickly. Change
  these before exposing the deployment to the public internet.
- The default `DEMO_MODE=true` in `backend/.env` makes the SMS and payment
  providers fall back to mock so the demo can run without a real SMS or
  payment integration.
- To reset, re-run `npm run seed:all` — it clears users/requests/etc. and
  reseeds idempotently.
- The audit log starts with three sample admin actions (KYC approval, settings
  change, broadcast notification) so the audit-log page is not empty on first
  view.
