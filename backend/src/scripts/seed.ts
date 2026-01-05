import mongoose from 'mongoose';
import bcrypt from 'bcryptjs';
import dayjs from 'dayjs';
import { config } from '../config';
import {
  User,
  Customer,
  Craftsman,
  ServiceCategory,
  ServiceRequest,
  Review,
  Conversation,
  Message,
  Notification,
  Zone,
  Setting,
} from '../models';
import { logger } from '../utils/logger';

// ===================== CATEGORIES DATA =====================
// Icon URLs for categories
const ICON_BASE = 'https://cdn-icons-png.flaticon.com/512';
const categoryIcons = {
  plumbing: `${ICON_BASE}/3306/3306608.png`,
  electrical: `${ICON_BASE}/1973/1973706.png`,
  carpentry: `${ICON_BASE}/2474/2474465.png`,
  painting: `${ICON_BASE}/1973/1973709.png`,
  ac: `${ICON_BASE}/3309/3309973.png`,
  aluminum: `${ICON_BASE}/2830/2830313.png`,
  appliances: `${ICON_BASE}/2917/2917984.png`,
  moving: `${ICON_BASE}/3306/3306628.png`,
  cleaning: `${ICON_BASE}/2917/2917804.png`,
  welding: `${ICON_BASE}/2452/2452566.png`,
};

