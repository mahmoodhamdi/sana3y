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

## API Endpoints

### Authentication
| Method | Endpoint | Description |
|--------|----------|-------------|
| POST | `/api/v1/auth/send-otp` | Send OTP to phone |
| POST | `/api/v1/auth/verify-otp` | Verify OTP code |
| POST | `/api/v1/auth/register` | Register new user |
| POST | `/api/v1/auth/login` | Login user |
| GET | `/api/v1/auth/me` | Get current user |

### Categories
| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/v1/categories` | List all categories |
| GET | `/api/v1/categories/:id` | Get category details |

### Craftsmen
| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/v1/craftsmen` | List craftsmen |
| GET | `/api/v1/craftsmen/nearby` | Find nearby craftsmen |
| GET | `/api/v1/craftsmen/:id` | Get craftsman profile |

### Requests
| Method | Endpoint | Description |
|--------|----------|-------------|
| POST | `/api/v1/requests` | Create service request |
| GET | `/api/v1/requests` | List user requests |
| PUT | `/api/v1/requests/:id/status` | Update request status |

## Docker Deployment

### Quick Start
```bash
# Start all services
docker-compose -f docker-compose.prod.yml up -d

# View logs
docker-compose -f docker-compose.prod.yml logs -f
```

### Environment Variables
Create a `.env` file with the required variables:
```env
MONGODB_URI=mongodb://localhost:27017/sana3y
JWT_SECRET=your-secret-key
CLOUDINARY_CLOUD_NAME=your-cloud-name
CLOUDINARY_API_KEY=your-api-key
CLOUDINARY_API_SECRET=your-api-secret
```

## Testing

### Backend Tests
```bash
cd backend
npm test
```

### Flutter Tests
```bash
cd mobile
flutter test
```

## Progress

See [PROJECT_PROGRESS.md](PROJECT_PROGRESS.md) for current development status.

## License

This project is proprietary software.

---

**يلا نبدأ! 🔧**
