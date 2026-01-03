'use client';

import { useState, useEffect } from 'react';
import { useRouter } from 'next/navigation';
import Link from 'next/link';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
} from '@/components/ui/dialog';
import { useAuth } from '@/contexts/auth-context';

interface PendingCraftsman {
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
  status: 'pending';
  nationalIdImage?: string;
  craftLicenseImage?: string;
  serviceAreas?: Array<{
    governorate: string;
    city: string;
    districts: string[];
  }>;
  createdAt: string;
}

export default function PendingCraftsmenPage() {
  const { isAuthenticated, isLoading, token } = useAuth();
  const router = useRouter();
  const [craftsmen, setCraftsmen] = useState<PendingCraftsman[]>([]);
  const [loading, setLoading] = useState(true);
  const [selectedCraftsman, setSelectedCraftsman] = useState<PendingCraftsman | null>(null);
  const [isDetailOpen, setIsDetailOpen] = useState(false);
  const [actionLoading, setActionLoading] = useState(false);

  useEffect(() => {
    if (!isLoading && !isAuthenticated) {
      router.push('/login');
    }
  }, [isAuthenticated, isLoading, router]);

  useEffect(() => {
    if (token) {
      fetchPendingCraftsmen();
    }
  }, [token]);

  const fetchPendingCraftsmen = async () => {
    try {
      const response = await fetch(
        `${process.env.NEXT_PUBLIC_API_URL || 'http://localhost:5000'}/api/v1/craftsmen?status=pending`,
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
      console.error('Failed to fetch pending craftsmen:', error);
    } finally {
      setLoading(false);
    }
  };

  const handleApprove = async (id: string) => {
    setActionLoading(true);
    try {
      const response = await fetch(
        `${process.env.NEXT_PUBLIC_API_URL || 'http://localhost:5000'}/api/v1/craftsmen/${id}/status`,
        {
          method: 'PUT',
          headers: {
            'Content-Type': 'application/json',
            Authorization: `Bearer ${token}`,
          },
          body: JSON.stringify({ status: 'approved' }),
        }
      );

      if (response.ok) {
        fetchPendingCraftsmen();
        setIsDetailOpen(false);
        setSelectedCraftsman(null);
      }
    } catch (error) {
      console.error('Failed to approve:', error);
    } finally {
      setActionLoading(false);
    }
  };

  const handleReject = async (id: string) => {
    if (!confirm('هل أنت متأكد من رفض هذا الطلب؟')) return;

    setActionLoading(true);
    try {
      const response = await fetch(
        `${process.env.NEXT_PUBLIC_API_URL || 'http://localhost:5000'}/api/v1/craftsmen/${id}/status`,
        {
          method: 'PUT',
          headers: {
            'Content-Type': 'application/json',
            Authorization: `Bearer ${token}`,
          },
          body: JSON.stringify({ status: 'rejected' }),
        }
      );

      if (response.ok) {
        fetchPendingCraftsmen();
        setIsDetailOpen(false);
        setSelectedCraftsman(null);
      }
    } catch (error) {
      console.error('Failed to reject:', error);
    } finally {
      setActionLoading(false);
    }
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
      <div className="max-w-6xl mx-auto">
        {/* Header */}
        <div className="flex items-center justify-between mb-8">
          <div>
            <div className="flex items-center gap-2 mb-2">
              <Link href="/craftsmen" className="text-muted-foreground hover:text-primary">
                الصنايعية
              </Link>
              <span className="text-muted-foreground">/</span>
              <span>طلبات الانضمام</span>
            </div>
            <h1 className="text-2xl font-bold">طلبات الانضمام في الانتظار</h1>
            <p className="text-muted-foreground">
              {craftsmen.length} طلب في الانتظار
            </p>
          </div>
        </div>

        {craftsmen.length === 0 ? (
          <Card>
            <CardContent className="py-16">
              <div className="text-center">
                <div className="w-20 h-20 bg-green-100 rounded-full flex items-center justify-center mx-auto mb-4">
                  <span className="text-4xl">✅</span>
                </div>
                <h3 className="text-lg font-medium mb-2">لا توجد طلبات في الانتظار</h3>
                <p className="text-muted-foreground mb-4">
                  تم مراجعة جميع طلبات الانضمام
                </p>
                <Link href="/craftsmen">
                  <Button variant="outline">العودة للقائمة</Button>
                </Link>
              </div>
            </CardContent>
          </Card>
        ) : (
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            {craftsmen.map((craftsman) => (
              <Card key={craftsman._id} className="hover:shadow-lg transition-shadow">
                <CardHeader className="pb-3">
                  <div className="flex items-start gap-4">
                    <div className="w-14 h-14 bg-primary/10 rounded-full flex items-center justify-center flex-shrink-0">
                      {craftsman.user?.avatar ? (
                        <img
                          src={craftsman.user.avatar}
                          alt={craftsman.displayName}
                          className="w-14 h-14 rounded-full object-cover"
                        />
                      ) : (
                        <span className="text-2xl">👷</span>
                      )}
                    </div>
                    <div className="flex-1 min-w-0">
                      <CardTitle className="text-lg truncate">
                        {craftsman.displayName}
                      </CardTitle>
                      <p className="text-sm text-muted-foreground font-mono">
                        {craftsman.user?.phone}
                      </p>
                      <p className="text-xs text-muted-foreground mt-1">
                        تقدم منذ {getTimeAgo(craftsman.createdAt)}
                      </p>
                    </div>
                  </div>
                </CardHeader>
                <CardContent>
                  {/* Categories */}
                  <div className="mb-4">
                    <p className="text-xs text-muted-foreground mb-2">التخصصات:</p>
                    <div className="flex flex-wrap gap-1">
                      {craftsman.categories?.slice(0, 3).map((cat) => (
                        <span
                          key={cat._id}
                          className="text-xs bg-primary/10 text-primary px-2 py-1 rounded"
                        >
                          {cat.nameAr}
                        </span>
                      ))}
                      {craftsman.categories?.length > 3 && (
                        <span className="text-xs text-muted-foreground">
                          +{craftsman.categories.length - 3}
                        </span>
                      )}
                    </div>
                  </div>

                  {/* Documents Status */}
                  <div className="mb-4 p-3 bg-gray-50 rounded-lg">
                    <p className="text-xs text-muted-foreground mb-2">المستندات:</p>
                    <div className="flex gap-4">
                      <div className="flex items-center gap-1">
                        {craftsman.nationalIdImage ? (
                          <span className="text-green-500">✓</span>
                        ) : (
                          <span className="text-red-500">✗</span>
                        )}
                        <span className="text-xs">البطاقة</span>
                      </div>
                      <div className="flex items-center gap-1">
                        {craftsman.craftLicenseImage ? (
                          <span className="text-green-500">✓</span>
                        ) : (
                          <span className="text-red-500">✗</span>
                        )}
                        <span className="text-xs">الرخصة</span>
                      </div>
                    </div>
                  </div>

                  {/* Actions */}
                  <div className="flex gap-2">
                    <Button
                      className="flex-1"
                      size="sm"
                      onClick={() => {
                        setSelectedCraftsman(craftsman);
                        setIsDetailOpen(true);
                      }}
                    >
                      مراجعة
                    </Button>
                    <Button
                      variant="outline"
                      size="sm"
                      onClick={() => handleApprove(craftsman._id)}
                      disabled={actionLoading}
                    >
                      قبول سريع
                    </Button>
                  </div>
                </CardContent>
              </Card>
            ))}
          </div>
        )}

        {/* Review Dialog */}
        <Dialog open={isDetailOpen} onOpenChange={setIsDetailOpen}>
          <DialogContent className="max-w-3xl max-h-[90vh] overflow-y-auto">
            <DialogHeader>
              <DialogTitle>مراجعة طلب الانضمام</DialogTitle>
            </DialogHeader>
            {selectedCraftsman && (
              <div className="space-y-6">
                {/* Profile Info */}
                <div className="flex items-center gap-4 p-4 bg-gray-50 rounded-lg">
                  <div className="w-20 h-20 bg-white rounded-full flex items-center justify-center shadow">
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
                    <p className="text-muted-foreground font-mono">
                      {selectedCraftsman.user?.phone}
                    </p>
                    <p className="text-sm text-muted-foreground">
                      تقدم بتاريخ {new Date(selectedCraftsman.createdAt).toLocaleDateString('ar-EG', {
                        year: 'numeric',
                        month: 'long',
                        day: 'numeric',
                      })}
                    </p>
                  </div>
                </div>

                {/* Bio */}
                {selectedCraftsman.bio && (
                  <div>
                    <h4 className="font-medium mb-2">النبذة الشخصية</h4>
                    <p className="text-muted-foreground bg-gray-50 p-3 rounded-lg">
                      {selectedCraftsman.bio}
                    </p>
                  </div>
                )}

                {/* Categories */}
                <div>
                  <h4 className="font-medium mb-2">التخصصات المختارة</h4>
                  <div className="flex flex-wrap gap-2">
                    {selectedCraftsman.categories?.map((cat) => (
                      <span
                        key={cat._id}
                        className="bg-primary/10 text-primary px-4 py-2 rounded-full"
                      >
                        {cat.nameAr}
                      </span>
                    ))}
                    {(!selectedCraftsman.categories || selectedCraftsman.categories.length === 0) && (
                      <span className="text-muted-foreground">لم يتم اختيار تخصصات</span>
                    )}
                  </div>
                </div>

                {/* Service Areas */}
                {selectedCraftsman.serviceAreas && selectedCraftsman.serviceAreas.length > 0 && (
                  <div>
                    <h4 className="font-medium mb-2">مناطق الخدمة</h4>
                    <div className="space-y-2">
                      {selectedCraftsman.serviceAreas.map((area, index) => (
                        <div key={index} className="bg-gray-50 p-3 rounded-lg">
                          <p className="font-medium">{area.governorate} - {area.city}</p>
                          {area.districts.length > 0 && (
                            <p className="text-sm text-muted-foreground">
                              المناطق: {area.districts.join(', ')}
                            </p>
                          )}
                        </div>
                      ))}
                    </div>
                  </div>
                )}

                {/* Documents */}
                <div>
                  <h4 className="font-medium mb-3">المستندات المرفقة</h4>
                  <div className="grid grid-cols-2 gap-4">
                    <div className="border rounded-lg overflow-hidden">
                      <div className="bg-gray-50 px-3 py-2 border-b">
                        <p className="text-sm font-medium">البطاقة الشخصية</p>
                      </div>
                      <div className="p-3">
                        {selectedCraftsman.nationalIdImage ? (
                          <a
                            href={selectedCraftsman.nationalIdImage}
                            target="_blank"
                            rel="noopener noreferrer"
                          >
                            <img
                              src={selectedCraftsman.nationalIdImage}
                              alt="National ID"
                              className="w-full h-48 object-cover rounded cursor-pointer hover:opacity-90"
                            />
                          </a>
                        ) : (
                          <div className="w-full h-48 bg-red-50 rounded flex flex-col items-center justify-center">
                            <span className="text-3xl mb-2">❌</span>
                            <span className="text-red-600 text-sm">لم يتم الرفع</span>
                          </div>
                        )}
                      </div>
                    </div>
                    <div className="border rounded-lg overflow-hidden">
                      <div className="bg-gray-50 px-3 py-2 border-b">
                        <p className="text-sm font-medium">رخصة الحرفة</p>
                      </div>
                      <div className="p-3">
                        {selectedCraftsman.craftLicenseImage ? (
                          <a
                            href={selectedCraftsman.craftLicenseImage}
                            target="_blank"
                            rel="noopener noreferrer"
                          >
                            <img
                              src={selectedCraftsman.craftLicenseImage}
                              alt="Craft License"
                              className="w-full h-48 object-cover rounded cursor-pointer hover:opacity-90"
                            />
                          </a>
                        ) : (
                          <div className="w-full h-48 bg-yellow-50 rounded flex flex-col items-center justify-center">
                            <span className="text-3xl mb-2">⚠️</span>
                            <span className="text-yellow-600 text-sm">لم يتم الرفع (اختياري)</span>
                          </div>
                        )}
                      </div>
                    </div>
                  </div>
                </div>

                {/* Action Buttons */}
                <div className="flex gap-3 pt-4 border-t sticky bottom-0 bg-white pb-2">
                  <Button
                    className="flex-1"
                    size="lg"
                    onClick={() => handleApprove(selectedCraftsman._id)}
                    disabled={actionLoading}
                  >
                    {actionLoading ? (
                      <span className="animate-spin mr-2">⏳</span>
                    ) : (
                      <span className="mr-2">✓</span>
                    )}
                    قبول الطلب
                  </Button>
                  <Button
                    variant="destructive"
                    className="flex-1"
                    size="lg"
                    onClick={() => handleReject(selectedCraftsman._id)}
                    disabled={actionLoading}
                  >
                    <span className="mr-2">✗</span>
                    رفض الطلب
                  </Button>
                </div>
              </div>
            )}
          </DialogContent>
        </Dialog>
      </div>
    </div>
  );
}

function getTimeAgo(dateString: string): string {
  const date = new Date(dateString);
  const now = new Date();
  const diffInMs = now.getTime() - date.getTime();
  const diffInHours = Math.floor(diffInMs / (1000 * 60 * 60));
  const diffInDays = Math.floor(diffInHours / 24);

  if (diffInHours < 1) {
    return 'أقل من ساعة';
  } else if (diffInHours < 24) {
    return `${diffInHours} ساعة`;
  } else if (diffInDays === 1) {
    return 'يوم واحد';
  } else if (diffInDays < 7) {
    return `${diffInDays} أيام`;
  } else {
    return date.toLocaleDateString('ar-EG');
  }
}