const categories = [
  {
    name: 'Plumbing',
    nameAr: 'سباكة',
    slug: 'plumbing',
    icon: categoryIcons.plumbing,
    description: 'All plumbing and water-related services',
    descriptionAr: 'جميع خدمات السباكة والمياه',
    sortOrder: 1,
    isPopular: true,
    subcategories: [
      { name: 'Drain Cleaning', nameAr: 'تسليك مجاري', suggestedPrice: { min: 100, max: 300 } },
      { name: 'Faucet Repair', nameAr: 'إصلاح حنفيات', suggestedPrice: { min: 50, max: 150 } },
      { name: 'Water Heater Installation', nameAr: 'تركيب سخانات', suggestedPrice: { min: 200, max: 500 } },
      { name: 'Water Filter Maintenance', nameAr: 'صيانة فلاتر مياه', suggestedPrice: { min: 100, max: 250 } },
      { name: 'Leak Detection', nameAr: 'كشف تسربات', suggestedPrice: { min: 150, max: 400 } },
      { name: 'Bathroom Set Installation', nameAr: 'تركيب أطقم حمامات', suggestedPrice: { min: 300, max: 800 } },
    ],
  },
  {
    name: 'Electrical',
    nameAr: 'كهرباء',
    slug: 'electrical',
    icon: categoryIcons.electrical,
    description: 'Electrical installation and repair services',
    descriptionAr: 'خدمات تركيب وإصلاح الكهرباء',
    sortOrder: 2,
    isPopular: true,
    subcategories: [
      { name: 'Fault Repair', nameAr: 'إصلاح أعطال', suggestedPrice: { min: 100, max: 300 } },
      { name: 'Light Installation', nameAr: 'تركيب لمبات ونجف', suggestedPrice: { min: 50, max: 200 } },
      { name: 'Wire Extension', nameAr: 'تمديد أسلاك', suggestedPrice: { min: 150, max: 400 } },
      { name: 'Switch Installation', nameAr: 'تركيب مفاتيح وبرايز', suggestedPrice: { min: 50, max: 150 } },
      { name: 'Electrical Panel Maintenance', nameAr: 'صيانة لوحات كهرباء', suggestedPrice: { min: 200, max: 500 } },
      { name: 'Fan Installation', nameAr: 'تركيب مراوح', suggestedPrice: { min: 100, max: 250 } },
    ],
  },
  {
    name: 'Carpentry',
    nameAr: 'نجارة',
    slug: 'carpentry',
    icon: categoryIcons.carpentry,
    description: 'Wood and furniture services',
    descriptionAr: 'خدمات الأخشاب والأثاث',
    sortOrder: 3,
    isPopular: true,
    subcategories: [
      { name: 'Furniture Repair', nameAr: 'إصلاح أثاث', suggestedPrice: { min: 100, max: 300 } },
      { name: 'Kitchen Installation', nameAr: 'تركيب مطابخ', suggestedPrice: { min: 500, max: 2000 } },
      { name: 'Door Installation', nameAr: 'تركيب أبواب', suggestedPrice: { min: 200, max: 500 } },
      { name: 'Bedroom Assembly', nameAr: 'فك وتركيب غرف نوم', suggestedPrice: { min: 300, max: 800 } },
      { name: 'Custom Furniture', nameAr: 'تصنيع أثاث', suggestedPrice: { min: 500, max: 3000 } },
      { name: 'Wardrobe Maintenance', nameAr: 'صيانة دواليب', suggestedPrice: { min: 100, max: 300 } },
    ],
  },
  {
    name: 'Painting',
    nameAr: 'دهانات',
    slug: 'painting',
    icon: categoryIcons.painting,
    description: 'Painting and wall decoration services',
    descriptionAr: 'خدمات الدهان وديكورات الحوائط',
    sortOrder: 4,
    isPopular: true,
    subcategories: [
      { name: 'Room Painting', nameAr: 'دهان غرف', suggestedPrice: { min: 200, max: 500 } },
      { name: 'Full Apartment Painting', nameAr: 'دهان شقق كاملة', suggestedPrice: { min: 1000, max: 5000 } },
      { name: 'Wall Decorations', nameAr: 'ديكورات حوائط', suggestedPrice: { min: 300, max: 1000 } },
      { name: 'Plastering', nameAr: 'معجون وتجليخ', suggestedPrice: { min: 200, max: 600 } },
      { name: 'Roof Painting', nameAr: 'دهان أسطح', suggestedPrice: { min: 300, max: 800 } },
    ],
  },
  {
    name: 'AC Services',
    nameAr: 'تكييفات',
    slug: 'ac-services',
    icon: categoryIcons.ac,
    description: 'Air conditioning installation and maintenance',
    descriptionAr: 'تركيب وصيانة التكييفات',
    sortOrder: 5,
    isPopular: true,
    subcategories: [
      { name: 'AC Installation', nameAr: 'تركيب تكييفات', suggestedPrice: { min: 300, max: 600 } },
      { name: 'Regular Maintenance', nameAr: 'صيانة دورية', suggestedPrice: { min: 150, max: 300 } },
      { name: 'Freon Recharge', nameAr: 'شحن فريون', suggestedPrice: { min: 200, max: 400 } },
      { name: 'AC Cleaning', nameAr: 'تنظيف تكييفات', suggestedPrice: { min: 100, max: 200 } },
      { name: 'Fault Repair', nameAr: 'إصلاح أعطال', suggestedPrice: { min: 150, max: 400 } },
    ],
  },
  {
    name: 'Aluminum Works',
    nameAr: 'ألوميتال',
    slug: 'aluminum-works',
    icon: categoryIcons.aluminum,
    description: 'Aluminum windows, doors, and kitchens',
    descriptionAr: 'شبابيك وأبواب ومطابخ ألوميتال',
    sortOrder: 6,
    isPopular: false,
    subcategories: [
      { name: 'Window Installation', nameAr: 'تركيب شبابيك', suggestedPrice: { min: 300, max: 800 } },
      { name: 'Door Installation', nameAr: 'تركيب أبواب', suggestedPrice: { min: 400, max: 1000 } },
      { name: 'Aluminum Kitchen', nameAr: 'تركيب مطابخ ألوميتال', suggestedPrice: { min: 1000, max: 5000 } },
      { name: 'Maintenance & Repair', nameAr: 'صيانة وإصلاح', suggestedPrice: { min: 100, max: 300 } },
    ],
  },
  {
    name: 'Appliance Repair',
    nameAr: 'أجهزة منزلية',
    slug: 'appliance-repair',
    icon: categoryIcons.appliances,
    description: 'Home appliance repair and maintenance',
    descriptionAr: 'إصلاح وصيانة الأجهزة المنزلية',
    sortOrder: 7,
    isPopular: true,
    subcategories: [
      { name: 'Washing Machine', nameAr: 'صيانة غسالات', suggestedPrice: { min: 150, max: 400 } },
      { name: 'Refrigerator', nameAr: 'صيانة ثلاجات', suggestedPrice: { min: 200, max: 500 } },
      { name: 'Stove/Oven', nameAr: 'صيانة بوتاجازات', suggestedPrice: { min: 150, max: 350 } },
      { name: 'Water Heater', nameAr: 'صيانة سخانات', suggestedPrice: { min: 100, max: 300 } },
      { name: 'TV/Screen', nameAr: 'صيانة شاشات', suggestedPrice: { min: 150, max: 400 } },
    ],
  },
  {
    name: 'Moving',
    nameAr: 'نقل عفش',
    slug: 'moving',
    icon: categoryIcons.moving,
    description: 'Furniture moving and transportation',
    descriptionAr: 'نقل وترحيل الأثاث',
    sortOrder: 8,
    isPopular: false,
    subcategories: [
      { name: 'Furniture Moving', nameAr: 'نقل أثاث', suggestedPrice: { min: 500, max: 2000 } },
      { name: 'Disassembly & Assembly', nameAr: 'فك وتركيب', suggestedPrice: { min: 200, max: 600 } },
      { name: 'Packing', nameAr: 'تغليف', suggestedPrice: { min: 100, max: 300 } },
    ],
  },
  {
    name: 'Cleaning',
    nameAr: 'تنظيف',
    slug: 'cleaning',
    icon: categoryIcons.cleaning,
    description: 'Cleaning and pest control services',
    descriptionAr: 'خدمات التنظيف ومكافحة الحشرات',
    sortOrder: 9,
    isPopular: false,
    subcategories: [
      { name: 'Apartment Cleaning', nameAr: 'تنظيف شقق', suggestedPrice: { min: 200, max: 500 } },
      { name: 'Tank Cleaning', nameAr: 'تنظيف خزانات', suggestedPrice: { min: 150, max: 400 } },
      { name: 'Facade Cleaning', nameAr: 'تنظيف واجهات', suggestedPrice: { min: 300, max: 800 } },
      { name: 'Pest Control', nameAr: 'مكافحة حشرات', suggestedPrice: { min: 200, max: 500 } },
    ],
  },
  {
    name: 'Welding',
    nameAr: 'حدادة',
    slug: 'welding',
    icon: categoryIcons.welding,
    description: 'Iron works and welding services',
    descriptionAr: 'أعمال الحديد واللحام',
    sortOrder: 10,
    isPopular: false,
    subcategories: [
      { name: 'Iron Doors', nameAr: 'أبواب حديد', suggestedPrice: { min: 500, max: 2000 } },
      { name: 'Security Windows', nameAr: 'شبابيك حماية', suggestedPrice: { min: 300, max: 800 } },
      { name: 'Stairs', nameAr: 'سلالم', suggestedPrice: { min: 500, max: 2000 } },
      { name: 'Repairs', nameAr: 'إصلاحات', suggestedPrice: { min: 100, max: 300 } },
    ],
  },
];

