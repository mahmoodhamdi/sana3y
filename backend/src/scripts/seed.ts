import mongoose from 'mongoose';
import { config } from '../config';
import { ServiceCategory } from '../models';
import { logger } from '../utils/logger';

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

async function seed() {
  try {
    await mongoose.connect(config.mongodb.uri);
    logger.info('Connected to MongoDB');

    // Clear existing categories
    await ServiceCategory.deleteMany({});
    logger.info('Cleared existing categories');

    // Insert new categories
    await ServiceCategory.insertMany(categories);
    logger.info(`Inserted ${categories.length} categories`);

    await mongoose.disconnect();
    logger.info('Seed completed successfully');
    process.exit(0);
  } catch (error) {
    logger.error('Seed failed:', error);
    process.exit(1);
  }
}

seed();
