import dotenv from 'dotenv';
dotenv.config();

export const config = {
  env: process.env.NODE_ENV || 'development',
  port: parseInt(process.env.PORT || '5000', 10),
  apiVersion: process.env.API_VERSION || 'v1',

  mongodb: {
    uri: process.env.MONGODB_URI || 'mongodb://localhost:27017/sana3y',
  },

  jwt: {
    secret: process.env.JWT_SECRET || 'your-super-secret-jwt-key',
    expiresIn: process.env.JWT_EXPIRES_IN || '7d',
    refreshSecret: process.env.JWT_REFRESH_SECRET || 'your-refresh-token-secret',
    refreshExpiresIn: process.env.JWT_REFRESH_EXPIRES_IN || '30d',
  },

  cloudinary: {
    cloudName: process.env.CLOUDINARY_CLOUD_NAME || '',
    apiKey: process.env.CLOUDINARY_API_KEY || '',
    apiSecret: process.env.CLOUDINARY_API_SECRET || '',
  },

  firebase: {
    projectId: process.env.FIREBASE_PROJECT_ID || '',
    privateKey: process.env.FIREBASE_PRIVATE_KEY?.replace(/\\n/g, '\n') || '',
    clientEmail: process.env.FIREBASE_CLIENT_EMAIL || '',
  },

  google: {
    apiKey: process.env.GOOGLE_API_KEY || '',
  },

  resend: {
    apiKey: process.env.RESEND_API_KEY || '',
    fromEmail: process.env.RESEND_FROM_EMAIL || 'onboarding@resend.dev',
  },

  rateLimit: {
    windowMs: parseInt(process.env.RATE_LIMIT_WINDOW_MS || '900000', 10),
    maxRequests: parseInt(process.env.RATE_LIMIT_MAX_REQUESTS || '100', 10),
  },

  cors: {
    origin: process.env.CORS_ORIGIN?.split(',') || ['http://localhost:3000', 'http://localhost:5173'],
  },

  app: {
    defaultCommission: parseInt(process.env.DEFAULT_COMMISSION || '15', 10),
    defaultServiceFee: parseInt(process.env.DEFAULT_SERVICE_FEE || '5', 10),
    urgentFee: parseInt(process.env.URGENT_FEE || '20', 10),
    minWithdrawal: parseInt(process.env.MIN_WITHDRAWAL || '100', 10),
  },

  twilio: {
    accountSid: process.env.TWILIO_ACCOUNT_SID || '',
    authToken: process.env.TWILIO_AUTH_TOKEN || '',
    phoneNumber: process.env.TWILIO_PHONE_NUMBER || '',
  },

  unifonic: {
    appSid: process.env.UNIFONIC_APP_SID || '',
    senderId: process.env.UNIFONIC_SENDER_ID || 'Sana3y',
  },

  paymob: {
    apiKey: process.env.PAYMOB_API_KEY || '',
    integrationId: process.env.PAYMOB_INTEGRATION_ID || '',
    iframeId: process.env.PAYMOB_IFRAME_ID || '',
    hmacSecret: process.env.PAYMOB_HMAC_SECRET || '',
  },
};

export default config;
