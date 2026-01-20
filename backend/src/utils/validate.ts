import Joi from 'joi';
import { BadRequestError } from './errors';
import { Types } from 'mongoose';

/**
 * Validate request data against a Joi schema
 * Throws BadRequestError if validation fails
 */
export const validateSchema = <T>(schema: Joi.ObjectSchema<T>, data: unknown): T => {
  const { error, value } = schema.validate(data, {
    abortEarly: false,
    stripUnknown: true,
  });

  if (error) {
    const message = error.details.map((d) => d.message).join(', ');
    throw new BadRequestError(message);
  }

  return value;
};

/**
 * Validate MongoDB ObjectId
 */
export const validateObjectId = (id: string, fieldName: string = 'ID'): Types.ObjectId => {
  if (!Types.ObjectId.isValid(id)) {
    throw new BadRequestError(`Invalid ${fieldName} format`);
  }
  return new Types.ObjectId(id);
};

/**
 * Common Joi validators
 */
export const commonValidators = {
  // MongoDB ObjectId
  objectId: Joi.string()
    .pattern(/^[0-9a-fA-F]{24}$/)
    .messages({
      'string.pattern.base': 'Invalid ID format',
    }),

  // Egyptian phone number
  egyptPhone: Joi.string()
    .pattern(/^(\+20|0)?1[0125]\d{8}$/)
    .messages({
      'string.pattern.base': 'Please provide a valid Egyptian phone number',
    }),

  // Pagination
  page: Joi.number().integer().min(1).default(1),
  limit: Joi.number().integer().min(1).max(100).default(20),

  // Location (GeoJSON Point)
  location: Joi.object({
    type: Joi.string().valid('Point').default('Point'),
    coordinates: Joi.array()
      .items(Joi.number())
      .length(2)
      .required()
      .messages({
        'array.length': 'Coordinates must have exactly 2 elements [longitude, latitude]',
      }),
  }),

  // Arabic text with minimum length
  arabicText: (min: number = 2, max: number = 500) =>
    Joi.string()
      .min(min)
      .max(max)
      .trim()
      .messages({
        'string.min': `Must be at least ${min} characters`,
        'string.max': `Cannot exceed ${max} characters`,
      }),

  // Email
  email: Joi.string()
    .email()
    .lowercase()
    .trim()
    .messages({
      'string.email': 'Please provide a valid email address',
    }),

  // Password
  password: Joi.string()
    .min(6)
    .max(50)
    .messages({
      'string.min': 'Password must be at least 6 characters',
      'string.max': 'Password cannot exceed 50 characters',
    }),
};

export default validateSchema;
