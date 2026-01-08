# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Sana3y (صنايعي) is a platform connecting customers with local craftsmen/handymen for home services in Egypt, starting with الباجور (المنوفية). The platform uses Arabic (RTL) as the primary language.

## Development Commands

### Backend (Node.js/Express/TypeScript)
```bash
cd backend
npm install
cp .env.example .env  # Configure environment variables
npm run dev           # Start development server with nodemon
npm run build         # Compile TypeScript to dist/
npm run lint          # Run ESLint
npm run lint:fix      # Fix ESLint issues
npm run format        # Format code with Prettier
npm run test          # Run Jest tests
npm run test:watch    # Run tests in watch mode
npm run test -- --testPathPattern="auth"  # Run tests matching pattern (regex)
npm run seed          # Seed database
```

### Mobile (Flutter)
```bash
cd mobile
flutter pub get
flutter run                          # Run on connected device/emulator
flutter run -d chrome                # Run on Chrome (web)
flutter build apk                    # Build Android APK
flutter build ios                    # Build iOS
flutter analyze                      # Static analysis
flutter test                         # Run all tests
flutter test test/widget_test.dart   # Run single test file
dart run build_runner build --delete-conflicting-outputs  # Generate Freezed/Riverpod code
dart run build_runner watch --delete-conflicting-outputs  # Watch mode for code gen
```

### Admin Dashboard (Next.js 16)
```bash
cd admin-dashboard
npm install
cp .env.example .env.local  # Configure environment variables
npm run dev                 # Start development server (localhost:3000)
npm run build               # Production build
npm run lint                # Run ESLint
```

### Docker (MongoDB + Redis)
```bash
docker-compose up -d    # Start MongoDB and Redis containers
docker-compose down     # Stop containers
```
MongoDB runs on port 27017, Mongo Express on 8081, Redis on 6379.

## Architecture

### Monorepo Structure
- **backend/** - Express API server (TypeScript, Mongoose, Socket.io)
- **mobile/** - Flutter app serving both Customer and Craftsman roles (Riverpod, GoRouter, Freezed)
- **admin-dashboard/** - Next.js 16 admin panel (React Query, Zustand, shadcn/ui)
- **shared/** - Shared TypeScript types and constants used by backend and admin

### Backend Path Aliases
Configured in `backend/tsconfig.json`:
- `@config/*`, `@controllers/*`, `@middleware/*`, `@models/*`, `@routes/*`, `@services/*`, `@validators/*`, `@utils/*`, `@types/*`
- `@shared/*` - References shared types from `../../shared/`

### Backend API Structure
- Base URL: `/api/v1`
- Routes: `/auth`, `/categories`, `/craftsmen`, `/requests`, `/chat`, `/reviews`, `/notifications`, `/upload`, `/payment`
- Health check: `/health`
- API Documentation: `/api/docs` (Swagger UI), `/api/redoc` (ReDoc)
- Postman collection available in `backend/src/docs/`

### Mobile Architecture
- **State Management**: Riverpod with code generation (`riverpod_generator`)
- **Routing**: GoRouter with auth guards
- **Models**: Freezed for immutable data classes with JSON serialization
- **Services**: Dio for HTTP, Socket.io for real-time
- **Screen Organization**: `screens/auth/` (shared), `screens/customer/`, `screens/craftsman/`, `screens/shared/`

### Admin Dashboard Architecture
- **App Router**: Next.js 16 with route groups `(auth)` and `(dashboard)`
- **State**: Zustand for global state, React Query for server state
- **UI**: shadcn/ui components with Radix primitives
- **Dashboard Routes**: `/dashboard`, `/craftsmen`, `/customers`, `/requests`, `/categories`, `/finance`, `/zones`, `/notifications`, `/settings`

### Database Models (MongoDB)
Key models in `backend/src/models/`:
- User, Customer, Craftsman, ServiceCategory
- ServiceRequest, Review
- Conversation, Message
- Transaction, Notification, Zone, Setting, OTP

Note: Quote is embedded in ServiceRequest, not a separate model.

### User Roles
- **customer** - Request services
- **craftsman** - Accept jobs (requires approval)
- **admin** - Full platform management

### Shared Constants
`shared/constants/index.ts` contains business constants: `USER_ROLES`, `CRAFTSMAN_STATUS`, `REQUEST_STATUS`, `PAYMENT_STATUS`, `DEFAULTS` (commission rates, fees, limits).

## Key Patterns

- Egyptian phone format: `+20XXXXXXXXXX` (validated by `EGYPT_PHONE_REGEX`)
- OTP-based authentication with JWT tokens
- Arabic text uses Cairo font family
- Mobile app defaults to RTL with Arabic locale (ar_EG)
- File uploads via Cloudinary
- Real-time updates via Socket.io

## Business Defaults

Located in `shared/constants/index.ts` and mirrored in `mobile/lib/config/constants.dart`:
- Commission: 15% (from craftsmen)
- Service Fee: 5% (from customers)
- Urgent Fee: 20% (extra charge)
- Default location: الباجور (30.4522, 30.9667)
- Service radius: 10 km

## Request Lifecycle

Status flow: `pending` → `quoted` → `accepted` → `in_progress` → `completed`
(can be `cancelled` at any point before completion)

## Socket.io Events

Key events in `mobile/lib/config/constants.dart` (SocketEvents class):
- `request:new`, `request:quote`, `request:accepted`, `request:status` - Request lifecycle
- `message:new`, `message:read` - Chat
- `craftsman:online`, `craftsman:offline` - Availability
- `typing:start`, `typing:stop` - Typing indicators

## Code Generation

After modifying Freezed models or Riverpod providers in Flutter, regenerate:
```bash
cd mobile
dart run build_runner build --delete-conflicting-outputs
```

Generated files: `*.freezed.dart`, `*.g.dart` - do not edit manually.
