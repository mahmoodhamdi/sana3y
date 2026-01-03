import { v2 as cloudinary } from 'cloudinary';
import { config } from './index';
import { logger } from '../utils/logger';

export const configureCloudinary = (): void => {
  if (!config.cloudinary.cloudName || !config.cloudinary.apiKey || !config.cloudinary.apiSecret) {
    logger.warn('Cloudinary configuration is incomplete. File uploads may not work.');
    return;
  }

  cloudinary.config({
    cloud_name: config.cloudinary.cloudName,
    api_key: config.cloudinary.apiKey,
    api_secret: config.cloudinary.apiSecret,
    secure: true,
  });

  logger.info('Cloudinary configured successfully');
};

export const uploadToCloudinary = async (
  filePath: string,
  folder: string = 'sana3y'
): Promise<{ url: string; publicId: string }> => {
  const result = await cloudinary.uploader.upload(filePath, {
    folder,
    resource_type: 'auto',
  });

  return {
    url: result.secure_url,
    publicId: result.public_id,
  };
};

export const deleteFromCloudinary = async (publicId: string): Promise<void> => {
  await cloudinary.uploader.destroy(publicId);
};

export { cloudinary };
