'use client';

import { useEffect, useState } from 'react';
import Link from 'next/link';
import {
  ClipboardList,
  Hammer,
  Users,
  DollarSign,
  TrendingUp,
  Clock,
  CheckCircle,
  AlertCircle,
} from 'lucide-react';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Badge } from '@/components/ui/badge';
import { Button } from '@/components/ui/button';
import { Skeleton } from '@/components/ui/skeleton';
import { useAuth } from '@/contexts/auth-context';
import { getDashboardStats, DashboardStats } from '@/services/admin.service';

const statusColors: Record<string, string> = {
  pending: 'bg-yellow-100 text-yellow-800',
  quoted: 'bg-blue-100 text-blue-800',
  accepted: 'bg-purple-100 text-purple-800',
  in_progress: 'bg-teal-100 text-teal-800',
  completed: 'bg-green-100 text-green-800',
  cancelled: 'bg-red-100 text-red-800',
};

const statusLabels: Record<string, string> = {
  pending: 'في الانتظار',
  quoted: 'تم التسعير',
  accepted: 'مقبول',
  in_progress: 'جاري العمل',
  completed: 'مكتمل',
  cancelled: 'ملغي',
};

const craftsmanStatusColors: Record<string, string> = {
  pending: 'bg-yellow-100 text-yellow-800',
  approved: 'bg-green-100 text-green-800',
  rejected: 'bg-red-100 text-red-800',
  suspended: 'bg-gray-100 text-gray-800',
};

const craftsmanStatusLabels: Record<string, string> = {
  pending: 'قيد المراجعة',
  approved: 'موافق عليه',
  rejected: 'مرفوض',
  suspended: 'موقوف',
};