// ===================== ZONES DATA =====================
const zones = [
  {
    name: 'El-Bagour',
    nameAr: 'الباجور',
    type: 'circle' as const,
    center: {
      type: 'Point' as const,
      coordinates: [30.9667, 30.4522],
    },
    radius: 15000, // 15km in meters
    serviceFee: 5,
    isActive: true,
  },
  {
    name: 'Shebin El-Kom',
    nameAr: 'شبين الكوم',
    type: 'circle' as const,
    center: {
      type: 'Point' as const,
      coordinates: [31.0167, 30.5667],
    },
    radius: 20000, // 20km in meters
    serviceFee: 5,
    isActive: true,
  },
  {
    name: 'Menouf',
    nameAr: 'منوف',
    type: 'circle' as const,
    center: {
      type: 'Point' as const,
      coordinates: [30.9333, 30.4667],
    },
    radius: 12000, // 12km in meters
    serviceFee: 5,
    isActive: true,
  },
];

// ===================== SETTINGS DATA =====================
const settings = [
  { key: 'commission_rate', value: '15', description: 'نسبة العمولة من الصنايعي' },
  { key: 'service_fee_rate', value: '5', description: 'رسوم الخدمة من العميل' },
  { key: 'urgent_fee_rate', value: '20', description: 'رسوم الطلبات العاجلة' },
  { key: 'min_withdrawal', value: '100', description: 'الحد الأدنى للسحب' },
  { key: 'max_quotes_per_request', value: '5', description: 'أقصى عدد عروض للطلب' },
  { key: 'request_expiry_hours', value: '48', description: 'مدة صلاحية الطلب بالساعات' },
  { key: 'otp_expiry_minutes', value: '5', description: 'مدة صلاحية رمز التحقق' },
  { key: 'app_version_android', value: '1.0.0', description: 'إصدار تطبيق أندرويد' },
  { key: 'app_version_ios', value: '1.0.0', description: 'إصدار تطبيق iOS' },
  { key: 'maintenance_mode', value: 'false', description: 'وضع الصيانة' },
];

