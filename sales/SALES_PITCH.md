# Sana3y — اشترِ نسخة المنصة لمدينتك / Own Your City's Marketplace

> صنايعي منصة مكتملة جاهزة تربط العملاء بالحرفيين المحليين، بتطبيق موبايل
> للعملاء وآخر للصنايعية ولوحة تحكم متكاملة للإدارة. بتشتري نسخة كاملة
> لمدينتك أو محافظتك، تطلقها بعلامتك التجارية، وتكسب من العمولة.

> A complete, ready-to-deploy marketplace connecting customers with local craftsmen.
> Mobile apps for customers and craftsmen, an admin dashboard for operations.
> You buy a fully-branded copy for your city, launch it, and earn the commission.

---

## المشكلة / The Problem

في كل مدينة مصرية ومدينة عربية فيه نفس المشكلة:

- العميل بيدوّر على سبّاك أو كهربائي أو نجار، بيسأل الجيران، يطلع رقم مش بيرد.
- لما حد يرد، السعر "ع المزاج"، مفيش ضمان، مفيش طريقة يقيّم الشغل.
- الصنايعي الشاطر بيخسر شغل لأن مفيش حد بيوصله لزباين جداد.
- المسوقين والوسطاء بياخدوا 30-50% من السعر بدون ما يقدّموا قيمة حقيقية.

In every Egyptian and Arab city, the same problem repeats:

- Customers struggle to find a trusted plumber, electrician, or carpenter.
- Pricing is opaque. Quality has no signal. There's no recourse if work goes wrong.
- Skilled craftsmen lose work because they have no path to new customers.
- Middlemen take 30-50% of the price without adding real value.

## الحل / The Solution

منصة جاهزة فيها:

| للعميل | للصنايعي | للمشغّل (أنت) |
|----------|------------|----------------|
| تطبيق Flutter بـ Material 3 RTL | نفس التطبيق بـ role-switch | Next.js admin dashboard |
| Browse + search + geo (OpenStreetMap مجاناً) | KYC، طلبات واردة، تسعير، Wallet | KYC review queue، Disputes، Audit log |
| OTP authentication | Toggle online/offline | Financial reports + commission |
| Real-time chat + status (Socket.io) | Withdrawal flow | Broadcast notifications |
| تقييمات ومراجعات | تقييمات من العملاء | Promo codes, settings |
| Multiple payment methods | Earnings + history | RBAC + 2FA |

A ready-made platform that comes with:

| For Customers | For Craftsmen | For You (operator) |
|---------------|---------------|---------------------|
| Flutter app, Arabic-first RTL | Same app, role-switched | Next.js admin dashboard |
| Browse, search, geo-locate (free OSM) | KYC, inbound jobs, quote, wallet | KYC queue, disputes, audit log |
| OTP auth | Online/offline toggle | Financial reports + commission |
| Real-time chat + status updates | Withdrawal requests | Broadcast notifications |
| Rate & review | Reviews from customers | Promo codes, settings |
| Multiple payment options (Paymob, Fawry, Vodafone Cash, InstaPay, cash) | Earnings + history | Role-based admin + 2FA |

## ليه نسخة لكل مدينة؟ / Why one copy per city?

- **العميل في المنصورة مش هياخد ميجا-تطبيق وطني**، بياخد تطبيق "صنايعي المنصورة" — أسرع، أوضح، أقرب.
- **التشغيل المحلي بيكسب**: أنت اللي بتعرف الناس، أنت اللي بتجمع الصنايعية الأوّلين، أنت اللي بتروّج محلياً.
- **العمولة كلها ليك**. مفيش شركة أم بتاخد %20 فوقك. بتشتري نسخة واحدة وخلاص.

- **Local works.** A customer in Mansoura doesn't want a national mega-app. They want
  "Sana3y Mansoura" — closer, faster, more recognizable.
- **You own the operations.** You know the city, you recruit the first craftsmen,
  you handle local marketing.
- **You keep the commission.** No parent company taking a cut. You buy the
  platform once.

## النموذج الاقتصادي / Unit Economics

افتراض محافظ لمدينة 200K-500K نسمة في السنة الأولى:

| Metric | Conservative | Base | Optimistic |
|--------|--------------|------|------------|
| Active craftsmen (month 6) | 50 | 120 | 250 |
| Completed jobs / month | 200 | 600 | 1,500 |
| Avg ticket size (EGP) | 250 | 350 | 450 |
| Monthly GMV (EGP) | 50,000 | 210,000 | 675,000 |
| Commission @ 15% (EGP) | 7,500 | 31,500 | 101,250 |
| Operator yearly commission | 90,000 | 378,000 | 1,215,000 |

أرخص tier (Starter 75,000 EGP) بيستردّ في 10 شهور في السيناريو المحافظ، وفي 3 شهور
في السيناريو الأساسي.

The cheapest tier (Starter, 75,000 EGP) pays itself back in ~10 months under
the conservative scenario, and ~3 months under the base case.

## الفرق بيننا وبين البديل / What we save you

| البديل | التكلفة | الوقت | المخاطر |
|--------|---------|--------|---------|
| Build from scratch | 300,000-1,000,000 EGP | 12-18 شهر | High — معماري، توظيف، product-market fit |
| Mr Usta franchise | غير متاح | — | فيهم عمولة فوقك |
| Generic SaaS marketplace builder | Monthly SaaS fees forever | 3-6 شهور | Generic UX، مفيش لوكاليزيشن مصري |
| Sana3y license | 75,000-1,000,000 EGP one-time | 48 ساعة-أسبوع | Low — منتج موجود ومُختبر |

| Alternative | Cost | Time | Risk |
|-------------|------|------|------|
| Build it yourself | $10k-$35k | 12-18 months | High — architecture, hiring, PMF |
| Mr Usta franchise | N/A in Egypt | — | They keep commission |
| Generic SaaS marketplace | Monthly forever | 3-6 months | Generic UX, no Egyptian localization |
| Sana3y license | $2.5k-$33k one-time | 48 hours-1 week | Low — proven product |

## كيف تبدأ / How to get started

1. اختار tier من [`CITY_LICENSE_PRICING.md`](./CITY_LICENSE_PRICING.md).
2. ابعت إيميل لـ `sales@sana3y.app` فيه: المدينة، الـ tier، وطريقة الإطلاق (سيلف
   هوست أو نحن نشغّل).
3. خلال 48 ساعة بنرجع لك بـ deployment plan + branding kit + training schedule.

1. Pick a tier from [`CITY_LICENSE_PRICING.md`](./CITY_LICENSE_PRICING.md).
2. Email `sales@sana3y.app` with: city, tier, hosting preference (self-hosted or managed).
3. Within 48 hours we ship deployment plan + branding kit + training schedule.

See also:
- [`CITY_LICENSE_PRICING.md`](./CITY_LICENSE_PRICING.md) — tier breakdown
- [`DEPLOYMENT_GUIDE.md`](./DEPLOYMENT_GUIDE.md) — infrastructure options
- [`BRANDING_KIT_GUIDE.md`](./BRANDING_KIT_GUIDE.md) — how the white-label config works
- [`SUPPORT_PLANS.md`](./SUPPORT_PLANS.md) — what's included after the sale
- [`CITY_LAUNCH_PLAYBOOK.md`](./CITY_LAUNCH_PLAYBOOK.md) — go-to-market plan
- [`COMPETITIVE_POSITIONING.md`](./COMPETITIVE_POSITIONING.md) — why us
- [`HANDOVER_CHECKLIST.md`](./HANDOVER_CHECKLIST.md) — what changes hands on signing