export default function DashboardPage() {
  const { user } = useAuth();
  const [stats, setStats] = useState<DashboardStats | null>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchStats = async () => {
      const data = await getDashboardStats();
      setStats(data);
      setLoading(false);
    };
    fetchStats();
  }, []);

  const formatCurrency = (amount: number) => {
    return new Intl.NumberFormat('ar-EG', {
      style: 'currency',
      currency: 'EGP',
      maximumFractionDigits: 0,
    }).format(amount);
  };

  const formatDate = (dateString: string) => {
    return new Date(dateString).toLocaleDateString('ar-EG', {
      day: 'numeric',
      month: 'short',
    });
  };

  if (loading) {
    return (
      <div className="space-y-6">
        <Skeleton className="h-8 w-48" />
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
          {[...Array(4)].map((_, i) => (
            <Skeleton key={i} className="h-32" />
          ))}
        </div>
        <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
          <Skeleton className="h-80" />
          <Skeleton className="h-80" />
        </div>
      </div>
    );
  }

  return (
    <div className="space-y-6">
      {/* Welcome Header */}
      <div>
        <h1 className="text-2xl font-bold">مرحباً، {user?.name}!</h1>
        <p className="text-muted-foreground">نظرة عامة على أداء المنصة</p>
      </div>

      {/* Stats Grid */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
        <Card>
          <CardHeader className="flex flex-row items-center justify-between pb-2">
            <CardTitle className="text-sm font-medium text-muted-foreground">
              إجمالي الطلبات
            </CardTitle>
            <ClipboardList className="h-5 w-5 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-3xl font-bold">{stats?.totalRequests || 0}</div>
            <div className="flex items-center gap-2 mt-1 text-sm">
              <span className="text-green-600">{stats?.activeRequests || 0} نشط</span>
              <span className="text-muted-foreground">•</span>
              <span className="text-muted-foreground">{stats?.completedRequests || 0} مكتمل</span>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="flex flex-row items-center justify-between pb-2">
            <CardTitle className="text-sm font-medium text-muted-foreground">
              الصنايعية
            </CardTitle>
            <Hammer className="h-5 w-5 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-3xl font-bold">{stats?.totalCraftsmen || 0}</div>
            <div className="flex items-center gap-2 mt-1 text-sm">
              <span className="text-green-600">{stats?.activeCraftsmen || 0} نشط</span>
              {(stats?.pendingCraftsmen || 0) > 0 && (
                <>
                  <span className="text-muted-foreground">•</span>
                  <span className="text-yellow-600">{stats?.pendingCraftsmen} قيد المراجعة</span>
                </>
              )}
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="flex flex-row items-center justify-between pb-2">
            <CardTitle className="text-sm font-medium text-muted-foreground">
              العملاء
            </CardTitle>
            <Users className="h-5 w-5 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-3xl font-bold">{stats?.totalCustomers || 0}</div>
            <div className="flex items-center gap-2 mt-1 text-sm">
              <span className="text-green-600">{stats?.activeCustomers || 0} نشط</span>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="flex flex-row items-center justify-between pb-2">
            <CardTitle className="text-sm font-medium text-muted-foreground">
              الإيرادات
            </CardTitle>
            <DollarSign className="h-5 w-5 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-3xl font-bold">{formatCurrency(stats?.totalRevenue || 0)}</div>
            <div className="flex items-center gap-2 mt-1 text-sm">
              <TrendingUp className="h-4 w-4 text-green-600" />
              <span className="text-green-600">{formatCurrency(stats?.monthlyRevenue || 0)} هذا الشهر</span>
            </div>
          </CardContent>
        </Card>
      </div>

      {/* Quick Actions */}
      {(stats?.pendingCraftsmen || 0) > 0 && (
        <Card className="border-yellow-200 bg-yellow-50">
          <CardContent className="flex items-center justify-between py-4">
            <div className="flex items-center gap-3">
              <AlertCircle className="h-5 w-5 text-yellow-600" />
              <div>
                <p className="font-medium">طلبات صنايعية قيد المراجعة</p>
                <p className="text-sm text-muted-foreground">
                  يوجد {stats?.pendingCraftsmen} طلب انضمام بحاجة للمراجعة
                </p>
              </div>
            </div>
            <Button asChild>
              <Link href="/craftsmen/pending">مراجعة الطلبات</Link>
            </Button>
          </CardContent>
        </Card>
      )}

      {/* Recent Activity */}
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        {/* Recent Requests */}
        <Card>
          <CardHeader className="flex flex-row items-center justify-between">
            <CardTitle>آخر الطلبات</CardTitle>
            <Button variant="ghost" size="sm" asChild>
              <Link href="/requests">عرض الكل</Link>
            </Button>
          </CardHeader>
          <CardContent>
            {stats?.recentRequests && stats.recentRequests.length > 0 ? (
              <div className="space-y-4">
                {stats.recentRequests.map((request) => (
                  <div
                    key={request._id}
                    className="flex items-center justify-between p-3 bg-muted/50 rounded-lg"
                  >
                    <div className="flex-1 min-w-0">
                      <p className="font-medium truncate">{request.title}</p>
                      <p className="text-sm text-muted-foreground">
                        {request.customerName} • {formatDate(request.createdAt)}
                      </p>
                    </div>
                    <Badge className={statusColors[request.status] || 'bg-gray-100'}>
                      {statusLabels[request.status] || request.status}
                    </Badge>
                  </div>
                ))}
              </div>
            ) : (
              <div className="flex flex-col items-center justify-center py-8 text-center">
                <Clock className="h-12 w-12 text-muted-foreground mb-2" />
                <p className="text-muted-foreground">لا يوجد طلبات حديثة</p>
              </div>
            )}
          </CardContent>
        </Card>

        {/* Recent Craftsmen */}
        <Card>
          <CardHeader className="flex flex-row items-center justify-between">
            <CardTitle>آخر الصنايعية</CardTitle>
            <Button variant="ghost" size="sm" asChild>
              <Link href="/craftsmen">عرض الكل</Link>
            </Button>
          </CardHeader>
          <CardContent>
            {stats?.recentCraftsmen && stats.recentCraftsmen.length > 0 ? (
              <div className="space-y-4">
                {stats.recentCraftsmen.map((craftsman) => (
                  <div
                    key={craftsman._id}
                    className="flex items-center justify-between p-3 bg-muted/50 rounded-lg"
                  >
                    <div className="flex-1 min-w-0">
                      <p className="font-medium truncate">{craftsman.name}</p>
                      <p className="text-sm text-muted-foreground">
                        {craftsman.category} • {formatDate(craftsman.createdAt)}
                      </p>
                    </div>
                    <Badge className={craftsmanStatusColors[craftsman.status] || 'bg-gray-100'}>
                      {craftsmanStatusLabels[craftsman.status] || craftsman.status}
                    </Badge>
                  </div>
                ))}
              </div>
            ) : (
              <div className="flex flex-col items-center justify-center py-8 text-center">
                <Hammer className="h-12 w-12 text-muted-foreground mb-2" />
                <p className="text-muted-foreground">لا يوجد صنايعية جدد</p>
              </div>
            )}
          </CardContent>
        </Card>
      </div>

      {/* Quick Stats */}
      <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
        <Card>
          <CardContent className="pt-6">
            <div className="flex items-center gap-3">
              <div className="p-2 bg-green-100 rounded-lg">
                <CheckCircle className="h-5 w-5 text-green-600" />
              </div>
              <div>
                <p className="text-2xl font-bold">{stats?.completedRequests || 0}</p>
                <p className="text-sm text-muted-foreground">طلبات مكتملة</p>
              </div>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardContent className="pt-6">
            <div className="flex items-center gap-3">
              <div className="p-2 bg-blue-100 rounded-lg">
                <Clock className="h-5 w-5 text-blue-600" />
              </div>
              <div>
                <p className="text-2xl font-bold">{stats?.activeRequests || 0}</p>
                <p className="text-sm text-muted-foreground">طلبات جارية</p>
              </div>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardContent className="pt-6">
            <div className="flex items-center gap-3">
              <div className="p-2 bg-purple-100 rounded-lg">
                <Hammer className="h-5 w-5 text-purple-600" />
              </div>
              <div>
                <p className="text-2xl font-bold">{stats?.activeCraftsmen || 0}</p>
                <p className="text-sm text-muted-foreground">صنايعي نشط</p>
              </div>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardContent className="pt-6">
            <div className="flex items-center gap-3">
              <div className="p-2 bg-yellow-100 rounded-lg">
                <DollarSign className="h-5 w-5 text-yellow-600" />
              </div>
              <div>
                <p className="text-2xl font-bold">{formatCurrency(stats?.pendingPayouts || 0)}</p>
                <p className="text-sm text-muted-foreground">مستحقات معلقة</p>
              </div>
            </div>
          </CardContent>
        </Card>
      </div>
    </div>
  );
}
