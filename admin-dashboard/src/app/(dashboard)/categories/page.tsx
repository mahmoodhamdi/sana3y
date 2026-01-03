'use client';

import { useState, useEffect } from 'react';
import { useRouter } from 'next/navigation';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
} from '@/components/ui/dialog';
import { useAuth } from '@/contexts/auth-context';

interface SubCategory {
  _id: string;
  name: string;
  nameAr: string;
  suggestedPrice?: { min: number; max: number };
}

interface Category {
  _id: string;
  name: string;
  nameAr: string;
  slug: string;
  icon?: string;
  image?: string;
  description?: string;
  descriptionAr?: string;
  subcategories: SubCategory[];
  sortOrder: number;
  isActive: boolean;
  isPopular: boolean;
  totalCraftsmen: number;
  totalJobs: number;
}

export default function CategoriesPage() {
  const { isAuthenticated, isLoading, token } = useAuth();
  const router = useRouter();
  const [categories, setCategories] = useState<Category[]>([]);
  const [loading, setLoading] = useState(true);
  const [isAddOpen, setIsAddOpen] = useState(false);
  const [editCategory, setEditCategory] = useState<Category | null>(null);

  // Form state
  const [formData, setFormData] = useState({
    name: '',
    nameAr: '',
    icon: '',
    description: '',
    descriptionAr: '',
    isActive: true,
    isPopular: false,
  });

  useEffect(() => {
    if (!isLoading && !isAuthenticated) {
      router.push('/login');
    }
  }, [isAuthenticated, isLoading, router]);

  useEffect(() => {
    if (token) {
      fetchCategories();
    }
  }, [token]);

  const fetchCategories = async () => {
    try {
      const response = await fetch(
        `${process.env.NEXT_PUBLIC_API_URL || 'http://localhost:5000'}/api/v1/categories`,
        {
          headers: {
            Authorization: `Bearer ${token}`,
          },
        }
      );
      const data = await response.json();
      if (data.success) {
        setCategories(data.data || []);
      }
    } catch (error) {
      console.error('Failed to fetch categories:', error);
    } finally {
      setLoading(false);
    }
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    try {
      const url = editCategory
        ? `${process.env.NEXT_PUBLIC_API_URL || 'http://localhost:5000'}/api/v1/categories/${editCategory._id}`
        : `${process.env.NEXT_PUBLIC_API_URL || 'http://localhost:5000'}/api/v1/categories`;

      const response = await fetch(url, {
        method: editCategory ? 'PUT' : 'POST',
        headers: {
          'Content-Type': 'application/json',
          Authorization: `Bearer ${token}`,
        },
        body: JSON.stringify(formData),
      });

      const data = await response.json();
      if (data.success) {
        fetchCategories();
        setIsAddOpen(false);
        setEditCategory(null);
        resetForm();
      }
    } catch (error) {
      console.error('Failed to save category:', error);
    }
  };

  const handleDelete = async (id: string) => {
    if (!confirm('هل أنت متأكد من حذف هذه الفئة؟')) return;

    try {
      const response = await fetch(
        `${process.env.NEXT_PUBLIC_API_URL || 'http://localhost:5000'}/api/v1/categories/${id}`,
        {
          method: 'DELETE',
          headers: {
            Authorization: `Bearer ${token}`,
          },
        }
      );

      if (response.ok) {
        fetchCategories();
      }
    } catch (error) {
      console.error('Failed to delete category:', error);
    }
  };

  const resetForm = () => {
    setFormData({
      name: '',
      nameAr: '',
      icon: '',
      description: '',
      descriptionAr: '',
      isActive: true,
      isPopular: false,
    });
  };

  const openEditDialog = (category: Category) => {
    setFormData({
      name: category.name,
      nameAr: category.nameAr,
      icon: category.icon || '',
      description: category.description || '',
      descriptionAr: category.descriptionAr || '',
      isActive: category.isActive,
      isPopular: category.isPopular,
    });
    setEditCategory(category);
    setIsAddOpen(true);
  };

  if (isLoading || loading) {
    return (
      <div className="flex h-screen items-center justify-center">
        <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-primary"></div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-gray-50 p-8">
      <div className="max-w-7xl mx-auto">
        {/* Header */}
        <div className="flex items-center justify-between mb-8">
          <div>
            <h1 className="text-2xl font-bold">الفئات</h1>
            <p className="text-muted-foreground">إدارة فئات الخدمات</p>
          </div>
          <Dialog open={isAddOpen} onOpenChange={(open) => {
            setIsAddOpen(open);
            if (!open) {
              setEditCategory(null);
              resetForm();
            }
          }}>
            <DialogTrigger asChild>
              <Button>+ إضافة فئة</Button>
            </DialogTrigger>
            <DialogContent className="max-w-md">
              <DialogHeader>
                <DialogTitle>
                  {editCategory ? 'تعديل فئة' : 'إضافة فئة جديدة'}
                </DialogTitle>
              </DialogHeader>
              <form onSubmit={handleSubmit} className="space-y-4">
                <div className="grid grid-cols-2 gap-4">
                  <div className="space-y-2">
                    <Label htmlFor="name">الاسم (English)</Label>
                    <Input
                      id="name"
                      value={formData.name}
                      onChange={(e) =>
                        setFormData({ ...formData, name: e.target.value })
                      }
                      required
                    />
                  </div>
                  <div className="space-y-2">
                    <Label htmlFor="nameAr">الاسم (عربي)</Label>
                    <Input
                      id="nameAr"
                      value={formData.nameAr}
                      onChange={(e) =>
                        setFormData({ ...formData, nameAr: e.target.value })
                      }
                      required
                    />
                  </div>
                </div>

                <div className="space-y-2">
                  <Label htmlFor="icon">رابط الأيقونة</Label>
                  <Input
                    id="icon"
                    type="url"
                    value={formData.icon}
                    onChange={(e) =>
                      setFormData({ ...formData, icon: e.target.value })
                    }
                    placeholder="https://..."
                  />
                </div>

                <div className="space-y-2">
                  <Label htmlFor="descriptionAr">الوصف</Label>
                  <Input
                    id="descriptionAr"
                    value={formData.descriptionAr}
                    onChange={(e) =>
                      setFormData({ ...formData, descriptionAr: e.target.value })
                    }
                  />
                </div>

                <div className="flex gap-4">
                  <label className="flex items-center gap-2">
                    <input
                      type="checkbox"
                      checked={formData.isActive}
                      onChange={(e) =>
                        setFormData({ ...formData, isActive: e.target.checked })
                      }
                    />
                    نشطة
                  </label>
                  <label className="flex items-center gap-2">
                    <input
                      type="checkbox"
                      checked={formData.isPopular}
                      onChange={(e) =>
                        setFormData({ ...formData, isPopular: e.target.checked })
                      }
                    />
                    شائعة
                  </label>
                </div>

                <div className="flex justify-end gap-2">
                  <Button
                    type="button"
                    variant="outline"
                    onClick={() => {
                      setIsAddOpen(false);
                      setEditCategory(null);
                      resetForm();
                    }}
                  >
                    إلغاء
                  </Button>
                  <Button type="submit">
                    {editCategory ? 'حفظ' : 'إضافة'}
                  </Button>
                </div>
              </form>
            </DialogContent>
          </Dialog>
        </div>

        {/* Categories Grid */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          {categories.map((category) => (
            <Card key={category._id}>
              <CardHeader className="flex flex-row items-start justify-between">
                <div className="flex items-center gap-3">
                  <div className="w-12 h-12 bg-primary/10 rounded-lg flex items-center justify-center">
                    {category.icon ? (
                      <img
                        src={category.icon}
                        alt={category.nameAr}
                        className="w-8 h-8"
                      />
                    ) : (
                      <span className="text-2xl">🔧</span>
                    )}
                  </div>
                  <div>
                    <CardTitle className="text-lg">{category.nameAr}</CardTitle>
                    <p className="text-sm text-muted-foreground">
                      {category.name}
                    </p>
                  </div>
                </div>
                <div className="flex gap-1">
                  <Button
                    variant="ghost"
                    size="sm"
                    onClick={() => openEditDialog(category)}
                  >
                    ✏️
                  </Button>
                  <Button
                    variant="ghost"
                    size="sm"
                    onClick={() => handleDelete(category._id)}
                  >
                    🗑️
                  </Button>
                </div>
              </CardHeader>
              <CardContent>
                <div className="flex items-center gap-4 text-sm text-muted-foreground">
                  <span>👷 {category.totalCraftsmen} صنايعي</span>
                  <span>📋 {category.totalJobs} طلب</span>
                </div>
                <div className="mt-3 flex gap-2">
                  {category.isActive ? (
                    <span className="inline-flex items-center px-2 py-1 rounded-full text-xs bg-green-100 text-green-800">
                      نشطة
                    </span>
                  ) : (
                    <span className="inline-flex items-center px-2 py-1 rounded-full text-xs bg-gray-100 text-gray-600">
                      غير نشطة
                    </span>
                  )}
                  {category.isPopular && (
                    <span className="inline-flex items-center px-2 py-1 rounded-full text-xs bg-yellow-100 text-yellow-800">
                      شائعة
                    </span>
                  )}
                </div>
                {category.subcategories.length > 0 && (
                  <div className="mt-3 pt-3 border-t">
                    <p className="text-sm font-medium mb-2">
                      الفئات الفرعية ({category.subcategories.length})
                    </p>
                    <div className="flex flex-wrap gap-1">
                      {category.subcategories.slice(0, 3).map((sub) => (
                        <span
                          key={sub._id}
                          className="text-xs bg-gray-100 px-2 py-1 rounded"
                        >
                          {sub.nameAr}
                        </span>
                      ))}
                      {category.subcategories.length > 3 && (
                        <span className="text-xs text-muted-foreground">
                          +{category.subcategories.length - 3}
                        </span>
                      )}
                    </div>
                  </div>
                )}
              </CardContent>
            </Card>
          ))}
        </div>

        {categories.length === 0 && !loading && (
          <div className="text-center py-12">
            <p className="text-muted-foreground mb-4">لا يوجد فئات</p>
            <Button onClick={() => setIsAddOpen(true)}>إضافة فئة جديدة</Button>
          </div>
        )}
      </div>
    </div>
  );
}
