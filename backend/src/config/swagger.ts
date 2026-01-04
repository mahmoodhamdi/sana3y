import swaggerJsdoc from 'swagger-jsdoc';
import { config } from './index';

const swaggerDefinition = {
  openapi: '3.0.0',
  info: {
    title: 'Sana3y API - صنايعي',
    version: '1.0.0',
    description: `
# صنايعي API Documentation

Sana3y (صنايعي) is a platform connecting customers with local craftsmen/handymen for home services in Egypt.

## Authentication
Most endpoints require authentication via JWT Bearer token. After login, include the token in the Authorization header:
\`\`\`
Authorization: Bearer <your_token>
\`\`\`

## User Roles
- **customer** - Request services from craftsmen
- **craftsman** - Accept and complete jobs (requires approval)
- **admin** - Full platform management

## Phone Format
Egyptian phone numbers must be in format: \`+20XXXXXXXXXX\`

## Response Format
All responses follow this structure:
\`\`\`json
{
  "success": true/false,
  "message": "Response message",
  "data": { ... }
}
\`\`\`
    `,
    contact: {
      name: 'Sana3y Support',
      email: 'support@sana3y.com',
    },
    license: {
      name: 'Private',
    },
  },
  servers: [
    {
      url: `http://localhost:${config.port}/api/v1`,
      description: 'Development server',
    },
    {
      url: 'https://api.sana3y.com/api/v1',
      description: 'Production server',
    },
  ],
  tags: [
    { name: 'Auth', description: 'Authentication and authorization endpoints' },
    { name: 'Categories', description: 'Service categories management' },
    { name: 'Craftsmen', description: 'Craftsmen profiles and management' },
    { name: 'Requests', description: 'Service requests lifecycle' },
    { name: 'Chat', description: 'Conversations and messaging' },
    { name: 'Reviews', description: 'Reviews and ratings' },
    { name: 'Notifications', description: 'Push notifications management' },
    { name: 'Upload', description: 'File uploads (images, documents)' },
  ],
  components: {
    securitySchemes: {
      bearerAuth: {
        type: 'http',
        scheme: 'bearer',
        bearerFormat: 'JWT',
        description: 'Enter your JWT token',
      },
    },
    schemas: {
      // Common Schemas
      Error: {
        type: 'object',
        properties: {
          success: { type: 'boolean', example: false },
          message: { type: 'string', example: 'Error message' },
          errors: {
            type: 'array',
            items: { type: 'object' },
          },
        },
      },
      Success: {
        type: 'object',
        properties: {
          success: { type: 'boolean', example: true },
          message: { type: 'string' },
        },
      },
      Pagination: {
        type: 'object',
        properties: {
          page: { type: 'integer', example: 1 },
          limit: { type: 'integer', example: 10 },
          total: { type: 'integer', example: 100 },
          pages: { type: 'integer', example: 10 },
        },
      },

      // User Schemas
      User: {
        type: 'object',
        properties: {
          _id: { type: 'string', example: '507f1f77bcf86cd799439011' },
          role: { type: 'string', enum: ['customer', 'craftsman', 'admin'] },
          phone: { type: 'string', example: '+201234567890' },
          email: { type: 'string', example: 'user@example.com' },
          name: { type: 'string', example: 'محمد أحمد' },
          avatar: { type: 'string', example: 'https://cloudinary.com/avatar.jpg' },
          isPhoneVerified: { type: 'boolean' },
          isActive: { type: 'boolean' },
          createdAt: { type: 'string', format: 'date-time' },
          updatedAt: { type: 'string', format: 'date-time' },
        },
      },

      // Auth Schemas
      SendOtpRequest: {
        type: 'object',
        required: ['phone'],
        properties: {
          phone: {
            type: 'string',
            pattern: '^\\+20[0-9]{10}$',
            example: '+201234567890',
            description: 'Egyptian phone number in international format',
          },
        },
      },
      SendOtpResponse: {
        type: 'object',
        properties: {
          success: { type: 'boolean', example: true },
          message: { type: 'string', example: 'تم إرسال رمز التحقق' },
          data: {
            type: 'object',
            properties: {
              phone: { type: 'string' },
              expiresAt: { type: 'string', format: 'date-time' },
              devCode: { type: 'string', description: 'Only in development mode' },
            },
          },
        },
      },
      VerifyOtpRequest: {
        type: 'object',
        required: ['phone', 'code'],
        properties: {
          phone: { type: 'string', example: '+201234567890' },
          code: { type: 'string', example: '123456', minLength: 6, maxLength: 6 },
        },
      },
      RegisterRequest: {
        type: 'object',
        required: ['phone', 'name', 'role'],
        properties: {
          phone: { type: 'string', example: '+201234567890' },
          name: { type: 'string', example: 'محمد أحمد', minLength: 2, maxLength: 100 },
          role: { type: 'string', enum: ['customer', 'craftsman'] },
          email: { type: 'string', example: 'user@example.com' },
          password: { type: 'string', minLength: 6 },
        },
      },
      LoginOtpRequest: {
        type: 'object',
        required: ['phone', 'code'],
        properties: {
          phone: { type: 'string', example: '+201234567890' },
          code: { type: 'string', example: '123456' },
        },
      },
      LoginPasswordRequest: {
        type: 'object',
        required: ['phone', 'password'],
        properties: {
          phone: { type: 'string', example: '+201234567890' },
          password: { type: 'string' },
        },
      },
      AuthResponse: {
        type: 'object',
        properties: {
          success: { type: 'boolean', example: true },
          message: { type: 'string' },
          data: {
            type: 'object',
            properties: {
              user: { $ref: '#/components/schemas/User' },
              token: { type: 'string' },
              refreshToken: { type: 'string' },
            },
          },
        },
      },

      // Category Schemas
      Category: {
        type: 'object',
        properties: {
          _id: { type: 'string' },
          nameAr: { type: 'string', example: 'كهرباء' },
          nameEn: { type: 'string', example: 'Electrical' },
          slug: { type: 'string', example: 'electrical' },
          icon: { type: 'string' },
          image: { type: 'string' },
          description: { type: 'string' },
          parentId: { type: 'string' },
          isActive: { type: 'boolean' },
          order: { type: 'integer' },
          subcategories: {
            type: 'array',
            items: { $ref: '#/components/schemas/Subcategory' },
          },
        },
      },
      Subcategory: {
        type: 'object',
        properties: {
          _id: { type: 'string' },
          nameAr: { type: 'string' },
          nameEn: { type: 'string' },
          slug: { type: 'string' },
          icon: { type: 'string' },
          isActive: { type: 'boolean' },
        },
      },
      CreateCategoryRequest: {
        type: 'object',
        required: ['nameAr'],
        properties: {
          nameAr: { type: 'string', example: 'سباكة' },
          nameEn: { type: 'string', example: 'Plumbing' },
          icon: { type: 'string' },
          image: { type: 'string' },
          description: { type: 'string' },
          order: { type: 'integer' },
        },
      },

      // Craftsman Schemas
      Craftsman: {
        type: 'object',
        properties: {
          _id: { type: 'string' },
          userId: { type: 'string' },
          user: { $ref: '#/components/schemas/User' },
          bio: { type: 'string' },
          services: {
            type: 'array',
            items: { $ref: '#/components/schemas/CraftsmanService' },
          },
          workingHours: { $ref: '#/components/schemas/WorkingHours' },
          location: { $ref: '#/components/schemas/GeoLocation' },
          serviceRadius: { type: 'number', example: 10 },
          coverImage: { type: 'string' },
          workPhotos: { type: 'array', items: { type: 'string' } },
          idDocument: { type: 'string' },
          status: {
            type: 'string',
            enum: ['pending', 'approved', 'suspended', 'rejected'],
          },
          rating: { type: 'number', example: 4.5 },
          totalRatings: { type: 'integer' },
          completedJobs: { type: 'integer' },
          isOnline: { type: 'boolean' },
          isAvailable: { type: 'boolean' },
          isFeatured: { type: 'boolean' },
          totalEarnings: { type: 'number' },
          availableBalance: { type: 'number' },
        },
      },
      CraftsmanService: {
        type: 'object',
        properties: {
          categoryId: { type: 'string' },
          subcategoryId: { type: 'string' },
          priceRange: {
            type: 'object',
            properties: {
              min: { type: 'number' },
              max: { type: 'number' },
            },
          },
          description: { type: 'string' },
        },
      },
      WorkingHours: {
        type: 'object',
        properties: {
          saturday: { $ref: '#/components/schemas/DayHours' },
          sunday: { $ref: '#/components/schemas/DayHours' },
          monday: { $ref: '#/components/schemas/DayHours' },
          tuesday: { $ref: '#/components/schemas/DayHours' },
          wednesday: { $ref: '#/components/schemas/DayHours' },
          thursday: { $ref: '#/components/schemas/DayHours' },
          friday: { $ref: '#/components/schemas/DayHours' },
        },
      },
      DayHours: {
        type: 'object',
        properties: {
          isOpen: { type: 'boolean' },
          openTime: { type: 'string', example: '08:00' },
          closeTime: { type: 'string', example: '18:00' },
        },
      },
      GeoLocation: {
        type: 'object',
        properties: {
          type: { type: 'string', enum: ['Point'], default: 'Point' },
          coordinates: {
            type: 'array',
            items: { type: 'number' },
            example: [30.9667, 30.4522],
            description: '[longitude, latitude]',
          },
          address: { type: 'string' },
          city: { type: 'string', example: 'الباجور' },
          governorate: { type: 'string', example: 'المنوفية' },
        },
      },
      CreateCraftsmanRequest: {
        type: 'object',
        required: ['services', 'location'],
        properties: {
          bio: { type: 'string' },
          services: {
            type: 'array',
            items: { $ref: '#/components/schemas/CraftsmanService' },
          },
          location: { $ref: '#/components/schemas/GeoLocation' },
          serviceRadius: { type: 'number', default: 10 },
          idDocument: { type: 'string' },
        },
      },

      // Service Request Schemas
      ServiceRequest: {
        type: 'object',
        properties: {
          _id: { type: 'string' },
          customerId: { type: 'string' },
          craftsmanId: { type: 'string' },
          categoryId: { type: 'string' },
          subcategoryId: { type: 'string' },
          title: { type: 'string', example: 'تصليح كهرباء المطبخ' },
          description: { type: 'string' },
          images: { type: 'array', items: { type: 'string' } },
          location: { $ref: '#/components/schemas/GeoLocation' },
          budget: { $ref: '#/components/schemas/Budget' },
          preferredTime: { $ref: '#/components/schemas/PreferredTime' },
          isUrgent: { type: 'boolean' },
          status: {
            type: 'string',
            enum: [
              'pending',
              'quoted',
              'accepted',
              'in_progress',
              'completed',
              'cancelled',
              'expired',
            ],
          },
          quotes: {
            type: 'array',
            items: { $ref: '#/components/schemas/Quote' },
          },
          acceptedQuote: { $ref: '#/components/schemas/Quote' },
          totalAmount: { type: 'number' },
          commission: { type: 'number' },
          serviceFee: { type: 'number' },
          createdAt: { type: 'string', format: 'date-time' },
        },
      },
      Budget: {
        type: 'object',
        properties: {
          min: { type: 'number', example: 100 },
          max: { type: 'number', example: 500 },
        },
      },
      PreferredTime: {
        type: 'object',
        properties: {
          date: { type: 'string', format: 'date' },
          timeSlot: { type: 'string', enum: ['morning', 'afternoon', 'evening'] },
          flexibleDate: { type: 'boolean' },
        },
      },
      Quote: {
        type: 'object',
        properties: {
          _id: { type: 'string' },
          craftsmanId: { type: 'string' },
          price: { type: 'number' },
          estimatedDuration: { type: 'string' },
          notes: { type: 'string' },
          status: { type: 'string', enum: ['pending', 'accepted', 'rejected', 'withdrawn'] },
          createdAt: { type: 'string', format: 'date-time' },
        },
      },
      CreateRequestRequest: {
        type: 'object',
        required: ['categoryId', 'title', 'description', 'location'],
        properties: {
          categoryId: { type: 'string' },
          subcategoryId: { type: 'string' },
          title: { type: 'string', minLength: 10, maxLength: 200 },
          description: { type: 'string', minLength: 20, maxLength: 2000 },
          images: { type: 'array', items: { type: 'string' }, maxItems: 5 },
          location: { $ref: '#/components/schemas/GeoLocation' },
          budget: { $ref: '#/components/schemas/Budget' },
          preferredTime: { $ref: '#/components/schemas/PreferredTime' },
          isUrgent: { type: 'boolean', default: false },
        },
      },
      SubmitQuoteRequest: {
        type: 'object',
        required: ['price'],
        properties: {
          price: { type: 'number', minimum: 1 },
          estimatedDuration: { type: 'string' },
          notes: { type: 'string' },
        },
      },
      UpdateStatusRequest: {
        type: 'object',
        required: ['status'],
        properties: {
          status: {
            type: 'string',
            enum: ['in_progress', 'completed', 'cancelled'],
          },
          notes: { type: 'string' },
        },
      },

      // Chat Schemas
      Conversation: {
        type: 'object',
        properties: {
          _id: { type: 'string' },
          requestId: { type: 'string' },
          participants: {
            type: 'array',
            items: { $ref: '#/components/schemas/Participant' },
          },
          lastMessage: { $ref: '#/components/schemas/Message' },
          isActive: { type: 'boolean' },
          createdAt: { type: 'string', format: 'date-time' },
        },
      },
      Participant: {
        type: 'object',
        properties: {
          userId: { type: 'string' },
          unreadCount: { type: 'integer' },
          lastReadAt: { type: 'string', format: 'date-time' },
        },
      },
      Message: {
        type: 'object',
        properties: {
          _id: { type: 'string' },
          conversationId: { type: 'string' },
          senderId: { type: 'string' },
          content: { type: 'string' },
          type: { type: 'string', enum: ['text', 'image', 'system'] },
          imageUrl: { type: 'string' },
          isRead: { type: 'boolean' },
          createdAt: { type: 'string', format: 'date-time' },
        },
      },
      CreateConversationRequest: {
        type: 'object',
        required: ['requestId', 'recipientId'],
        properties: {
          requestId: { type: 'string' },
          recipientId: { type: 'string' },
        },
      },
      SendMessageRequest: {
        type: 'object',
        required: ['content'],
        properties: {
          content: { type: 'string', maxLength: 2000 },
          type: { type: 'string', enum: ['text', 'image'], default: 'text' },
          imageUrl: { type: 'string' },
        },
      },

      // Review Schemas
      Review: {
        type: 'object',
        properties: {
          _id: { type: 'string' },
          requestId: { type: 'string' },
          customerId: { type: 'string' },
          craftsmanId: { type: 'string' },
          score: { type: 'integer', minimum: 1, maximum: 5 },
          comment: { type: 'string' },
          images: { type: 'array', items: { type: 'string' } },
          qualities: { $ref: '#/components/schemas/QualityRatings' },
          craftsmanResponse: { type: 'string' },
          isVisible: { type: 'boolean' },
          createdAt: { type: 'string', format: 'date-time' },
        },
      },
      QualityRatings: {
        type: 'object',
        properties: {
          punctuality: { type: 'integer', minimum: 1, maximum: 5 },
          professionalism: { type: 'integer', minimum: 1, maximum: 5 },
          quality: { type: 'integer', minimum: 1, maximum: 5 },
          cleanliness: { type: 'integer', minimum: 1, maximum: 5 },
          communication: { type: 'integer', minimum: 1, maximum: 5 },
        },
      },
      CreateReviewRequest: {
        type: 'object',
        required: ['requestId', 'craftsmanId', 'score'],
        properties: {
          requestId: { type: 'string' },
          craftsmanId: { type: 'string' },
          score: { type: 'integer', minimum: 1, maximum: 5 },
          comment: { type: 'string', maxLength: 1000 },
          images: { type: 'array', items: { type: 'string' }, maxItems: 5 },
          qualities: { $ref: '#/components/schemas/QualityRatings' },
        },
      },
      ReviewSummary: {
        type: 'object',
        properties: {
          averageRating: { type: 'number' },
          totalReviews: { type: 'integer' },
          ratingDistribution: {
            type: 'object',
            properties: {
              '5': { type: 'integer' },
              '4': { type: 'integer' },
              '3': { type: 'integer' },
              '2': { type: 'integer' },
              '1': { type: 'integer' },
            },
          },
          qualityAverages: { $ref: '#/components/schemas/QualityRatings' },
        },
      },

      // Notification Schemas
      Notification: {
        type: 'object',
        properties: {
          _id: { type: 'string' },
          userId: { type: 'string' },
          type: {
            type: 'string',
            enum: [
              'request_new',
              'request_quote',
              'request_accepted',
              'request_completed',
              'request_cancelled',
              'review_received',
              'message_new',
              'system',
            ],
          },
          title: { type: 'string' },
          body: { type: 'string' },
          data: { type: 'object' },
          isRead: { type: 'boolean' },
          createdAt: { type: 'string', format: 'date-time' },
        },
      },
      RegisterFCMTokenRequest: {
        type: 'object',
        required: ['token'],
        properties: {
          token: { type: 'string' },
          platform: { type: 'string', enum: ['android', 'ios', 'web'] },
        },
      },
      BroadcastRequest: {
        type: 'object',
        required: ['title', 'body', 'targetRole'],
        properties: {
          title: { type: 'string' },
          body: { type: 'string' },
          targetRole: { type: 'string', enum: ['all', 'customer', 'craftsman'] },
          data: { type: 'object' },
        },
      },

      // Upload Schemas
      UploadResponse: {
        type: 'object',
        properties: {
          success: { type: 'boolean', example: true },
          message: { type: 'string' },
          data: {
            type: 'object',
            properties: {
              url: { type: 'string' },
              publicId: { type: 'string' },
            },
          },
        },
      },
      MultiUploadResponse: {
        type: 'object',
        properties: {
          success: { type: 'boolean', example: true },
          message: { type: 'string' },
          data: {
            type: 'object',
            properties: {
              urls: { type: 'array', items: { type: 'string' } },
            },
          },
        },
      },
    },
    responses: {
      UnauthorizedError: {
        description: 'Access token is missing or invalid',
        content: {
          'application/json': {
            schema: { $ref: '#/components/schemas/Error' },
          },
        },
      },
      NotFoundError: {
        description: 'Resource not found',
        content: {
          'application/json': {
            schema: { $ref: '#/components/schemas/Error' },
          },
        },
      },
      ValidationError: {
        description: 'Validation error',
        content: {
          'application/json': {
            schema: { $ref: '#/components/schemas/Error' },
          },
        },
      },
      ForbiddenError: {
        description: 'Access forbidden',
        content: {
          'application/json': {
            schema: { $ref: '#/components/schemas/Error' },
          },
        },
      },
    },
  },
};

const options: swaggerJsdoc.Options = {
  swaggerDefinition,
  apis: ['./src/routes/*.ts', './src/docs/*.yaml'],
};

export const swaggerSpec = swaggerJsdoc(options);

export default swaggerSpec;
