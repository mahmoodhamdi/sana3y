# City Launch Playbook

This is the operator's day-by-day plan for taking the platform from
"signed license" to "running marketplace with paying customers." Use it as a
template; adapt to your city's reality.

> A note on scope: we ship the platform. *You run the operations.* This
> playbook is advice from prior launches, not contractual deliverables.

## Week 0 — Setup (before launch)

### Day 1: Deployment
- Provision VPS (Hetzner CX22 or DO 8GB)
- Run `apply-branding.sh` with your `branding.yaml`
- Get the apps building and the admin dashboard loading on your branded domain
- Don't open it to the public yet — `DEMO_MODE=true`

### Day 2-3: Recruit founding craftsmen
- Goal: 20-30 craftsmen across all 10 categories by end of week
- Tactics that have worked:
  - Door-to-door visits in industrial / artisan neighborhoods. Bring printed
    flyers. Most craftsmen sign up on the spot if you walk them through
    onboarding on their phone.
  - Local Facebook groups: "بسبوسة في طنطا"-style community groups have
    surprisingly good response rates.
  - Mosque after-Friday-prayer announcements (works in conservative areas;
    coordinate with the imam).
  - Existing trusted figures: hardware shop owners often know every plumber
    and electrician in the area. They'll refer for a small commission.

### Day 4-5: Onboard craftsmen
- Help each craftsman take a clear profile photo + 3-5 work-sample photos.
- Make sure their KYC docs (national ID front+back) are scanned cleanly.
- Approve them in the admin dashboard.
- WhatsApp them a 1-minute video showing how the craftsman app works.

### Day 6-7: Test runs
- Use your own friends/family as the first customers. Have them book real
  small jobs (a faucet fix, a paint touch-up).
- Run through the whole flow: request → quote → accept → completion → payment
  → rating. Watch for friction.
- Fix UX issues in the admin settings (broken category names, wrong default
  commission, etc.). Anything code-level — file as a support ticket.

## Week 1-2 — Soft launch

### Goal: 100 paying customers, 200+ requests

- Switch `DEMO_MODE=false`, set `SMS_PROVIDER` and `PAYMENT_PROVIDER` to real values
- Open the app to the city's "early adopters" — your network, founding craftsmen's
  customers, neighborhood WhatsApp groups
- Launch a referral promo: "First-time customer: free 50 EGP off". Track
  redemption rate in the admin's `/categories` / promo codes page.
- Set up a customer service WhatsApp number (yours, or a hire). Aim for sub-1-hour
  response time during this phase.
- Watch the admin dashboard daily. Disputes should be addressed within 24 hours.

## Week 3-4 — Official launch

### Goal: 500+ active customers, regular daily request flow

- Local press release (if your city has a regional paper, especially in Delta
  governorates — they often publish small-business launches for free).
- Mosque flyer campaign — print 2,000 A5 flyers, distribute after Friday
  prayer at 5 large mosques. Cost: ~1,500 EGP. Conversion: ~3-5%.
- Facebook ads, hyperlocal targeting: target users 25-55 in a 15 km radius
  around your city center. Budget: 500-1,000 EGP/day for the first 2 weeks,
  scale based on CPA. Aim for cost-per-install of 3-7 EGP and cost-per-first-
  request of 25-50 EGP.
- Onboard 50-100 more craftsmen — by now your reputation should make this
  easier than the first batch.

## Month 2 — Optimization

- Look at completion rate by category. Anything below 60% means craftsmen in
  that category are not delivering. Investigate.
- Look at average response time. Craftsmen averaging > 30 min response should
  be sent a coaching WhatsApp.
- Run an NPS survey on completed jobs. Target: > 40.
- Audit your top 10 craftsmen — interview them, find out what works. Use
  their stories in marketing.

## Month 3 — Expansion

- Add 1-2 neighboring towns or villages to your service area. This is a `branding.yaml`
  change: bump `service_radius_km` or add the new town's coordinates to a
  custom zone (admin dashboard → zones).
- Hire 1-2 city operations staff if request volume justifies it (rule of thumb:
  1 person per 1,000 active monthly customers).
- Consider a B2B pitch: small property management companies in your city need
  reliable maintenance services and will pay slightly above retail for SLA.

## KPIs to track from day one

Numbers we have seen at comparable launches in mid-sized Egyptian cities:

| Metric | Month 1 | Month 3 | Month 6 |
|--------|--------:|--------:|--------:|
| Active craftsmen | 20-30 | 60-100 | 100-200 |
| Active monthly customers | 100-300 | 500-1,200 | 1,500-3,500 |
| Completed jobs / month | 80-200 | 400-800 | 1,000-2,500 |
| GMV (EGP) | 25,000-60,000 | 140,000-280,000 | 350,000-1,000,000 |
| Commission @ 15% (EGP) | 3,750-9,000 | 21,000-42,000 | 52,500-150,000 |
| NPS | 20-30 | 35-45 | 45-55 |
| Completion rate | 65-75% | 75-82% | 82-88% |
| Dispute rate | < 5% | < 3% | < 2% |
| Avg craftsman response time | 25-45 min | 15-25 min | 10-15 min |

A city that hasn't crossed 500 active customers by month 3 is usually under-invested
in marketing or has a craftsman-quality problem. Talk to us — we have specific
diagnostics from other operators that often help.

## Marketing budgets we recommend

| Tier | Month 1 | Month 2-3 | Month 4-6 |
|------|--------:|----------:|----------:|
| Starter | 8,000-15,000 EGP | 15,000-30,000 EGP | 25,000-50,000 EGP |
| Pro | 25,000-40,000 EGP | 40,000-80,000 EGP | 75,000-150,000 EGP |
| Enterprise | 80,000-150,000 EGP | 150,000-300,000 EGP | 300,000-600,000 EGP |

These are operating budgets, not part of your license fee.

## Common pitfalls

1. **Approving craftsmen too fast.** Spend 15 minutes on each KYC. Once a bad
   craftsman ships, your trust hit lasts months.
2. **Forgetting to monitor disputes.** A single ignored dispute that ends up
   on Facebook can cost you 500+ would-be customers.
3. **Not closing the loop with craftsmen.** Pay out wallets weekly, on time,
   no exceptions. Late payouts kill the supply side.
4. **Cutting marketing too early.** Most cities that quit before month 3
   would have hit profitability by month 5. Plan a 6-month marketing runway.
5. **Trying to be national too fast.** Dominate one city before you bid for
   the next governorate.
