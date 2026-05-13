/**
 * seed-demo.ts — augments the base `seed.ts` output with the records demos and
 * investor walkthroughs need but the lean test-fixture seed does not produce:
 *
 *  - Additional craftsmen (12 → 30) with realistic Egyptian names and Bagour coords
 *  - Customer-side transactions (job_payment) and craftsman payouts
 *  - Withdrawal requests (pending + completed)
 *  - Audit-log entries showing admin activity
 *  - Demo broadcast notifications
 *
 * Safe to run repeatedly: it only ADDS — base entities seeded by `seed.ts` are kept.
 * Run order:  npm run seed  &&  npm run seed:demo
 */
import mongoose, { Types } from 'mongoose';
import bcrypt from 'bcryptjs';
import { config } from '../config';
import { User, Craftsman, ServiceCategory, ServiceRequest, Transaction } from '../models';
import AuditLog from '../models/AuditLog';
import { logger } from '../utils/logger';
import { calculateCommissionSplit } from '../services/wallet.service';

// Egyptian craftsman first names (real, common names in الباجور / المنوفية)
const FIRST_NAMES = [
  'محمد', 'أحمد', 'حسن', 'علاء', 'إبراهيم', 'طارق', 'خالد', 'شعبان',
  'رمضان', 'ربيع', 'السيد', 'عمر', 'يوسف', 'مصطفى', 'سامي', 'هاني',
  'وليد', 'كريم', 'مينا', 'بيشوي',
];

const LAST_NAMES = [
  'عبد الله', 'محمود', 'حسين', 'فتحي', 'إسماعيل', 'الشحات', 'الباجوري',
  'المنوفي', 'السيد', 'عبد الفتاح', 'عبد الحميد', 'فؤاد', 'صابر', 'النجار',
];

const KUNYAS_BY_CATEGORY: Record<string, string> = {
  plumbing: 'السباك',
  electrical: 'الكهربائي',
  carpentry: 'النجار',
  painting: 'النقاش',
  ac: 'فني التكييفات',
  aluminum: 'الألوميتال',
  appliances: 'فني الأجهزة',
  moving: 'النقل',
  cleaning: 'التنظيف',
  welding: 'الحداد',
};

// Plausible coordinates inside الباجور / محيط المنوفية
const BAGOUR_CENTER = { lat: 30.4522, lng: 30.9667 };
const jitter = (n: number, range: number) => n + (Math.random() - 0.5) * range;

function randomFromList<T>(list: T[]): T {
  return list[Math.floor(Math.random() * list.length)];
}

function generateEgyptianPhone(prefix?: string): string {
  const prefixes = ['010', '011', '012', '015'];
  const p = prefix ?? randomFromList(prefixes);
  let suffix = '';
  for (let i = 0; i < 8; i++) suffix += Math.floor(Math.random() * 10);
  return `+20${p.slice(1)}${suffix}`;
}

async function addCraftsmen(targetCount: number): Promise<number> {
  const current = await Craftsman.countDocuments({});
  if (current >= targetCount) {
    logger.info(`Craftsmen already at ${current}, target ${targetCount} — skipping`);
    return 0;
  }
  const categories = await ServiceCategory.find({}).limit(10).lean();
  if (categories.length === 0) {
    logger.warn('No categories — run base seed first');
    return 0;
  }
  const toAdd = targetCount - current;
  const hash = await bcrypt.hash('Craftsman@123', 10);
  let added = 0;
  for (let i = 0; i < toAdd; i++) {
    const category = categories[i % categories.length];
    const slug = (category.slug as string) ?? 'plumbing';
    const kunya = KUNYAS_BY_CATEGORY[slug] ?? '';
    const first = randomFromList(FIRST_NAMES);
    const last = randomFromList(LAST_NAMES);
    const displayName = kunya ? `${first} ${kunya}` : `${first} ${last}`;
    const email = `craftsman${current + i + 1}@sana3y.demo`;
    const phone = generateEgyptianPhone();
    const user = await User.create({
      name: `${first} ${last}`,
      email,
      password: hash,
      role: 'craftsman',
      isActive: true,
      isVerified: true,
      authProvider: 'email',
    });
    const totalRatings = Math.floor(Math.random() * 30);
    await Craftsman.create({
      userId: user._id,
      displayName,
      bio: `أعمل في مجال ${kunya || category.nameAr} منذ سنوات. أهتم بالشغل النضيف والمواعيد.`,
      whatsapp: phone,
      alternatePhone: phone,
      services: [
        {
          categoryId: category._id,
          experience: 3 + Math.floor(Math.random() * 12),
          priceType: 'quote',
          basePrice: 50 + Math.floor(Math.random() * 200),
        },
      ],
      location: {
        type: 'Point',
        coordinates: [jitter(BAGOUR_CENTER.lng, 0.08), jitter(BAGOUR_CENTER.lat, 0.08)],
      },
      status: 'approved',
      rating: Math.round((3.5 + Math.random() * 1.5) * 10) / 10,
      totalRatings,
      totalJobs: totalRatings + Math.floor(Math.random() * 50),
      completedJobs: Math.floor(Math.random() * 80),
      currentBalance: Math.floor(Math.random() * 2000),
      commission: 15,
      isAvailable: true,
    });
    added += 1;
  }
  logger.info(`Added ${added} demo craftsmen (total now ${current + added})`);
  return added;
}

