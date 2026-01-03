import { Router } from 'express';
import {
  uploadImage,
  uploadImages,
  uploadProfileImage,
  uploadCoverImage,
  uploadWorkPhotos,
  uploadDocument,
  uploadCategoryImage,
  deleteImage,
  uploadBase64Image,
} from '@controllers/upload.controller';
import { authenticate, requireRole } from '@middleware/auth';
import {
  uploadSingleImage,
  uploadMultipleImages,
  uploadProfileImage as multerProfile,
  uploadCoverImage as multerCover,
  uploadWorkPhotos as multerWorkPhotos,
  uploadDocument as multerDocument,
  uploadCategoryImage as multerCategory,
} from '@middleware/upload';

const router = Router();

// All upload routes require authentication
router.use(authenticate);

// General image upload
router.post('/image', uploadSingleImage, uploadImage);
router.post('/images', uploadMultipleImages, uploadImages);

// Specific image uploads
router.post('/profile', multerProfile, uploadProfileImage);
router.post('/cover', multerCover, uploadCoverImage);
router.post('/work-photos', requireRole('craftsman'), multerWorkPhotos, uploadWorkPhotos);
router.post('/document', multerDocument, uploadDocument);

// Base64 upload
router.post('/base64', uploadBase64Image);

// Category image (Admin only)
router.post('/category', requireRole('admin'), multerCategory, uploadCategoryImage);

// Delete image
router.delete('/', deleteImage);

export default router;
