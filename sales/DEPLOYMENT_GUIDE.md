# Sana3y Deployment Guide

This guide covers two deployment variants:

- **Variant A — You self-host** on infra you own/rent
- **Variant B — We manage** infra on your behalf

You can always start with A and migrate to B (or vice versa) later.

---

## Variant A — Self-hosted

### Minimum infrastructure

| Component | Requirement | Recommended |
|-----------|-------------|-------------|
| OS | Ubuntu 22.04 LTS or Debian 12 | Ubuntu 24.04 LTS |
| CPU | 4 vCPU | 8 vCPU |
| RAM | 8 GB | 16 GB |
| Disk | 80 GB SSD | 200 GB NVMe |
| Network | 100 Mbps, public IPv4 | 1 Gbps + IPv6 |
| Domain | Required | Custom subdomain + apex |

Suggested providers and approximate monthly costs for a small-city deployment:

| Provider | Plan | Monthly |
|----------|------|---------|
| Hetzner Cloud | CX22 → CX42 | €5 → €17 |
| DigitalOcean | s-4vcpu-8gb | $48 |
| Vultr | High-Frequency 4 vCPU | $48 |
| Linode | Dedicated 8 GB | $36 |
| AWS Lightsail | 8 GB instance | $40 |

### Required services

- **MongoDB 7** (replica set for transactions + change streams)
  - Self-hosted via `docker run mongo:7 --replSet rs0` — fine for ≤ 5K MAU
  - Or MongoDB Atlas Free Tier (M0, 512 MB) — fine for the first 3 months
  - Migrate to Atlas Shared (M10, $57/month) when GMV stabilises
- **Redis 7** (used for rate-limiting and queues)
  - `docker run redis:7-alpine` — single instance is enough for a single city
- **Nginx + Let's Encrypt** for TLS termination
- **PM2** or `systemd` for process management

### External services to register

| Service | Purpose | Free tier? |
|---------|---------|------------|
| Cloudinary | Image hosting + transformations | Yes — 25 GB storage / month |
| Firebase | FCM push notifications | Yes — unlimited push, limited Auth quotas |
| Paymob | Card + wallet payments | No — KYB required, 2.75% per txn |
| Fawry | Cash-at-outlet collection | No — merchant agreement required |
| Unifonic / VictoryLink / Mnaswer | Egyptian SMS | No — pay-per-SMS |
| Resend | Transactional email | Yes — 100 emails/day on free tier |

If you don't have Paymob/Fawry yet, set `PAYMENT_PROVIDER=mock` in
`backend/.env` so the platform can run end-to-end demos before real payments
are wired up.

### Deployment steps (Variant A)

```bash
# 1. SSH to your VPS
ssh you@vps.example.com

# 2. Install Docker + Docker Compose, Node 20+, Nginx
curl -fsSL https://get.docker.com | sudo bash
sudo apt update && sudo apt install -y nodejs npm nginx certbot python3-certbot-nginx

# 3. Clone your branded copy (we will provide a private repo or zipped archive)
git clone <your-private-repo> sana3y
cd sana3y

# 4. Apply branding (uses config/branding.yaml)
./scripts/apply-branding.sh

# 5. Bring up Mongo + Redis
docker compose up -d mongo redis

# 6. Backend
cd backend
npm ci --omit=dev
npm run build
npm run seed:all     # seed base data + demo augmentation
pm2 start dist/index.js --name sana3y-backend

# 7. Admin dashboard
cd ../admin-dashboard
npm ci
npm run build
pm2 start npm --name sana3y-admin -- run start

# 8. Nginx reverse-proxy + TLS
sudo cp deploy/nginx/sana3y.conf /etc/nginx/sites-available/
sudo ln -s /etc/nginx/sites-available/sana3y.conf /etc/nginx/sites-enabled/
sudo certbot --nginx -d api.yourcity.app -d admin.yourcity.app

# 9. Mobile app
cd ../mobile
flutter pub get
flutter build apk --release --split-per-abi
flutter build appbundle --release    # for Play Store
# (iOS build requires a Mac — see mobile-build.md)
```

### Production hardening checklist

- [ ] Set `NODE_ENV=production` in `backend/.env`
- [ ] Set `DEMO_MODE=false`
- [ ] Rotate `JWT_SECRET`, `JWT_REFRESH_SECRET` — use `openssl rand -hex 32`
- [ ] Rotate `NEXTAUTH_SECRET`
- [ ] Set `SMS_PROVIDER` and `PAYMENT_PROVIDER` to your real providers
- [ ] Configure MongoDB authentication (`docker exec ... mongosh --eval "db.createUser(...)"`)
- [ ] Set up daily MongoDB backups (`mongodump | gzip > backup-$(date +%F).gz`)
- [ ] Enable Cloudflare in front of the domain (optional but recommended — DDoS + CDN)
- [ ] Turn on `gh dependabot` on the private GitHub repo for security patches
- [ ] Configure crash reporting in the Flutter app (Firebase Crashlytics)
- [ ] Set up uptime monitoring (UptimeRobot free tier or Better Stack)

### Backup strategy

Daily incremental MongoDB dump to your operator's storage:

```bash
# /etc/cron.daily/sana3y-backup
docker exec sana3y-mongo mongodump --archive --gzip > /backups/sana3y-$(date +%F).gz
find /backups -name 'sana3y-*.gz' -mtime +30 -delete
```

For Cloudinary: rely on Cloudinary's own backups. We do not advise downloading
the entire image set unless you intend to migrate off Cloudinary.

---

## Variant B — Managed by us

You give us a domain and credentials for Cloudinary + Paymob + SMS provider.
We host the stack on our infra (DigitalOcean droplets + MongoDB Atlas) and
keep it running.

Pricing:

| Tier | Monthly |
|------|---------|
| Hosting + backup + monitoring | 1,500 EGP / month |
| Hosting + Silver support (24h response) | 4,500 EGP / month |
| Hosting + Gold support (4h response, monthly call) | 9,000 EGP / month |

What we manage:
- VPS, MongoDB (Atlas), Redis, Nginx, Let's Encrypt renewal
- Daily backups to S3
- Patch & dependency updates
- Cloudflare DNS
- Uptime monitoring + on-call response

What stays yours:
- Cloudinary account + billing
- Payment provider (Paymob/Fawry) account + funds settlement
- SMS provider account + credit top-ups
- The branded mobile app on the stores (you maintain the developer accounts)
- The data — we can export full MongoDB snapshots to you on request

You can cancel managed hosting at any time with 30 days notice. We hand you
an `archive.tar.gz` containing the full database + Cloudinary asset URLs and
you can migrate to Variant A.

---

## Migration: A → B

We provide a migration script:

```bash
./scripts/migrate-to-managed.sh --domain yourcity.app --license-id LCN-12345
```

It packages the MongoDB dump, the `.env` files, and any custom branding
assets, and uploads them to our staging environment. We then cut over the DNS
and you're live on managed infra within 48 hours.

## Migration: B → A

```bash
./scripts/export-from-managed.sh --license-id LCN-12345
```

Produces `sana3y-export-<date>.tar.gz` containing MongoDB dump, `.env` files,
and a fresh checkout of the branded source code.
