import multer from 'multer';
import { BadRequestError } from '@utils/errors';

// Configure multer for memory storage
const storage = multer.memoryStorage();

// File filter for images
const imageFilter = (
  _req: Express.Request,
  file: Express.Multer.File,
  cb: multer.FileFilterCallback
): void => {
  const allowedMimeTypes = ['image/jpeg', 'image/png', 'image/webp', 'image/jpg'];

  if (allowedMimeTypes.includes(file.mimetype)) {
    cb(null, true);
  } else {
    cb(new BadRequestError('نوع الملف غير مدعوم. يرجى رفع صورة (JPEG, PNG, WebP)'));
  }
};

// File filter for documents (images and PDFs)
const documentFilter = (
  _req: Express.Request,
  file: Express.Multer.File,
  cb: multer.FileFilterCallback
): void => {
  const allowedMimeTypes = [
    'image/jpeg',
    'image/png',
    'image/webp',
    'image/jpg',
    'application/pdf',
  ];

  if (allowedMimeTypes.includes(file.mimetype)) {
    cb(null, true);
  } else {
    cb(new BadRequestError('نوع الملف غير مدعوم. يرجى رفع صورة أو PDF'));
  }
};

// Single image upload (5MB max)
export const uploadSingleImage = multer({
  storage,
  fileFilter: imageFilter,
  limits: {
    fileSize: 5 * 1024 * 1024, // 5MB
  },
}).single('image');

// Multiple images upload (5 images, 5MB each)
export const uploadMultipleImages = multer({
  storage,
  fileFilter: imageFilter,
  limits: {
    fileSize: 5 * 1024 * 1024, // 5MB per file
    files: 5,
  },
}).array('images', 5);

// Profile image upload
export const uploadProfileImage = multer({
  storage,
  fileFilter: imageFilter,
  limits: {
    fileSize: 5 * 1024 * 1024, // 5MB
  },
}).single('profileImage');

// Cover image upload (10MB max for higher quality)
export const uploadCoverImage = multer({
  storage,
  fileFilter: imageFilter,
  limits: {
    fileSize: 10 * 1024 * 1024, // 10MB
  },
}).single('coverImage');

// Work photos upload (up to 10 images)
export const uploadWorkPhotos = multer({
  storage,
  fileFilter: imageFilter,
  limits: {
    fileSize: 5 * 1024 * 1024, // 5MB per file
    files: 10,
  },
}).array('workPhotos', 10);

// Document upload (single)
export const uploadDocument = multer({
  storage,
  fileFilter: documentFilter,
  limits: {
    fileSize: 10 * 1024 * 1024, // 10MB
  },
}).single('document');

// Multiple documents upload
export const uploadDocuments = multer({
  storage,
  fileFilter: documentFilter,
  limits: {
    fileSize: 10 * 1024 * 1024, // 10MB per file
    files: 5,
  },
}).array('documents', 5);

// Category image upload
export const uploadCategoryImage = multer({
  storage,
  fileFilter: imageFilter,
  limits: {
    fileSize: 2 * 1024 * 1024, // 2MB
  },
}).single('image');

// Request images upload
export const uploadRequestImages = multer({
  storage,
  fileFilter: imageFilter,
  limits: {
    fileSize: 5 * 1024 * 1024, // 5MB per file
    files: 5,
  },
}).array('images', 5);

// Flexible field upload for multiple types
export const uploadFields = multer({
  storage,
  fileFilter: (req, file, cb) => {
    const allowedMimeTypes = [
      'image/jpeg',
      'image/png',
      'image/webp',
      'image/jpg',
      'application/pdf',
    ];

    if (allowedMimeTypes.includes(file.mimetype)) {
      cb(null, true);
    } else {
      cb(new BadRequestError('نوع الملف غير مدعوم'));
    }
  },
  limits: {
    fileSize: 10 * 1024 * 1024, // 10MB per file
    files: 15,
  },
}).fields([
  { name: 'profileImage', maxCount: 1 },
  { name: 'coverImage', maxCount: 1 },
  { name: 'workPhotos', maxCount: 10 },
  { name: 'nationalIdFront', maxCount: 1 },
  { name: 'nationalIdBack', maxCount: 1 },
  { name: 'certificates', maxCount: 5 },
]);
