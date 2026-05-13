# Branding Kit Guide

Sana3y is built so that **one file** controls the per-city identity of the
deployment:

```
config/branding.yaml
```

Everything that visibly changes between "Sana3y Tanta" and "Sana3y Riyadh" —
name, colors, currency, default coordinates, language priority, payment
provider, SMS provider — flows from this file into the backend, the admin
dashboard, and the Flutter app.

## How it works

1. You edit `config/branding.yaml` to set your city's values.
2. You run `./scripts/apply-branding.sh`.
3. The script writes:
   - `backend/.env` overrides (provider selectors, commission rates)
   - `admin-dashboard/.env.local` (`NEXT_PUBLIC_APP_NAME`)
   - `mobile/lib/config/branding.dart` (a generated Dart file pulled in by
     `main.dart` and `theme.dart`)
   - `mobile/pubspec.yaml` description
   - `admin-dashboard/package.json` name
4. You re-build the three components.
5. You drop your `logo.png`, `splash.png`, `favicon.ico` into `./branding/`.
6. Done — your fresh checkout is now "Sana3y <YOUR CITY>".

## What you can customize without code changes

| Field | Drives | Example values |
|-------|--------|----------------|
| `brand.name_ar` / `brand.name_en` | App title in both stores, splash text, email signatures | "صنايعي طنطا" / "Sana3y Tanta" |
| `brand.primary_color` | Theme primary color across all 3 components | `#1E88E5` |
| `brand.accent_color` | Buttons, badges, highlights | `#FFA000` |
| `brand.tagline_ar/en` | App store description, landing-page hero | "كل الصنايعية في إيدك" |
| `region.center_lat/lng` | Default map center, geo-search origin | 30.7865, 31.0004 (Tanta) |
| `region.service_radius_km` | How far craftsmen can be from the customer | 15 |
| `locale.primary` | Default app language | `ar-EG`, `ar-SA`, `en-US` |
| `currency.code` | Pricing, wallet, finance reports | `EGP`, `SAR`, `AED`, `KWD` |
| `sms.provider` | Which SMS adapter to load | `unifonic`, `victorylink`, `mnaswer`, `twilio` |
| `payment.provider` | Which payment adapter to load | `paymob`, `fawry`, `vodafone_cash`, `mock` |
| `payment.enabled_methods` | Which options the customer sees at checkout | `paymob`, `vodafone_cash`, `fawry`, `cash_on_completion` |
| `business.commission_pct` | Commission deducted on each completed job | `15`, `20`, `10` |

## What you can customize *with* a customization request

(Available in the Pro tier as one of your included custom features, or as an
add-on at any tier.)

- Adding a service category that doesn't exist by default
  (e.g. "Marine Engines" for a coastal city, "Snow Plowing" for a mountain town)
- Changing the request lifecycle — e.g. adding a "site visit" stage
- Integrating with a local accounting / e-invoicing system
- Removing the chat feature and replacing it with WhatsApp deep-links
- Adding a referral / loyalty system
- Adding a B2B account type (commercial customers with separate billing)

## Asset specifications

| Asset | Size | Format | Notes |
|-------|------|--------|-------|
| `logo.png` | 1024×1024 or larger | PNG, transparent BG | Used on stores + splash |
| `logo-dark.png` | Same | PNG | Used in dark-mode UIs |
| `splash.png` | 2732×2732 (square) | PNG | Apps render it at the device aspect |
| `favicon.ico` | 32×32, 16×16 layered | ICO | For admin dashboard |
| App store screenshots (per platform) | iPhone 6.7" 1290×2796; Pixel 1080×2400 | PNG | At least 4 each |
| Marketing posters (optional) | A3 — 3508×4961 | PDF, RGB or CMYK | We can produce these as an add-on |

## Multi-language

`locale.supported` accepts any combination of:
`ar-EG`, `ar-SA`, `ar-AE`, `ar-KW`, `en-US`, `en-GB`, `fr-FR`.

By default Arabic Egyptian (`ar-EG`) is the primary language and the app is RTL.
For Gulf-market deployments, switch the primary to `ar-SA` — the strings update
to use Gulf-Arabic phrasing where it differs (`Sana3y` already ships with both
dictionaries).

## Things you cannot rename without code changes

- The system role names `customer`, `craftsman`, `admin` (used in code paths).
  You can change the **display labels** but not the internal identifiers.
- The base API path `/api/v1/...` — changeable, but breaks any external
  integrations that already use it.

## Example: brand-new city in 15 minutes

```bash
# 1. Clone your private branded repo
git clone git@github.com:youroperator/sana3y-tanta.git
cd sana3y-tanta

# 2. Open config/branding.yaml and update:
#    - brand.name_ar / name_en / short_code: "tanta"
#    - region.city_ar / city_en, center_lat: 30.7865, center_lng: 31.0004
#    - brand.primary_color, accent_color
#    - brand.domain: "tanta.sana3y.app"

# 3. Drop your logo + splash into ./branding/

# 4. Apply
./scripts/apply-branding.sh

# 5. Build and deploy (per DEPLOYMENT_GUIDE.md)
```

Most of the 15 minutes is filling in `branding.yaml`. The script itself runs
in under 5 seconds.
