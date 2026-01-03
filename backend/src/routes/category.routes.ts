import { Router } from 'express';
import {
  getCategories,
  getActiveCategories,
  getPopularCategories,
  getCategoryById,
  getCategoryBySlug,
  createCategory,
  updateCategory,
  deleteCategory,
  addSubcategory,
  updateSubcategory,
  removeSubcategory,
  reorderCategories,
} from '@controllers/category.controller';
import { authenticate, requireRole } from '@middleware/auth';

const router = Router();

// Public routes
router.get('/active', getActiveCategories);
router.get('/popular', getPopularCategories);
router.get('/slug/:slug', getCategoryBySlug);

// Admin routes
router.get('/', authenticate, requireRole('admin'), getCategories);
router.post('/', authenticate, requireRole('admin'), createCategory);
router.put('/reorder', authenticate, requireRole('admin'), reorderCategories);
router.get('/:id', getCategoryById);
router.put('/:id', authenticate, requireRole('admin'), updateCategory);
router.delete('/:id', authenticate, requireRole('admin'), deleteCategory);

// Subcategory routes (Admin only)
router.post('/:id/subcategories', authenticate, requireRole('admin'), addSubcategory);
router.put('/:id/subcategories/:subcategoryId', authenticate, requireRole('admin'), updateSubcategory);
router.delete('/:id/subcategories/:subcategoryId', authenticate, requireRole('admin'), removeSubcategory);

export default router;
