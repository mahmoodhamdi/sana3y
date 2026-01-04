import mongoose from 'mongoose';
import bcrypt from 'bcryptjs';
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
const categories = [
  {
    name: 'Plumbing',
    nameAr: 'سباكة',
    slug: 'plumbing',
    icon: 'plumbing',
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
    icon: 'electrical',
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
    icon: 'carpentry',
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
    icon: 'painting',
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
    icon: 'ac',
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
    icon: 'aluminum',
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
    icon: 'appliances',
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
    icon: 'moving',
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
    icon: 'cleaning',
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
    icon: 'welding',
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
    name: 'الباجور',
    nameEn: 'El-Bagour',
    governorate: 'المنوفية',
    governorateEn: 'Menoufia',
    isActive: true,
    location: {
      type: 'Point' as const,
      coordinates: [30.9667, 30.4522],
    },
    radius: 15,
  },
  {
    name: 'شبين الكوم',
    nameEn: 'Shebin El-Kom',
    governorate: 'المنوفية',
    governorateEn: 'Menoufia',
    isActive: true,
    location: {
      type: 'Point' as const,
      coordinates: [31.0167, 30.5667],
    },
    radius: 20,
  },
  {
    name: 'منوف',
    nameEn: 'Menouf',
    governorate: 'المنوفية',
    governorateEn: 'Menoufia',
    isActive: true,
    location: {
      type: 'Point' as const,
      coordinates: [30.9333, 30.4667],
    },
    radius: 12,
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
    phone: '+201000000000',
    email: 'admin@sana3y.com',
    password: 'Admin@123',
    name: 'مدير النظام',
    isPhoneVerified: true,
    isActive: true,
  },
  {
    role: 'admin' as const,
    phone: '+201000000001',
    email: 'superadmin@sana3y.com',
    password: 'SuperAdmin@123',
    name: 'المدير العام',
    isPhoneVerified: true,
    isActive: true,
  },
];

const customerUsers = [
  {
    phone: '+201111111111',
    name: 'محمد أحمد',
    email: 'mohamed@example.com',
    addresses: [
      {
        label: 'المنزل',
        address: 'شارع الجمهورية، الباجور',
        city: 'الباجور',
        governorate: 'المنوفية',
        location: { type: 'Point' as const, coordinates: [30.9667, 30.4522] },
        isDefault: true,
      },
    ],
  },
  {
    phone: '+201111111112',
    name: 'أحمد محمود',
    email: 'ahmed@example.com',
    addresses: [
      {
        label: 'المنزل',
        address: 'شارع النيل، شبين الكوم',
        city: 'شبين الكوم',
        governorate: 'المنوفية',
        location: { type: 'Point' as const, coordinates: [31.0167, 30.5667] },
        isDefault: true,
      },
    ],
  },
  {
    phone: '+201111111113',
    name: 'خالد إبراهيم',
    email: 'khaled@example.com',
    addresses: [
      {
        label: 'المنزل',
        address: 'شارع المحطة، منوف',
        city: 'منوف',
        governorate: 'المنوفية',
        location: { type: 'Point' as const, coordinates: [30.9333, 30.4667] },
        isDefault: true,
      },
    ],
  },
  {
    phone: '+201111111114',
    name: 'سامي عبدالله',
    email: 'sami@example.com',
    addresses: [],
  },
  {
    phone: '+201111111115',
    name: 'ياسر حسن',
    email: 'yasser@example.com',
    addresses: [],
  },
];