// ===================== USER DATA =====================
const adminUsers = [
  {
    role: 'admin' as const,
    email: 'admin@sana3y.com',
    password: 'Admin@123',
    name: 'مدير النظام',
    authProvider: 'email' as const,
    isVerified: true,
    isActive: true,
  },
  {
    role: 'admin' as const,
    email: 'superadmin@sana3y.com',
    password: 'SuperAdmin@123',
    name: 'المدير العام',
    authProvider: 'email' as const,
    isVerified: true,
    isActive: true,
  },
];

const customerUsers = [
  {
    name: 'محمد أحمد',
    email: 'mohamed@example.com',
    password: 'Customer@123',
    addresses: [
      {
        label: 'home' as const,
        name: 'المنزل',
        address: 'شارع الجمهورية، الباجور',
        area: 'الباجور',
        city: 'الباجور',
        location: { type: 'Point' as const, coordinates: [30.9667, 30.4522] },
        isDefault: true,
      },
    ],
  },
  {
    name: 'أحمد محمود',
    email: 'ahmed@example.com',
    password: 'Customer@123',
    addresses: [
      {
        label: 'home' as const,
        name: 'المنزل',
        address: 'شارع النيل، شبين الكوم',
        area: 'شبين الكوم',
        city: 'شبين الكوم',
        location: { type: 'Point' as const, coordinates: [31.0167, 30.5667] },
        isDefault: true,
      },
    ],
  },
  {
    name: 'خالد إبراهيم',
    email: 'khaled@example.com',
    password: 'Customer@123',
    addresses: [
      {
        label: 'home' as const,
        name: 'المنزل',
        address: 'شارع المحطة، منوف',
        area: 'منوف',
        city: 'منوف',
        location: { type: 'Point' as const, coordinates: [30.9333, 30.4667] },
        isDefault: true,
      },
    ],
  },
  {
    name: 'سامي عبدالله',
    email: 'sami@example.com',
    password: 'Customer@123',
    addresses: [],
  },
  {
    name: 'ياسر حسن',
    email: 'yasser@example.com',
    password: 'Customer@123',
    addresses: [],
  },
];