async function addTransactions(): Promise<number> {
  const completedRequests = await ServiceRequest.find({ status: 'completed' })
    .populate('craftsmanId')
    .lean();
  let added = 0;
  for (const req of completedRequests) {
    const existing = await Transaction.countDocuments({
      requestId: req._id,
      type: 'job_payment',
    });
    if (existing > 0) continue;

    // Use the request price if present, else random.
    const gross = (req as { finalPrice?: number; price?: number }).finalPrice ??
      (req as { price?: number }).price ?? 100 + Math.floor(Math.random() * 900);
    const split = calculateCommissionSplit(gross);

    const customerTx = await Transaction.create({
      transactionNumber: `JOB-${Date.now()}-${added}-A`,
      type: 'job_payment',
      requestId: req._id,
      fromUserId: req.customerId,
      amount: gross,
      fee: split.platformFee,
      netAmount: gross,
      status: 'completed',
      paymentMethod: randomFromList(['paymob', 'vodafone_cash', 'fawry', 'cash']),
      processedAt: new Date(),
    });

    // Find the craftsman's userId
    const craftsmanDoc = req.craftsmanId
      ? await Craftsman.findById(req.craftsmanId).select('userId').lean()
      : null;
    if (craftsmanDoc) {
      await Transaction.create({
        transactionNumber: `PAY-${Date.now()}-${added}-B`,
        type: 'craftsman_payout',
        requestId: req._id,
        toUserId: craftsmanDoc.userId,
        amount: gross,
        fee: split.platformFee,
        netAmount: split.craftsmanPayout,
        status: 'completed',
        paymentMethod: 'wallet_credit',
        processedAt: new Date(),
        notes: `Commission ${split.commissionRate}% deducted`,
      });
    }

    added += 1;
  }
  logger.info(`Added ${added} demo transactions for completed requests`);
  return added;
}

async function addWithdrawals(): Promise<number> {
  const craftsmen = await Craftsman.find({ status: 'approved' })
    .select('userId')
    .limit(8)
    .lean();
  let added = 0;
  for (let i = 0; i < Math.min(5, craftsmen.length); i++) {
    const c = craftsmen[i];
    if (!c.userId) continue;
    const exists = await Transaction.findOne({
      fromUserId: c.userId,
      type: 'withdrawal',
    });
    if (exists) continue;
    await Transaction.create({
      transactionNumber: `WTH-${Date.now()}-${i}`,
      type: 'withdrawal',
      fromUserId: c.userId,
      amount: 200 + Math.floor(Math.random() * 800),
      fee: 0,
      netAmount: 200 + Math.floor(Math.random() * 800),
      status: i < 3 ? 'completed' : 'pending',
      paymentMethod: randomFromList(['bank_transfer', 'instapay', 'vodafone_cash']),
      processedAt: i < 3 ? new Date() : undefined,
      notes: 'Withdrawal request from craftsman wallet',
    });
    added += 1;
  }
  logger.info(`Added ${added} demo withdrawal records`);
  return added;
}

async function addAuditLogEntries(): Promise<number> {
  const exists = await AuditLog.countDocuments({});
  if (exists > 0) {
    logger.info(`AuditLog has ${exists} entries — skipping demo seed`);
    return 0;
  }
  const admin = await User.findOne({ role: 'admin' }).select('_id').lean();
  if (!admin) {
    logger.warn('No admin user found — skipping audit log seed');
    return 0;
  }
  const pendingCraftsmen = await Craftsman.find({ status: 'pending' }).limit(3).lean();
  const samples = [
    {
      actorUserId: admin._id as Types.ObjectId,
      actorRole: 'admin',
      action: 'POST /api/v1/admin/craftsmen/:id/approve',
      method: 'POST',
      path: '/api/v1/admin/craftsmen/' + (pendingCraftsmen[0]?._id ?? 'unknown') + '/approve',
      targetType: 'admin',
      targetId: String(pendingCraftsmen[0]?._id ?? ''),
      reason: 'KYC verified — national ID + work photos look good',
      status: 200,
    },
    {
      actorUserId: admin._id as Types.ObjectId,
      actorRole: 'admin',
      action: 'PUT /api/v1/admin/settings',
      method: 'PUT',
      path: '/api/v1/admin/settings',
      targetType: 'admin',
      payload: { commissionRate: 15 },
      reason: 'Confirmed default commission rate for the platform launch',
      status: 200,
    },
    {
      actorUserId: admin._id as Types.ObjectId,
      actorRole: 'admin',
      action: 'POST /api/v1/admin/notifications',
      method: 'POST',
      path: '/api/v1/admin/notifications',
      targetType: 'admin',
      payload: { title: 'افتتاح المنصة في الباجور', audience: 'all' },
      reason: 'Launch announcement broadcast',
      status: 201,
    },
  ];
  await AuditLog.insertMany(samples);
  logger.info(`Added ${samples.length} demo audit-log entries`);
  return samples.length;
}

async function run(): Promise<void> {
  try {
    await mongoose.connect(config.mongodb.uri);
    logger.info('Connected to MongoDB — augmenting with demo data');

    await addCraftsmen(30);
    await addTransactions();
    await addWithdrawals();
    await addAuditLogEntries();

    logger.info('='.repeat(50));
    logger.info('Demo augmentation complete');
    logger.info('='.repeat(50));
    await mongoose.disconnect();
    process.exit(0);
  } catch (err) {
    logger.error('Demo seed failed:', err);
    process.exit(1);
  }
}

run();
