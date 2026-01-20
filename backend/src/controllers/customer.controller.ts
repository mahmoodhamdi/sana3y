import { Request, Response, NextFunction } from 'express';
import { sendSuccess, sendCreated } from '@utils/response';
import { BadRequestError, NotFoundError, ForbiddenError } from '@utils/errors';
import Customer from '@models/Customer';
import Craftsman from '@models/Craftsman';
import { Types } from 'mongoose';
import Joi from 'joi';

// ============================================
// Address Management
// ============================================

/**
 * Get all addresses for current customer
 * GET /api/v1/customers/addresses
 */
export const getAddresses = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const customer = await Customer.findOne({ userId: req.user?._id });
    if (!customer) {
      throw new NotFoundError('ملف العميل غير موجود');
    }

    return sendSuccess(res, customer.addresses, 'تم جلب العناوين');
  } catch (err) {
    next(err);
  }
};

/**
 * Add new address
 * POST /api/v1/customers/addresses
 */
export const addAddress = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const schema = Joi.object({
      label: Joi.string().valid('home', 'work', 'other').default('home'),
      name: Joi.string().required().min(2).max(100),
      address: Joi.string().required().min(5).max(500),
      area: Joi.string().required(),
      city: Joi.string().default('الباجور'),
      landmark: Joi.string().allow('').optional(),
      location: Joi.object({
        type: Joi.string().valid('Point').default('Point'),
        coordinates: Joi.array().items(Joi.number()).length(2).required(),
      }).required(),
      isDefault: Joi.boolean().default(false),
    });

    const { error, value } = schema.validate(req.body);
    if (error) {
      throw new BadRequestError(error.details[0].message);
    }

    const customer = await Customer.findOne({ userId: req.user?._id });
    if (!customer) {
      // Create customer profile if doesn't exist
      const newCustomer = await Customer.create({
        userId: req.user?._id,
        addresses: [],
      });
      customer === newCustomer;
    }

    if (customer!.addresses.length >= 10) {
      throw new BadRequestError('لا يمكن إضافة أكثر من 10 عناوين');
    }

    // If setting as default, unset other defaults
    if (value.isDefault || customer!.addresses.length === 0) {
      customer!.addresses.forEach((addr) => {
        addr.isDefault = false;
      });
      value.isDefault = true;
    }

    const newAddress = {
      _id: new Types.ObjectId(),
      ...value,
    };

    customer!.addresses.push(newAddress);
    await customer!.save();

    return sendCreated(res, newAddress, 'تم إضافة العنوان');
  } catch (err) {
    next(err);
  }
};

/**
 * Update address
 * PUT /api/v1/customers/addresses/:id
 */
export const updateAddress = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const schema = Joi.object({
      label: Joi.string().valid('home', 'work', 'other'),
      name: Joi.string().min(2).max(100),
      address: Joi.string().min(5).max(500),
      area: Joi.string(),
      city: Joi.string(),
      landmark: Joi.string().allow(''),
      location: Joi.object({
        type: Joi.string().valid('Point').default('Point'),
        coordinates: Joi.array().items(Joi.number()).length(2),
      }),
      isDefault: Joi.boolean(),
    });

    const { error, value } = schema.validate(req.body);
    if (error) {
      throw new BadRequestError(error.details[0].message);
    }

    const customer = await Customer.findOne({ userId: req.user?._id });
    if (!customer) {
      throw new NotFoundError('ملف العميل غير موجود');
    }

    const addressIndex = customer.addresses.findIndex(
      (addr) => addr._id?.toString() === req.params.id
    );

    if (addressIndex === -1) {
      throw new NotFoundError('العنوان غير موجود');
    }

    // If setting as default, unset other defaults
    if (value.isDefault) {
      customer.addresses.forEach((addr) => {
        addr.isDefault = false;
      });
    }

    // Update address fields
    Object.assign(customer.addresses[addressIndex], value);
    await customer.save();

    return sendSuccess(res, customer.addresses[addressIndex], 'تم تحديث العنوان');
  } catch (err) {
    next(err);
  }
};

/**
 * Delete address
 * DELETE /api/v1/customers/addresses/:id
 */
export const deleteAddress = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const customer = await Customer.findOne({ userId: req.user?._id });
    if (!customer) {
      throw new NotFoundError('ملف العميل غير موجود');
    }

    const addressIndex = customer.addresses.findIndex(
      (addr) => addr._id?.toString() === req.params.id
    );

    if (addressIndex === -1) {
      throw new NotFoundError('العنوان غير موجود');
    }

    const wasDefault = customer.addresses[addressIndex].isDefault;
    customer.addresses.splice(addressIndex, 1);

    // If deleted address was default, make first one default
    if (wasDefault && customer.addresses.length > 0) {
      customer.addresses[0].isDefault = true;
    }

    await customer.save();

    return sendSuccess(res, null, 'تم حذف العنوان');
  } catch (err) {
    next(err);
  }
};

/**
 * Set address as default
 * PATCH /api/v1/customers/addresses/:id/default
 */
