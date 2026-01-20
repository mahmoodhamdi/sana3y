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
- `@/*` - General alias for `src/*`
- `@config/*`, `@controllers/*`, `@middleware/*`, `@models/*`, `@routes/*`, `@services/*`, `@validators/*`, `@utils/*`, `@types/*`
- `@shared/*` - References shared types from `../../shared/`

### Backend API Structure
- Base URL: `/api/v1`
- Routes: `/auth`, `/categories`, `/craftsmen`, `/customers`, `/requests`, `/chat`, `/reviews`, `/notifications`, `/upload`, `/payments`, `/admin`
- Health check: `/health`
- API info: `/api/v1`
- API Documentation: `/api/docs` (Swagger UI), `/api/redoc` (ReDoc), `/api/docs.json` (spec)
- Postman collection available in `backend/src/docs/`

### Admin API Routes (`/admin` - requires admin role)
- **Dashboard**: `GET /dashboard` - Platform statistics
- **Customers**: `GET /customers`, `GET /customers/:id`, `PUT /customers/:id/status`
- **Craftsmen**: `GET /craftsmen`, `GET /craftsmen/pending`, `PUT /craftsmen/:id/status`, `POST /craftsmen/:id/approve`, `POST /craftsmen/:id/reject`, `POST /craftsmen/:id/suspend`
- **Requests**: `GET /requests`
- **Transactions**: `GET /transactions`, `GET /transactions/stats`
- **Zones**: `GET /zones`, `POST /zones`, `PUT /zones/:id`, `DELETE /zones/:id`
- **Settings**: `GET /settings`, `PUT /settings`
- **Notifications**: `GET /notifications`, `POST /notifications` (broadcast)

### Backend Middleware
Auth middleware in `backend/src/middleware/auth.ts` provides:
- `authenticate` - Require valid JWT token
- `optionalAuth` - Continue without auth if no token
- `requireRole(...roles)` - Require specific roles
- `requireAdmin`, `requireCraftsman`, `requireCustomer`, `requireCraftsmanOrAdmin` - Role shortcuts

### Mobile Architecture
- **State Management**: Riverpod with code generation (`riverpod_generator`)
- **Routing**: GoRouter with auth guards
- **Models**: Freezed for immutable data classes with JSON serialization
- **Services**: Dio for HTTP, Socket.io for real-time
- **Screen Organization**: `screens/auth/` (shared), `screens/customer/`, `screens/craftsman/`, `screens/shared/`
- **Constants**: `lib/config/constants.dart` contains `AppConstants`, `ApiEndpoints`, `SocketEvents`

### Admin Dashboard Architecture
- **App Router**: Next.js 16 with route groups `(auth)` and `(dashboard)`
- **State**: Zustand for global state, React Query for server state
- **UI**: shadcn/ui components with Radix primitives
- **Dashboard Routes**: `/dashboard`, `/craftsmen`, `/craftsmen/pending`, `/customers`, `/requests`, `/categories`, `/finance`, `/zones`, `/notifications`, `/settings`

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

## Authentication Flow

Email-based auth with OTP verification:
1. User requests OTP via `/auth/send-verification-otp`
2. OTP sent to email (code returned in dev mode for testing)
3. Verify OTP via `/auth/verify-otp`
4. Register via `/auth/register` or login via `/auth/login`
5. JWT access/refresh tokens returned

Google auth also supported via Firebase ID token verification.

Role switching: Users can switch between customer/craftsman roles via `/auth/switch-role`. Switching creates the missing profile if needed. Craftsmen start with `pending` status until admin approval.

## External Services

### Payment (Paymob)
- `backend/src/services/payment.service.ts` handles card and wallet payments
- Supports Vodafone Cash, Orange Money via wallet integration
- Webhook callback verifies HMAC signature for security
- Env vars: `PAYMOB_API_KEY`, `PAYMOB_INTEGRATION_ID`, `PAYMOB_IFRAME_ID`, `PAYMOB_HMAC_SECRET`

### SMS (Twilio/Unifonic)
- `backend/src/utils/sms.ts` supports multiple providers
- Twilio for international, Unifonic for Egyptian SMS gateway
- Falls back to console logging in development mode
- Env vars: `TWILIO_ACCOUNT_SID`, `TWILIO_AUTH_TOKEN`, `TWILIO_PHONE_NUMBER` or `UNIFONIC_APP_SID`, `UNIFONIC_SENDER_ID`

### Maps (OpenStreetMap - FREE)
- `backend/src/services/location.service.ts` uses free APIs
- Nominatim for geocoding (1 req/sec rate limit)
- OSRM for routing and distance calculation
- No API keys required

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

Craftsman status flow: `pending` → `approved` | `rejected` | `suspended`

## Socket.io Events

Socket service in `backend/src/services/socket.service.ts` manages real-time communication.

### Room Structure
- `user:{userId}` - User-specific notifications
- `craftsman:{craftsmanId}` - Craftsman-specific events
- `category:{categoryId}` - Craftsmen in category
- `zone:{zoneId}` - Craftsmen in service zone
- `request:{requestId}` - Request updates
- `chat:{chatId}` - Chat messages
- `admin` - Admin notifications

### Key Events (Client → Server)
- `location:update` - Craftsman location update
- `craftsman:status` - Online/offline toggle
- `request:join`, `request:leave` - Join/leave request room
- `chat:join`, `chat:leave`, `chat:typing` - Chat interactions

### Key Events (Server → Client)
- `request:new`, `request:quote_added`, `request:quote_accepted`, `request:status_changed`
- `quote:new`, `quote:accepted`
- `chat:message`, `chat:typing`
- `craftsman:location`

## Code Generation

After modifying Freezed models or Riverpod providers in Flutter, regenerate:
```bash
cd mobile
dart run build_runner build --delete-conflicting-outputs
```

Generated files: `*.freezed.dart`, `*.g.dart` - do not edit manually.

## Security Middleware

Security middleware in `backend/src/middleware/security.ts` provides:
- `preventNoSQLInjection` - Blocks MongoDB operator injection attempts
- `securityHeaders` - Adds security headers (X-Content-Type-Options, X-Frame-Options, etc.)
- `sanitizeInput` - XSS prevention via HTML entity encoding
- `requestSizeLimiter` - Limit request body size
- `validateContentType` - Ensure correct Content-Type headers

Additional security via npm packages: `helmet`, `express-mongo-sanitize`, `hpp` (HTTP parameter pollution)

## Testing Notes

- Backend tests use Jest with MongoDB Memory Server (no external DB needed)
- Run specific test file: `npm run test -- path/to/test.ts`
- Run tests matching pattern: `npm run test -- --testPathPatterns="auth"`
- Mobile tests: `flutter test test/path/to/test.dart`
- Test suites: `api.test.ts`, `auth.test.ts`, `admin.test.ts`, `customer.test.ts`, `endpoints.test.ts`