const craftsmanUsers = [
  {
    email: 'abdullah.plumber@example.com',
    password: 'Craftsman@123',
    name: 'عبدالله السباك',
    bio: 'سباك محترف مع خبرة 15 سنة في جميع أعمال السباكة المنزلية والتجارية',
    categorySlug: 'plumbing',
    rating: 4.8,
    totalRatings: 45,
    completedJobs: 120,
    status: 'approved' as const,
    isFeatured: true,
  },
  {
    email: 'hassan.electrician@example.com',
    password: 'Craftsman@123',
    name: 'حسن الكهربائي',
    bio: 'فني كهرباء معتمد مع خبرة 12 سنة في الصيانة والتركيبات الكهربائية',
    categorySlug: 'electrical',
    rating: 4.9,
    totalRatings: 67,
    completedJobs: 180,
    status: 'approved' as const,
    isFeatured: true,
  },
  {
    email: 'mahmoud.carpenter@example.com',
    password: 'Craftsman@123',
    name: 'محمود النجار',
    bio: 'نجار محترف متخصص في تصنيع وإصلاح الأثاث والمطابخ',
    categorySlug: 'carpentry',
    rating: 4.7,
    totalRatings: 38,
    completedJobs: 95,
    status: 'approved' as const,
    isFeatured: false,
  },
  {
    email: 'ahmed.painter@example.com',
    password: 'Craftsman@123',
    name: 'أحمد الدهان',
    bio: 'دهان محترف مع خبرة 10 سنوات في دهان الشقق والفيلات',
    categorySlug: 'painting',
    rating: 4.6,
    totalRatings: 29,
    completedJobs: 75,
    status: 'approved' as const,
    isFeatured: false,
  },
  {
    email: 'karim.ac@example.com',
    password: 'Craftsman@123',
    name: 'كريم التكييفات',
    bio: 'فني تكييفات معتمد من كبرى الشركات العالمية',
    categorySlug: 'ac-services',
    rating: 4.5,
    totalRatings: 22,
    completedJobs: 60,
    status: 'approved' as const,
    isFeatured: true,
  },
  {
    email: 'saeed.aluminum@example.com',
    password: 'Craftsman@123',
    name: 'سعيد الألوميتال',
    bio: 'متخصص في تركيب وصيانة الشبابيك والأبواب الألوميتال',
    categorySlug: 'aluminum-works',
    rating: 4.4,
    totalRatings: 18,
    completedJobs: 45,
    status: 'approved' as const,
    isFeatured: false,
  },
  {
    email: 'tarek.appliance@example.com',
    password: 'Craftsman@123',
    name: 'طارق الأجهزة',
    bio: 'فني صيانة أجهزة منزلية مع خبرة 8 سنوات',
    categorySlug: 'appliance-repair',
    rating: 4.3,
    totalRatings: 15,
    completedJobs: 40,
    status: 'approved' as const,
    isFeatured: false,
  },
  {
    email: 'ali.welder@example.com',
    password: 'Craftsman@123',
    name: 'علي الحداد',
    bio: 'حداد متخصص في الأبواب والشبابيك الحديدية',
    categorySlug: 'welding',
    rating: 4.2,
    totalRatings: 12,
    completedJobs: 30,
    status: 'approved' as const,
    isFeatured: false,
  },
  {
    email: 'maged.cleaning@example.com',
    password: 'Craftsman@123',
    name: 'ماجد المنظفات',
    bio: 'خبير في تنظيف الشقق والفيلات ومكافحة الحشرات',
    categorySlug: 'cleaning',
    rating: 4.0,
    totalRatings: 8,
    completedJobs: 20,
    status: 'approved' as const,
    isFeatured: false,
  },
  {
    email: 'walid.moving@example.com',
    password: 'Craftsman@123',
    name: 'وليد النقل',
    bio: 'متخصص في نقل العفش والأثاث مع ضمان السلامة',
    categorySlug: 'moving',
    rating: 4.1,
    totalRatings: 10,
    completedJobs: 25,
    status: 'approved' as const,
    isFeatured: false,
  },
  // Pending craftsmen
  {
    email: 'fahd.plumber@example.com',
    password: 'Craftsman@123',
    name: 'فهد السباك',
    bio: 'سباك جديد يبحث عن فرصة عمل',
    categorySlug: 'plumbing',
    rating: 0,
    totalRatings: 0,
    completedJobs: 0,
    status: 'pending' as const,
    isFeatured: false,
  },
  {
    email: 'ramy.electrician@example.com',
    password: 'Craftsman@123',
    name: 'رامي الكهربائي',
    bio: 'كهربائي مبتدئ',
    categorySlug: 'electrical',
    rating: 0,
    totalRatings: 0,
    completedJobs: 0,
    status: 'pending' as const,
    isFeatured: false,
  },
];

// Helper function to hash password
async function hashPassword(password: string): Promise<string> {
  return bcrypt.hash(password, 12);
}

// Helper function to generate random date within range
function randomDate(start: Date, end: Date): Date {
  return new Date(start.getTime() + Math.random() * (end.getTime() - start.getTime()));
}