const craftsmanUsers = [
  {
    phone: '+201222222221',
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
    phone: '+201222222222',
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
    phone: '+201222222223',
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
    phone: '+201222222224',
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
    phone: '+201222222225',
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
    phone: '+201222222226',
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
    phone: '+201222222227',
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
    phone: '+201222222228',
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
    phone: '+201222222229',
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
    phone: '+201222222230',
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
    phone: '+201222222231',
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
    phone: '+201222222232',
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
      const user = new User({
        role: 'customer',
        phone: customer.phone,
        name: customer.name,
        email: customer.email,
        isPhoneVerified: true,
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
      const user = new User({
        role: 'craftsman',
        phone: craftsman.phone,
        name: craftsman.name,
        isPhoneVerified: true,
        isActive: true,
      });
      await user.save();
      craftsmanDocs.push(user);

      const categoryId = categoryMap.get(craftsman.categorySlug);
      const profile = new Craftsman({
        userId: user._id,
        bio: craftsman.bio,
        services: [
          {
            categoryId,
            priceRange: { min: 100, max: 500 },
            description: craftsman.bio,
          },
        ],
        workingHours: {
          saturday: { isOpen: true, openTime: '08:00', closeTime: '18:00' },
          sunday: { isOpen: true, openTime: '08:00', closeTime: '18:00' },
          monday: { isOpen: true, openTime: '08:00', closeTime: '18:00' },
          tuesday: { isOpen: true, openTime: '08:00', closeTime: '18:00' },
          wednesday: { isOpen: true, openTime: '08:00', closeTime: '18:00' },
          thursday: { isOpen: true, openTime: '08:00', closeTime: '18:00' },
          friday: { isOpen: false, openTime: '00:00', closeTime: '00:00' },
        },
        location: {
          type: 'Point',
          coordinates: [30.9667 + Math.random() * 0.1, 30.4522 + Math.random() * 0.1],
          address: 'الباجور، المنوفية',
          city: 'الباجور',
          governorate: 'المنوفية',
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
        availableBalance: craftsman.completedJobs * 200,
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

    for (let i = 0; i < 30; i++) {
      const customer = customerProfileDocs[Math.floor(Math.random() * customerProfileDocs.length)];
      const craftsman = approvedCraftsmen[Math.floor(Math.random() * approvedCraftsmen.length)];
      const categoryId = craftsman.services[0].categoryId;
      const status = requestStatuses[Math.floor(Math.random() * requestStatuses.length)];
      const title = requestTitles[Math.floor(Math.random() * requestTitles.length)];

      const request: Record<string, unknown> = {
        customerId: customer.userId,
        categoryId,
        title,
        description: `${title} - نحتاج خدمة سريعة وموثوقة. الرجاء التواصل لمزيد من التفاصيل.`,
        location: {
          type: 'Point',
          coordinates: [30.9667 + Math.random() * 0.1, 30.4522 + Math.random() * 0.1],
          address: 'الباجور، المنوفية',
          city: 'الباجور',
          governorate: 'المنوفية',
        },
        budget: {
          min: 100 + Math.floor(Math.random() * 100),
          max: 300 + Math.floor(Math.random() * 200),
        },
        preferredTime: {
          date: new Date(Date.now() + Math.random() * 7 * 24 * 60 * 60 * 1000),
          timeSlot: ['morning', 'afternoon', 'evening'][Math.floor(Math.random() * 3)],
          flexibleDate: Math.random() > 0.5,
        },
        isUrgent: Math.random() > 0.8,
        status,
        createdAt: randomDate(new Date(Date.now() - 30 * 24 * 60 * 60 * 1000), new Date()),
      };

      // Add quotes for non-pending requests
      if (status !== 'pending') {
        const quotePrice = 150 + Math.floor(Math.random() * 200);
        request.quotes = [
          {
            craftsmanId: craftsman.userId,
            price: quotePrice,
            estimatedDuration: `${1 + Math.floor(Math.random() * 4)} ساعات`,
            notes: 'سأحضر جميع الأدوات والمواد اللازمة',
            status: status === 'quoted' ? 'pending' : 'accepted',
            createdAt: new Date(),
          },
        ];

        if (['accepted', 'in_progress', 'completed'].includes(status)) {
          request.craftsmanId = craftsman.userId;
          request.acceptedQuote = (request.quotes as Array<Record<string, unknown>>)[0];
          request.totalAmount = quotePrice;
          request.commission = quotePrice * 0.15;
          request.serviceFee = quotePrice * 0.05;
        }
      }

      requestDocs.push(request);
    }

    await ServiceRequest.insertMany(requestDocs);
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
      { type: 'request_new', title: 'طلب جديد', body: 'لديك طلب خدمة جديد في منطقتك' },
      { type: 'request_quote', title: 'عرض سعر جديد', body: 'تلقيت عرض سعر جديد على طلبك' },
      { type: 'request_accepted', title: 'تم قبول العرض', body: 'تم قبول عرض السعر الخاص بك' },
      { type: 'request_completed', title: 'تم إنهاء الخدمة', body: 'تم إنهاء الخدمة بنجاح' },
      { type: 'review_received', title: 'تقييم جديد', body: 'تلقيت تقييماً جديداً' },
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
    logger.info('  Customer: +201111111111 (use OTP)');
    logger.info('  Craftsman: +201222222221 (use OTP)');
    logger.info('='.repeat(50));

    await mongoose.disconnect();
    process.exit(0);
  } catch (error) {
    logger.error('Seed failed:', error);
    process.exit(1);
  }
}

seed();
