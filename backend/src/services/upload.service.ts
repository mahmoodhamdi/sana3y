import { v2 as cloudinary } from 'cloudinary';
import { config } from '../config';
import { BadRequestError, InternalServerError } from '@utils/errors';

// Configure Cloudinary
cloudinary.config({
  cloud_name: config.cloudinary.cloudName,
  api_key: config.cloudinary.apiKey,
  api_secret: config.cloudinary.apiSecret,
});

export interface UploadResult {
  url: string;
  publicId: string;
  width?: number;
  height?: number;
  format?: string;
  resourceType?: string;
}

export type ImageFolder =
  | 'profiles'
  | 'covers'
  | 'work-photos'
  | 'documents'
  | 'categories'
  | 'requests';

interface UploadOptions {
  folder: ImageFolder;
  transformation?: {
    width?: number;
    height?: number;
    crop?: string;
    quality?: string | number;
  };
  allowedFormats?: string[];
  maxSize?: number; // in bytes
}

class UploadService {
  private readonly defaultTransformations: Record<ImageFolder, object> = {
    profiles: { width: 400, height: 400, crop: 'fill', quality: 'auto' },
    covers: { width: 1200, height: 400, crop: 'fill', quality: 'auto' },
    'work-photos': { width: 800, height: 800, crop: 'limit', quality: 'auto' },
    documents: { quality: 'auto:good' },
    categories: { width: 200, height: 200, crop: 'fill', quality: 'auto' },
    requests: { width: 800, height: 800, crop: 'limit', quality: 'auto' },
  };

  private readonly defaultMaxSizes: Record<ImageFolder, number> = {
    profiles: 5 * 1024 * 1024, // 5MB
    covers: 10 * 1024 * 1024, // 10MB
    'work-photos': 5 * 1024 * 1024, // 5MB
    documents: 10 * 1024 * 1024, // 10MB
    categories: 2 * 1024 * 1024, // 2MB
    requests: 5 * 1024 * 1024, // 5MB
  };

  /**
   * Upload a single image from buffer
   */
  async uploadImage(
    buffer: Buffer,
    options: UploadOptions
  ): Promise<UploadResult> {
    const { folder, transformation, maxSize } = options;

    // Check file size
    const actualMaxSize = maxSize || this.defaultMaxSizes[folder];
    if (buffer.length > actualMaxSize) {
      throw new BadRequestError(
        `حجم الملف يتجاوز الحد المسموح (${Math.round(actualMaxSize / 1024 / 1024)}MB)`
      );
    }

    const uploadTransformation = transformation || this.defaultTransformations[folder];

    try {
      return new Promise<UploadResult>((resolve, reject) => {
        cloudinary.uploader
          .upload_stream(
            {
              folder: `sana3y/${folder}`,
              resource_type: 'image',
              transformation: uploadTransformation,
              allowed_formats: options.allowedFormats || ['jpg', 'jpeg', 'png', 'webp'],
            },
            (error, result) => {
              if (error || !result) {
                reject(new InternalServerError('فشل في رفع الصورة'));
                return;
              }

              resolve({
                url: result.secure_url,
                publicId: result.public_id,
                width: result.width,
                height: result.height,
                format: result.format,
                resourceType: result.resource_type,
              });
            }
          )
          .end(buffer);
      });
    } catch {
      throw new InternalServerError('فشل في رفع الصورة');
    }
  }

  /**
   * Upload a single image from base64
   */
  async uploadImageBase64(
    base64Data: string,
    options: UploadOptions
  ): Promise<UploadResult> {
    const { folder, transformation } = options;

    // Extract base64 data
    const matches = base64Data.match(/^data:image\/(\w+);base64,(.+)$/);
    if (!matches) {
      throw new BadRequestError('صيغة الصورة غير صالحة');
    }

    const uploadTransformation = transformation || this.defaultTransformations[folder];

    try {
      const result = await cloudinary.uploader.upload(base64Data, {
        folder: `sana3y/${folder}`,
        resource_type: 'image',
        transformation: uploadTransformation,
        allowed_formats: options.allowedFormats || ['jpg', 'jpeg', 'png', 'webp'],
      });

      return {
        url: result.secure_url,
        publicId: result.public_id,
        width: result.width,
        height: result.height,
        format: result.format,
        resourceType: result.resource_type,
      };
    } catch {
      throw new InternalServerError('فشل في رفع الصورة');
    }
  }

  /**
   * Upload multiple images
   */
  async uploadImages(
    buffers: Buffer[],
    options: UploadOptions
  ): Promise<UploadResult[]> {
    const uploadPromises = buffers.map((buffer) => this.uploadImage(buffer, options));
    return Promise.all(uploadPromises);
  }

  /**
   * Delete an image by public ID
   */
  async deleteImage(publicId: string): Promise<boolean> {
    try {
      const result = await cloudinary.uploader.destroy(publicId);
      return result.result === 'ok';
    } catch {
      return false;
    }
  }

  /**
   * Delete multiple images
   */
  async deleteImages(publicIds: string[]): Promise<void> {
    if (publicIds.length === 0) return;

    try {
      await cloudinary.api.delete_resources(publicIds);
    } catch {
      // Log error but don't throw - deletion failures shouldn't break the flow
    }
  }

  /**
   * Get public ID from Cloudinary URL
   */
  getPublicIdFromUrl(url: string): string | null {
    try {
      const matches = url.match(/sana3y\/([^.]+)/);
      return matches ? `sana3y/${matches[1]}` : null;
    } catch {
      return null;
    }
  }

  /**
   * Upload a document (PDF or image)
   */
  async uploadDocument(
    buffer: Buffer,
    mimeType: string
  ): Promise<UploadResult> {
    const isPdf = mimeType === 'application/pdf';
    const maxSize = 10 * 1024 * 1024; // 10MB

    if (buffer.length > maxSize) {
      throw new BadRequestError('حجم الملف يتجاوز الحد المسموح (10MB)');
    }

    try {
      return new Promise<UploadResult>((resolve, reject) => {
        cloudinary.uploader
          .upload_stream(
            {
              folder: 'sana3y/documents',
              resource_type: isPdf ? 'raw' : 'image',
              allowed_formats: isPdf ? ['pdf'] : ['jpg', 'jpeg', 'png'],
            },
            (error, result) => {
              if (error || !result) {
                reject(new InternalServerError('فشل في رفع المستند'));
                return;
              }

              resolve({
                url: result.secure_url,
                publicId: result.public_id,
                format: result.format,
                resourceType: result.resource_type,
              });
            }
          )
          .end(buffer);
      });
    } catch {
      throw new InternalServerError('فشل في رفع المستند');
    }
  }

  /**
   * Generate a thumbnail URL for an existing image
   */
  generateThumbnailUrl(
    originalUrl: string,
    width = 150,
    height = 150
  ): string {
    try {
      // Replace the transformation part of the URL
      return originalUrl.replace(
        '/upload/',
        `/upload/w_${width},h_${height},c_fill/`
      );
    } catch {
      return originalUrl;
    }
  }
}

export default new UploadService();
