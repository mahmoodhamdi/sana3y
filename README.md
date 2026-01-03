# Sana3y (صنايعي) 🔧

**كل الصنايعية في إيدك**

منصة متكاملة لربط العملاء بالصنايعية والحرفيين المحليين لخدمات المنزل.

## Overview

Sana3y is a platform connecting customers with local craftsmen/handymen for home services in Egypt, starting with الباجور ومركزها (المنوفية).

### The Problem
- صعوبة إيجاد صنايعي موثوق
- مفيش أسعار واضحة
- مفيش ضمان على الشغل
- مفيش تقييمات أو مراجعات
- الصنايعي مش دايماً بيرد أو بييجي في الميعاد

### The Solution
- منصة موحدة لكل الصنايعية
- أسعار واضحة ومحددة
- تقييمات حقيقية من العملاء
- ضمان على الشغل
- حجز مواعيد مؤكدة
- تتبع حالة الطلب

## Service Categories

| Category | الفئة |
|----------|-------|
| Plumbing | سباكة |
| Electrical | كهرباء |
| Carpentry | نجارة |
| Painting | دهانات |
| AC Services | تكييفات |
| Aluminum Works | ألوميتال |
| Appliance Repair | أجهزة منزلية |
| Moving | نقل عفش |
| Cleaning | تنظيف |
| Welding | حدادة |

## Tech Stack

| Component | Technology |
|-----------|------------|
| Backend | Node.js + Express + TypeScript |
| Database | MongoDB + Mongoose |
| Real-time | Socket.io |
| Mobile App | Flutter + Riverpod |
| Admin Dashboard | Next.js 14 + Tailwind CSS + shadcn/ui |
| File Storage | Cloudinary |
| Auth | JWT + Firebase (OTP) |
| Notifications | Firebase Cloud Messaging |

## Project Structure

```
sana3y/
├── backend/           # Node.js API server
├── mobile/            # Flutter app (Customer & Craftsman)
├── admin-dashboard/   # Next.js admin panel
├── shared/            # Shared types and constants
└── docs/              # Documentation
```

## Getting Started

### Prerequisites
- Node.js 20+
- Flutter 3.x
- MongoDB
- Git

### Backend Setup
```bash
cd backend
npm install
cp .env.example .env
# Configure .env with your settings
npm run dev
```

### Mobile Setup
```bash
cd mobile
flutter pub get
flutter run
```

### Admin Dashboard Setup
```bash
cd admin-dashboard
npm install
cp .env.example .env.local
npm run dev
```

## User Roles

1. **Customer (العميل)** - Request services, track orders, rate craftsmen
2. **Craftsman (الصنايعي)** - Receive requests, send quotes, manage profile
3. **Admin (المدير)** - Full platform management

## Revenue Model

- 15% commission from craftsmen on completed jobs
- Service fee from customers per request
- Featured listings for craftsmen
- Subscription plans (future)

## Progress

See [PROJECT_PROGRESS.md](PROJECT_PROGRESS.md) for current development status.

## License

This project is proprietary software.

---

**يلا نبدأ! 🔧**