async function seed() {
  try {
    await mongoose.connect(config.mongodb.uri);
    logger.info('Connected to MongoDB');

    // Clear all collections
    logger.info('Clearing existing data...');
    await Promise.all([
      User.deleteMany({}),
      Customer.deleteMany({}),
      Craftsman.deleteMany({}),
      ServiceCategory.deleteMany({}),
      ServiceRequest.deleteMany({}),
      Review.deleteMany({}),
      Conversation.deleteMany({}),
      Message.deleteMany({}),
      Notification.deleteMany({}),
      Zone.deleteMany({}),
      Setting.deleteMany({}),
    ]);
    logger.info('Cleared all collections');

    // Insert categories
    const insertedCategories = await ServiceCategory.insertMany(categories);
    const categoryMap = new Map(insertedCategories.map((c) => [c.slug, c._id]));
    logger.info(`Inserted ${insertedCategories.length} categories`);

    // Insert zones
    await Zone.insertMany(zones);
    logger.info(`Inserted ${zones.length} zones`);

    // Insert settings
    await Setting.insertMany(settings);
    logger.info(`Inserted ${settings.length} settings`);

    // Insert admin users
    const adminDocs = [];
    for (const admin of adminUsers) {
      const hashedPassword = await hashPassword(admin.password);
      adminDocs.push({
        ...admin,
        password: hashedPassword,
      });
    }
    await User.insertMany(adminDocs);
    logger.info(`Inserted ${adminDocs.length} admin users`);

    // Insert customer users and profiles
    const customerDocs = [];
    const customerProfileDocs = [];
    for (const customer of customerUsers) {
      const hashedPassword = await hashPassword(customer.password);
      const user = new User({
        role: 'customer',
        email: customer.email,
        password: hashedPassword,
        name: customer.name,
        authProvider: 'email',
        isVerified: true,
        isActive: true,
      });
      await user.save();
      customerDocs.push(user);

      const profile = new Customer({
        userId: user._id,
        addresses: customer.addresses,
        favoritesCraftsmen: [],
      });
      await profile.save();
      customerProfileDocs.push(profile);
    }
    logger.info(`Inserted ${customerDocs.length} customers`);

    // Insert craftsman users and profiles
    const craftsmanDocs = [];
    const craftsmanProfileDocs = [];
    for (const craftsman of craftsmanUsers) {
      const hashedPassword = await hashPassword(craftsman.password);
      const user = new User({
        role: 'craftsman',
        email: craftsman.email,
        password: hashedPassword,
        name: craftsman.name,
        authProvider: 'email',
        isVerified: true,
        isActive: true,
      });
      await user.save();
      craftsmanDocs.push(user);

      const categoryId = categoryMap.get(craftsman.categorySlug);
      const profile = new Craftsman({
        userId: user._id,
        displayName: craftsman.name,
        bio: craftsman.bio,
        services: [
          {
            categoryId,
            subcategories: [],
            experience: 5,
            priceType: 'quote',
            description: craftsman.bio,
          },
        ],
        workingHours: [
          { day: 0, isWorking: true, start: '08:00', end: '18:00' }, // Sunday
          { day: 1, isWorking: true, start: '08:00', end: '18:00' }, // Monday
          { day: 2, isWorking: true, start: '08:00', end: '18:00' }, // Tuesday
          { day: 3, isWorking: true, start: '08:00', end: '18:00' }, // Wednesday
          { day: 4, isWorking: true, start: '08:00', end: '18:00' }, // Thursday
          { day: 5, isWorking: false, start: '00:00', end: '00:00' }, // Friday
          { day: 6, isWorking: true, start: '08:00', end: '18:00' }, // Saturday
        ],
        location: {
          type: 'Point',
          coordinates: [30.9667 + Math.random() * 0.1, 30.4522 + Math.random() * 0.1],
        },
        serviceRadius: 10 + Math.floor(Math.random() * 10),
        status: craftsman.status,
        rating: craftsman.rating,
        totalRatings: craftsman.totalRatings,
        completedJobs: craftsman.completedJobs,
        isOnline: craftsman.status === 'approved',
        isAvailable: craftsman.status === 'approved',
        isFeatured: craftsman.isFeatured,
        totalEarnings: craftsman.completedJobs * 250,
        currentBalance: craftsman.completedJobs * 200,
      });
      await profile.save();
      craftsmanProfileDocs.push(profile);
    }
    logger.info(`Inserted ${craftsmanDocs.length} craftsmen`);

    // Create sample service requests
    const requestStatuses = ['pending', 'quoted', 'accepted', 'in_progress', 'completed', 'cancelled'];
    const requestTitles = [
      'تسليك مجاري المطبخ',
      'إصلاح تسريب مياه',
      'تركيب حنفية جديدة',
      'إصلاح عطل كهربائي',
      'تركيب لمبات LED',
      'صيانة تكييف سبليت',
      'دهان غرفة نوم',
      'إصلاح باب خشب',
      'تركيب شباك ألوميتال',
      'صيانة غسالة أوتوماتيك',
    ];

    const requestDocs = [];
    const approvedCraftsmen = craftsmanProfileDocs.filter((c) => c.status === 'approved');
    const today = dayjs().format('YYMMDD');

    for (let i = 0; i < 30; i++) {
      const customer = customerProfileDocs[Math.floor(Math.random() * customerProfileDocs.length)];
      const craftsman = approvedCraftsmen[Math.floor(Math.random() * approvedCraftsmen.length)];
      const categoryId = craftsman.services[0].categoryId;
      const status = requestStatuses[Math.floor(Math.random() * requestStatuses.length)];
      const title = requestTitles[Math.floor(Math.random() * requestTitles.length)];

      const urgencyTypes: Array<'urgent' | 'today' | 'scheduled'> = ['urgent', 'today', 'scheduled'];
      const urgency = urgencyTypes[Math.floor(Math.random() * urgencyTypes.length)];
      const scheduledDate =
        urgency === 'scheduled'
          ? new Date(Date.now() + Math.random() * 7 * 24 * 60 * 60 * 1000)
          : undefined;

      const request: Record<string, unknown> = {
        requestNumber: `SAN-${today}-${String(i + 1).padStart(4, '0')}`,
        customerId: customer.userId,
        categoryId,
        title,
        description: `${title} - نحتاج خدمة سريعة وموثوقة. الرجاء التواصل لمزيد من التفاصيل.`,
        address: {
          address: 'شارع الجمهورية، الباجور',
          area: 'الباجور',
          city: 'الباجور',
          location: {
            type: 'Point',
            coordinates: [30.9667 + Math.random() * 0.1, 30.4522 + Math.random() * 0.1],
          },
        },
        estimatedPrice: {
          min: 100 + Math.floor(Math.random() * 100),
          max: 300 + Math.floor(Math.random() * 200),
        },
        urgency,
        scheduledDate,
        scheduledTimeSlot: urgency === 'scheduled' ? 'morning' : undefined,
        isUrgent: urgency === 'urgent',
        status,
        createdAt: randomDate(new Date(Date.now() - 30 * 24 * 60 * 60 * 1000), new Date()),
      };

      // Add quotes for non-pending requests
      if (status !== 'pending') {
        const quotePrice = 150 + Math.floor(Math.random() * 200);
        request.quotesReceived = [
          {
            craftsmanId: craftsman.userId,
            price: quotePrice,
            estimatedDuration: `${1 + Math.floor(Math.random() * 4)} ساعات`,
            note: 'سأحضر جميع الأدوات والمواد اللازمة',
            createdAt: new Date(),
          },
        ];

        if (['accepted', 'in_progress', 'completed'].includes(status)) {
          request.craftsmanId = craftsman.userId;
          request.quotedPrice = quotePrice;
          request.finalPrice = quotePrice;
          request.commission = quotePrice * 0.15;
          request.serviceFee = quotePrice * 0.05;
          request.craftsmanEarnings = quotePrice - quotePrice * 0.15;
        }
      }

      requestDocs.push(request);
    }

    // Save requests individually to trigger pre-save hooks for requestNumber generation
    for (const requestData of requestDocs) {
      const request = new ServiceRequest(requestData);
      await request.save();
    }
    logger.info(`Inserted ${requestDocs.length} service requests`);

    // Create sample reviews for completed requests
    const completedRequests = await ServiceRequest.find({ status: 'completed' });
    const reviewDocs = [];
    const reviewComments = [
      'خدمة ممتازة وسريعة، أنصح به',
      'عمل احترافي وأسعار معقولة',
      'صنايعي ممتاز ومحترم',
      'شغل نظيف وسريع',
      'تجربة رائعة، شكراً',
      'أداء جيد جداً',
      'راضي عن الخدمة',
      'ملتزم بالمواعيد ومحترف',
    ];

    for (const request of completedRequests) {
      if (request.craftsmanId) {
        reviewDocs.push({
          requestId: request._id,
          customerId: request.customerId,
          craftsmanId: request.craftsmanId,
          score: 3 + Math.floor(Math.random() * 3), // 3-5 stars
          comment: reviewComments[Math.floor(Math.random() * reviewComments.length)],
          qualities: {
            punctuality: 3 + Math.floor(Math.random() * 3),
            professionalism: 3 + Math.floor(Math.random() * 3),
            quality: 3 + Math.floor(Math.random() * 3),
            cleanliness: 3 + Math.floor(Math.random() * 3),
            communication: 3 + Math.floor(Math.random() * 3),
          },
          isVisible: true,
          createdAt: randomDate(request.createdAt as Date, new Date()),
        });
      }
    }

    if (reviewDocs.length > 0) {
      await Review.insertMany(reviewDocs);
      logger.info(`Inserted ${reviewDocs.length} reviews`);
    }

    // Create sample notifications
    const notificationDocs = [];
    const notificationTypes = [
      { type: 'request', title: 'طلب جديد', body: 'لديك طلب خدمة جديد في منطقتك' },
      { type: 'quote', title: 'عرض سعر جديد', body: 'تلقيت عرض سعر جديد على طلبك' },
      { type: 'status', title: 'تم قبول العرض', body: 'تم قبول عرض السعر الخاص بك' },
      { type: 'status', title: 'تم إنهاء الخدمة', body: 'تم إنهاء الخدمة بنجاح' },
      { type: 'review', title: 'تقييم جديد', body: 'تلقيت تقييماً جديداً' },
      { type: 'system', title: 'مرحباً بك', body: 'مرحباً بك في تطبيق صنايعي' },
    ];

    const allUsers = [...customerDocs, ...craftsmanDocs];
    for (const user of allUsers) {
      for (let i = 0; i < 3; i++) {
        const notif = notificationTypes[Math.floor(Math.random() * notificationTypes.length)];
        notificationDocs.push({
          userId: user._id,
          type: notif.type,
          title: notif.title,
          body: notif.body,
          isRead: Math.random() > 0.5,
          createdAt: randomDate(new Date(Date.now() - 7 * 24 * 60 * 60 * 1000), new Date()),
        });
      }
    }

    await Notification.insertMany(notificationDocs);
    logger.info(`Inserted ${notificationDocs.length} notifications`);

    // Summary
    logger.info('='.repeat(50));
    logger.info('Seed completed successfully!');
    logger.info('='.repeat(50));
    logger.info('Summary:');
    logger.info(`  - Categories: ${insertedCategories.length}`);
    logger.info(`  - Zones: ${zones.length}`);
    logger.info(`  - Settings: ${settings.length}`);
    logger.info(`  - Admin Users: ${adminDocs.length}`);
    logger.info(`  - Customers: ${customerDocs.length}`);
    logger.info(`  - Craftsmen: ${craftsmanDocs.length}`);
    logger.info(`  - Service Requests: ${requestDocs.length}`);
    logger.info(`  - Reviews: ${reviewDocs.length}`);
    logger.info(`  - Notifications: ${notificationDocs.length}`);
    logger.info('='.repeat(50));
    logger.info('Test Credentials:');
    logger.info('  Admin: admin@sana3y.com / Admin@123');
    logger.info('  Customer: mohamed@example.com / Customer@123');
    logger.info('  Craftsman: abdullah.plumber@example.com / Craftsman@123');
    logger.info('='.repeat(50));

    await mongoose.disconnect();
    process.exit(0);
  } catch (error) {
    logger.error('Seed failed:', error);
    process.exit(1);
  }
}

seed();
