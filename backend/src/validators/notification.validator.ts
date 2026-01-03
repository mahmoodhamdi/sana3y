import { Request, Response, NextFunction } from 'express';
import Joi from 'joi';
import { BadRequestError } from '@utils/errors';

const registerTokenSchema = Joi.object({
  token: Joi.string().required().messages({
    'any.required': 'FCM token مطلوب',
    'string.empty': 'FCM token مطلوب',
  }),
});

const broadcastSchema = Joi.object({
  title: Joi.string().required().messages({
    'any.required': 'العنوان (English) مطلوب',
  }),
  titleAr: Joi.string().required().messages({
    'any.required': 'العنوان (Arabic) مطلوب',
  }),
  body: Joi.string().required().messages({
    'any.required': 'المحتوى (English) مطلوب',
  }),
  bodyAr: Joi.string().required().messages({
    'any.required': 'المحتوى (Arabic) مطلوب',
  }),
  targetRole: Joi.string().valid('all', 'customer', 'craftsman').required().messages({
    'any.required': 'الفئة المستهدفة مطلوبة',
    'any.only': 'الفئة المستهدفة غير صالحة',
  }),
});

const validate = (schema: Joi.ObjectSchema) => {
  return async (req: Request, _res: Response, next: NextFunction) => {
    try {
      await schema.validateAsync(req.body, { abortEarly: false });
      next();
    } catch (error) {
      if (error instanceof Joi.ValidationError) {
        const messages = error.details.map((d) => d.message).join(', ');
        next(new BadRequestError(messages));
      } else {
        next(error);
      }
    }
  };
};

export const validateRegisterToken = validate(registerTokenSchema);
export const validateBroadcast = validate(broadcastSchema);