export const setDefaultAddress = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const customer = await Customer.findOne({ userId: req.user?._id });
    if (!customer) {
      throw new NotFoundError('ملف العميل غير موجود');
    }

    const addressIndex = customer.addresses.findIndex(
      (addr) => addr._id?.toString() === req.params.id
    );

    if (addressIndex === -1) {
      throw new NotFoundError('العنوان غير موجود');
    }

    // Unset all defaults and set the selected one
    customer.addresses.forEach((addr) => {
      addr.isDefault = false;
    });
    customer.addresses[addressIndex].isDefault = true;

    await customer.save();

    return sendSuccess(res, customer.addresses[addressIndex], 'تم تعيين العنوان كافتراضي');
  } catch (err) {
    next(err);
  }
};

// ============================================
// Favorites Management
// ============================================

/**
 * Get favorite craftsmen
 * GET /api/v1/customers/favorites
 */
export const getFavorites = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const customer = await Customer.findOne({ userId: req.user?._id })
      .populate({
        path: 'favoriteCraftsmen',
        populate: [
          { path: 'userId', select: 'name avatar' },
          { path: 'categoryId', select: 'nameAr icon' },
        ],
      })
      .lean();

    if (!customer) {
      return sendSuccess(res, [], 'لا يوجد مفضلة');
    }

    return sendSuccess(res, customer.favoriteCraftsmen, 'تم جلب المفضلة');
  } catch (err) {
    next(err);
  }
};

/**
 * Add craftsman to favorites
 * POST /api/v1/customers/favorites/:craftsmanId
 */
export const addToFavorites = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { craftsmanId } = req.params;

    // Verify craftsman exists and is approved
    const craftsman = await Craftsman.findById(craftsmanId);
    if (!craftsman) {
      throw new NotFoundError('الصنايعي غير موجود');
    }
    if (craftsman.status !== 'approved') {
      throw new BadRequestError('لا يمكن إضافة صنايعي غير معتمد للمفضلة');
    }

    let customer = await Customer.findOne({ userId: req.user?._id });
    if (!customer) {
      // Create customer profile if doesn't exist
      customer = await Customer.create({
        userId: req.user?._id,
        addresses: [],
        favoriteCraftsmen: [],
      });
    }

    // Check if already in favorites
    const craftsmanObjectId = new Types.ObjectId(craftsmanId);
    if (customer.favoriteCraftsmen.some((id) => id.equals(craftsmanObjectId))) {
      throw new BadRequestError('الصنايعي موجود بالفعل في المفضلة');
    }

    customer.favoriteCraftsmen.push(craftsmanObjectId);
    await customer.save();

    return sendCreated(res, { craftsmanId }, 'تم إضافة الصنايعي للمفضلة');
  } catch (err) {
    next(err);
  }
};

/**
 * Remove craftsman from favorites
 * DELETE /api/v1/customers/favorites/:craftsmanId
 */
export const removeFromFavorites = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { craftsmanId } = req.params;

    const customer = await Customer.findOne({ userId: req.user?._id });
    if (!customer) {
      throw new NotFoundError('ملف العميل غير موجود');
    }

    const craftsmanObjectId = new Types.ObjectId(craftsmanId);
    const index = customer.favoriteCraftsmen.findIndex((id) => id.equals(craftsmanObjectId));

    if (index === -1) {
      throw new NotFoundError('الصنايعي غير موجود في المفضلة');
    }

    customer.favoriteCraftsmen.splice(index, 1);
    await customer.save();

    return sendSuccess(res, null, 'تم إزالة الصنايعي من المفضلة');
  } catch (err) {
    next(err);
  }
};

/**
 * Check if craftsman is in favorites
 * GET /api/v1/customers/favorites/:craftsmanId/check
 */
export const checkFavorite = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { craftsmanId } = req.params;

    const customer = await Customer.findOne({ userId: req.user?._id });
    if (!customer) {
      return sendSuccess(res, { isFavorite: false });
    }

    const craftsmanObjectId = new Types.ObjectId(craftsmanId);
    const isFavorite = customer.favoriteCraftsmen.some((id) => id.equals(craftsmanObjectId));

    return sendSuccess(res, { isFavorite });
  } catch (err) {
    next(err);
  }
};

/**
 * Clear all favorites
 * DELETE /api/v1/customers/favorites
 */
export const clearFavorites = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const customer = await Customer.findOne({ userId: req.user?._id });
    if (!customer) {
      throw new NotFoundError('ملف العميل غير موجود');
    }

    customer.favoriteCraftsmen = [];
    await customer.save();

    return sendSuccess(res, null, 'تم مسح المفضلة');
  } catch (err) {
    next(err);
  }
};

// ============================================
// Customer Profile
// ============================================

/**
 * Get customer profile
 * GET /api/v1/customers/me
 */
export const getCustomerProfile = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const customer = await Customer.findOne({ userId: req.user?._id })
      .populate('userId', 'name email avatar isVerified createdAt')
      .lean();

    if (!customer) {
      // Return empty profile structure
      return sendSuccess(res, {
        userId: req.user,
        addresses: [],
        favoriteCraftsmen: [],
        totalRequests: 0,
        totalSpent: 0,
      });
    }

    return sendSuccess(res, customer, 'تم جلب ملف العميل');
  } catch (err) {
    next(err);
  }
};
