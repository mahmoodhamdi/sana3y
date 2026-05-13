# Handover Checklist

What changes hands when a license is signed and the deployment goes live.

## 1. Source code

- [ ] You receive a private GitHub repository (e.g. `youroperator/sana3y-yourcity`)
      forked from the upstream `sana3y` product repository at the version
      named in your license.
- [ ] You receive Owner access to that repo.
- [ ] Your developers (if any) receive Collaborator access at your direction.
- [ ] The repository contains the full backend + mobile + admin source code,
      build configuration, and CI workflows.

The license grants you perpetual use of the source code for the specified
city/territory. It does not grant you the right to resell to other cities
unless you have the Regional Master tier.

## 2. Branded assets

- [ ] `config/branding.yaml` filled in with your city's values
- [ ] Your logo, splash screen, favicon dropped into `branding/`
- [ ] `./scripts/apply-branding.sh` run successfully — all three components
      now display your brand
- [ ] App store screenshots prepared (you provide raw assets, we render
      the screenshots if your tier includes that)

## 3. Credentials transfer

Every credential below moves from us to you (or is created in your name):

- [ ] GitHub repo Owner access
- [ ] Hosting provider account (DigitalOcean / Hetzner / your choice)
- [ ] Domain registrar + DNS access (Cloudflare account recommended)
- [ ] MongoDB Atlas account (or self-hosted, your choice)
- [ ] Cloudinary account in your name
- [ ] Firebase project + service account
- [ ] Paymob merchant account
- [ ] SMS provider account (Unifonic / VictoryLink / Mnaswer / Twilio)
- [ ] Resend account for transactional email
- [ ] Apple Developer account (your DUNS, your tax info)
- [ ] Google Play Console account (your tax info)

Where credentials must be passed (e.g. API keys we used during deployment), we
transfer them via a one-time-view secret link (1Password Send or equivalent) and
delete our copies after you confirm receipt.

## 4. Documentation handover

- [ ] `README.md` reviewed
- [ ] `DEMO_ACCOUNTS.md` reviewed — demo credentials documented
- [ ] `DEPLOYMENT_GUIDE.md` for your hosting variant
- [ ] Operator-facing admin guide (Arabic + English, separate document we
      provide when the tier includes training)
- [ ] Customer-facing FAQ template (your team customises)
- [ ] Craftsman onboarding kit (PDF + WhatsApp message templates)

## 5. Acceptance criteria

The deployment is considered "accepted" when ALL of the following pass:

- [ ] Customer signs up via the mobile app on your branded build, receives an
      OTP, verifies, and creates a request.
- [ ] Craftsman signs up, completes KYC, gets approved by you in the admin
      dashboard, and receives the customer's request as a notification.
- [ ] Craftsman sends a quote, customer accepts, status transitions through
      `accepted` → `in_progress` → `completed`.
- [ ] Customer rates the job; rating appears on the craftsman's profile.
- [ ] You (admin) see the transaction in `/finance` with the correct
      commission split.
- [ ] You (admin) approve a craftsman from the pending KYC queue.
- [ ] You (admin) view the audit log and see your own admin actions recorded.
- [ ] `https://api.yourcity.app/health/ready` returns 200.
- [ ] Mobile app builds (APK + AAB for Android, IPA for iOS if applicable).

You sign an acceptance form and the second payment becomes due.

## 6. Warranty period

The first 30 days after acceptance is a warranty window:

- Any defect that prevents the platform from meeting one of the acceptance
  criteria above is fixed at no charge.
- Issues caused by your operational changes (e.g. accidentally deleting
  records, breaking the database while editing it directly) are out of scope.

After 30 days, you are on your support plan (Bronze/Silver/Gold/Platinum per tier).

## 7. Training

You receive training scoped to your tier:

| Tier | Training |
|------|----------|
| Starter | 1 day, remote, recorded. Topics: admin dashboard, KYC review, dispute basics |
| Pro | 3 days. Day 1 admin operations, Day 2 craftsman recruitment, Day 3 marketing kit walkthrough |
| Enterprise | 5 days. Adds 1 day on app store + ASO, 1 day on financial reports |
| Regional Master | 7 days, optionally on-site in your city, plus a roadmap planning day |

Sessions are recorded so your team can refer back. Slides are in Arabic + English.

## 8. Operator onboarding (your first 30 days)

We do not run your operations, but we recommend the following day-by-day plan
documented separately in [`CITY_LAUNCH_PLAYBOOK.md`](./CITY_LAUNCH_PLAYBOOK.md).

## 9. Sign-off

- [ ] License agreement signed (PDF, both parties)
- [ ] Payment 1 (50%) received
- [ ] Deployment + branding complete
- [ ] Training delivered
- [ ] Acceptance criteria all pass
- [ ] Payment 2 (50%) received
- [ ] Handover documented in `HANDOVER_RECORD.md` (we maintain a copy, you get
      a copy)
