'use client';

import { useState, useEffect } from 'react';
import { useRouter } from 'next/navigation';
import Link from 'next/link';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from '@/components/ui/select';
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
} from '@/components/ui/dialog';
import { useAuth } from '@/contexts/auth-context';

interface Craftsman {
  _id: string;
  user: {
    _id: string;
    name: string;
    phone: string;
    avatar?: string;
  };
  displayName: string;
  bio?: string;
  categories: Array<{
    _id: string;
    name: string;
    nameAr: string;
  }>;
  status: 'pending' | 'approved' | 'suspended' | 'rejected';
  verificationStatus: 'pending' | 'verified' | 'rejected';
  rating: number;
  totalRatings: number;
  completedJobs: number;
  isOnline: boolean;
  createdAt: string;
  nationalIdImage?: string;
  craftLicenseImage?: string;
}

export default function CraftsmenPage() {
  const { isAuthenticated, isLoading, token } = useAuth();
  const router = useRouter();
  const [craftsmen, setCraftsmen] = useState<Craftsman[]>([]);
  const [loading, setLoading] = useState(true);
  const [searchQuery, setSearchQuery] = useState('');
  const [statusFilter, setStatusFilter] = useState<string>('all');
  const [selectedCraftsman, setSelectedCraftsman] = useState<Craftsman | null>(null);
  const [isDetailOpen, setIsDetailOpen] = useState(false);

  useEffect(() => {
    if (!isLoading && !isAuthenticated) {
      router.push('/login');
    }
  }, [isAuthenticated, isLoading, router]);

  useEffect(() => {
    if (token) {
      fetchCraftsmen();
    }
  }, [token, statusFilter]);

  const fetchCraftsmen = async () => {
    try {
      const params = new URLSearchParams();
      if (statusFilter && statusFilter !== 'all') {
        params.append('status', statusFilter);
      }

      const response = await fetch(
        `${process.env.NEXT_PUBLIC_API_URL || 'http://localhost:5000'}/api/v1/craftsmen?${params.toString()}`,
        {
          headers: {
            Authorization: `Bearer ${token}`,
          },
        }
      );
      const data = await response.json();
      if (data.success) {
        setCraftsmen(data.data || []);
      }
    } catch (error) {
      console.error('Failed to fetch craftsmen:', error);
    } finally {
      setLoading(false);
    }
  };

  const handleStatusChange = async (id: string, newStatus: string) => {
    try {
      const response = await fetch(
        `${process.env.NEXT_PUBLIC_API_URL || 'http://localhost:5000'}/api/v1/craftsmen/${id}/status`,
        {
          method: 'PUT',
          headers: {
            'Content-Type': 'application/json',
            Authorization: `Bearer ${token}`,
          },
          body: JSON.stringify({ status: newStatus }),
        }
      );

      if (response.ok) {
        fetchCraftsmen();
        setIsDetailOpen(false);
      }
    } catch (error) {
      console.error('Failed to update status:', error);
    }
  };

  const getStatusBadge = (status: string) => {
    const styles: Record<string, string> = {
      pending: 'bg-yellow-100 text-yellow-800',
      approved: 'bg-green-100 text-green-800',
      suspended: 'bg-red-100 text-red-800',
      rejected: 'bg-gray-100 text-gray-800',
    };
    const labels: Record<string, string> = {
      pending: 'في الانتظار',
      approved: 'معتمد',
      suspended: 'موقوف',
      rejected: 'مرفوض',
    };
    return (
      <span className={`inline-flex items-center px-2 py-1 rounded-full text-xs ${styles[status] || styles.pending}`}>
        {labels[status] || status}
      </span>
    );
  };

  const filteredCraftsmen = craftsmen.filter(c =>
    c.displayName.toLowerCase().includes(searchQuery.toLowerCase()) ||
    c.user?.phone?.includes(searchQuery)
  );

  const pendingCount = craftsmen.filter(c => c.status === 'pending').length;

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
            <h1 className="text-2xl font-bold">الصنايعية</h1>
            <p className="text-muted-foreground">إدارة حسابات الصنايعية</p>
          </div>
          {pendingCount > 0 && (
            <Link href="/craftsmen/pending">
              <Button variant="outline" className="gap-2">
                <span className="bg-yellow-500 text-white rounded-full w-6 h-6 flex items-center justify-center text-sm">
                  {pendingCount}
                </span>
                طلبات في الانتظار
              </Button>
            </Link>
          )}
        </div>

        {/* Filters */}
        <div className="flex gap-4 mb-6">
          <div className="flex-1">
            <Input
              placeholder="بحث بالاسم أو رقم الهاتف..."
              value={searchQuery}
              onChange={(e) => setSearchQuery(e.target.value)}
            />
          </div>
          <Select value={statusFilter} onValueChange={setStatusFilter}>
            <SelectTrigger className="w-48">
              <SelectValue placeholder="الحالة" />
            </SelectTrigger>
            <SelectContent>
              <SelectItem value="all">جميع الحالات</SelectItem>
              <SelectItem value="pending">في الانتظار</SelectItem>
              <SelectItem value="approved">معتمد</SelectItem>
              <SelectItem value="suspended">موقوف</SelectItem>
              <SelectItem value="rejected">مرفوض</SelectItem>
            </SelectContent>
          </Select>
        </div>

        {/* Stats Cards */}
        <div className="grid grid-cols-1 md:grid-cols-4 gap-4 mb-8">
          <Card>
            <CardContent className="pt-6">
              <div className="text-center">
                <p className="text-3xl font-bold text-primary">{craftsmen.length}</p>
                <p className="text-sm text-muted-foreground">إجمالي الصنايعية</p>
              </div>
            </CardContent>
          </Card>
          <Card>
            <CardContent className="pt-6">
              <div className="text-center">
                <p className="text-3xl font-bold text-green-600">
                  {craftsmen.filter(c => c.status === 'approved').length}
                </p>
                <p className="text-sm text-muted-foreground">معتمدين</p>
              </div>
            </CardContent>
          </Card>
          <Card>
            <CardContent className="pt-6">
              <div className="text-center">
                <p className="text-3xl font-bold text-yellow-600">{pendingCount}</p>
                <p className="text-sm text-muted-foreground">في الانتظار</p>
              </div>
            </CardContent>
          </Card>
          <Card>
            <CardContent className="pt-6">
              <div className="text-center">
                <p className="text-3xl font-bold text-blue-600">
                  {craftsmen.filter(c => c.isOnline).length}
                </p>
                <p className="text-sm text-muted-foreground">متصلين الآن</p>
              </div>
            </CardContent>
          </Card>
        </div>

        {/* Craftsmen Table */}
        <Card>
          <CardHeader>
            <CardTitle>قائمة الصنايعية</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="overflow-x-auto">
              <table className="w-full">
                <thead>
                  <tr className="border-b">
                    <th className="text-right py-3 px-4">الصنايعي</th>
                    <th className="text-right py-3 px-4">الهاتف</th>
                    <th className="text-right py-3 px-4">التخصصات</th>
                    <th className="text-right py-3 px-4">التقييم</th>
                    <th className="text-right py-3 px-4">الأعمال</th>
                    <th className="text-right py-3 px-4">الحالة</th>
                    <th className="text-right py-3 px-4">إجراءات</th>
                  </tr>
                </thead>
                <tbody>
                  {filteredCraftsmen.map((craftsman) => (
                    <tr key={craftsman._id} className="border-b hover:bg-gray-50">
                      <td className="py-3 px-4">
                        <div className="flex items-center gap-3">
                          <div className="w-10 h-10 bg-primary/10 rounded-full flex items-center justify-center">
                            {craftsman.user?.avatar ? (
                              <img
                                src={craftsman.user.avatar}
                                alt={craftsman.displayName}
                                className="w-10 h-10 rounded-full object-cover"
                              />
                            ) : (
                              <span className="text-lg">👷</span>
                            )}
                          </div>
                          <div>
                            <p className="font-medium">{craftsman.displayName}</p>
                            <p className="text-xs text-muted-foreground">
                              {new Date(craftsman.createdAt).toLocaleDateString('ar-EG')}
                            </p>
                          </div>
                        </div>
                      </td>
                      <td className="py-3 px-4 font-mono text-sm">
                        {craftsman.user?.phone}
                      </td>
                      <td className="py-3 px-4">
                        <div className="flex flex-wrap gap-1">
                          {craftsman.categories?.slice(0, 2).map((cat) => (
                            <span
                              key={cat._id}
                              className="text-xs bg-gray-100 px-2 py-1 rounded"
                            >
                              {cat.nameAr}
                            </span>
                          ))}
                          {craftsman.categories?.length > 2 && (
                            <span className="text-xs text-muted-foreground">
                              +{craftsman.categories.length - 2}
                            </span>
                          )}
                        </div>
                      </td>
                      <td className="py-3 px-4">
                        <div className="flex items-center gap-1">
                          <span className="text-yellow-500">★</span>
                          <span>{craftsman.rating?.toFixed(1) || '0.0'}</span>
                          <span className="text-xs text-muted-foreground">
                            ({craftsman.totalRatings || 0})
                          </span>
                        </div>
                      </td>
                      <td className="py-3 px-4">{craftsman.completedJobs || 0}</td>
                      <td className="py-3 px-4">
                        {getStatusBadge(craftsman.status)}
                      </td>
                      <td className="py-3 px-4">
                        <Button
                          variant="ghost"
                          size="sm"
                          onClick={() => {
                            setSelectedCraftsman(craftsman);
                            setIsDetailOpen(true);
                          }}
                        >
                          عرض
                        </Button>
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>

            {filteredCraftsmen.length === 0 && (
              <div className="text-center py-12">
                <p className="text-muted-foreground">لا يوجد صنايعية</p>
              </div>
            )}
          </CardContent>
        </Card>

        {/* Detail Dialog */}
        <Dialog open={isDetailOpen} onOpenChange={setIsDetailOpen}>
          <DialogContent className="max-w-2xl">
            <DialogHeader>
              <DialogTitle>تفاصيل الصنايعي</DialogTitle>
            </DialogHeader>
            {selectedCraftsman && (
              <div className="space-y-6">
                {/* Profile Header */}
                <div className="flex items-center gap-4">
                  <div className="w-20 h-20 bg-primary/10 rounded-full flex items-center justify-center">
                    {selectedCraftsman.user?.avatar ? (
                      <img
                        src={selectedCraftsman.user.avatar}
                        alt={selectedCraftsman.displayName}
                        className="w-20 h-20 rounded-full object-cover"
                      />
                    ) : (
                      <span className="text-4xl">👷</span>
                    )}
                  </div>
                  <div>
                    <h3 className="text-xl font-bold">{selectedCraftsman.displayName}</h3>
                    <p className="text-muted-foreground">{selectedCraftsman.user?.phone}</p>
                    <div className="flex items-center gap-2 mt-1">
                      {getStatusBadge(selectedCraftsman.status)}
                      {selectedCraftsman.isOnline && (
                        <span className="inline-flex items-center px-2 py-1 rounded-full text-xs bg-green-100 text-green-800">
                          متصل
                        </span>
                      )}
                    </div>
                  </div>
                </div>

                {/* Bio */}
                {selectedCraftsman.bio && (
                  <div>
                    <h4 className="font-medium mb-2">نبذة</h4>
                    <p className="text-muted-foreground">{selectedCraftsman.bio}</p>
                  </div>
                )}

                {/* Categories */}
                <div>
                  <h4 className="font-medium mb-2">التخصصات</h4>
                  <div className="flex flex-wrap gap-2">
                    {selectedCraftsman.categories?.map((cat) => (
                      <span
                        key={cat._id}
                        className="bg-primary/10 text-primary px-3 py-1 rounded-full text-sm"
                      >
                        {cat.nameAr}
                      </span>
                    ))}
                  </div>
                </div>

                {/* Stats */}
                <div className="grid grid-cols-3 gap-4">
                  <div className="bg-gray-50 p-4 rounded-lg text-center">
                    <p className="text-2xl font-bold">{selectedCraftsman.completedJobs || 0}</p>
                    <p className="text-sm text-muted-foreground">عمل مكتمل</p>
                  </div>
                  <div className="bg-gray-50 p-4 rounded-lg text-center">
                    <p className="text-2xl font-bold">{selectedCraftsman.rating?.toFixed(1) || '0.0'}</p>
                    <p className="text-sm text-muted-foreground">التقييم</p>
                  </div>
                  <div className="bg-gray-50 p-4 rounded-lg text-center">
                    <p className="text-2xl font-bold">{selectedCraftsman.totalRatings || 0}</p>
                    <p className="text-sm text-muted-foreground">تقييم</p>
                  </div>
                </div>

                {/* Documents */}
                <div>
                  <h4 className="font-medium mb-2">المستندات</h4>
                  <div className="grid grid-cols-2 gap-4">
                    <div className="border rounded-lg p-4">
                      <p className="text-sm text-muted-foreground mb-2">البطاقة الشخصية</p>
                      {selectedCraftsman.nationalIdImage ? (
                        <img
                          src={selectedCraftsman.nationalIdImage}
                          alt="National ID"
                          className="w-full h-32 object-cover rounded"
                        />
                      ) : (
                        <div className="w-full h-32 bg-gray-100 rounded flex items-center justify-center">
                          <span className="text-muted-foreground">لم يتم الرفع</span>
                        </div>
                      )}
                    </div>
                    <div className="border rounded-lg p-4">
                      <p className="text-sm text-muted-foreground mb-2">رخصة الحرفة</p>
                      {selectedCraftsman.craftLicenseImage ? (
                        <img
                          src={selectedCraftsman.craftLicenseImage}
                          alt="Craft License"
                          className="w-full h-32 object-cover rounded"
                        />
                      ) : (
                        <div className="w-full h-32 bg-gray-100 rounded flex items-center justify-center">
                          <span className="text-muted-foreground">لم يتم الرفع</span>
                        </div>
                      )}
                    </div>
                  </div>
                </div>

                {/* Actions */}
                <div className="flex gap-2 pt-4 border-t">
                  {selectedCraftsman.status === 'pending' && (
                    <>
                      <Button
                        className="flex-1"
                        onClick={() => handleStatusChange(selectedCraftsman._id, 'approved')}
                      >
                        قبول
                      </Button>
                      <Button
                        variant="destructive"
                        className="flex-1"
                        onClick={() => handleStatusChange(selectedCraftsman._id, 'rejected')}
                      >
                        رفض
                      </Button>
                    </>
                  )}
                  {selectedCraftsman.status === 'approved' && (
                    <Button
                      variant="destructive"
                      className="flex-1"
                      onClick={() => handleStatusChange(selectedCraftsman._id, 'suspended')}
                    >
                      إيقاف الحساب
                    </Button>
                  )}
                  {selectedCraftsman.status === 'suspended' && (
                    <Button
                      className="flex-1"
                      onClick={() => handleStatusChange(selectedCraftsman._id, 'approved')}
                    >
                      إعادة تفعيل
                    </Button>
                  )}
                  {selectedCraftsman.status === 'rejected' && (
                    <Button
                      className="flex-1"
                      onClick={() => handleStatusChange(selectedCraftsman._id, 'approved')}
                    >
                      قبول
                    </Button>
                  )}
                </div>
              </div>
            )}
          </DialogContent>
        </Dialog>
      </div>
    </div>
  );
}
