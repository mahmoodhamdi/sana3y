'use client';

import { useState, useEffect } from 'react';
import {
  Search,
  Filter,
  ClipboardList,
  Clock,
  CheckCircle,
  XCircle,
  Eye,
  MapPin,
  Calendar,
} from 'lucide-react';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Badge } from '@/components/ui/badge';
import { Skeleton } from '@/components/ui/skeleton';
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from '@/components/ui/table';
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
import { getRequests, getRequestById, ServiceRequest } from '@/services/admin.service';

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

const urgencyLabels: Record<string, string> = {
  normal: 'عادي',
  urgent: 'عاجل',
  emergency: 'طوارئ',
};

const urgencyColors: Record<string, string> = {
  normal: 'bg-gray-100 text-gray-800',
  urgent: 'bg-orange-100 text-orange-800',
  emergency: 'bg-red-100 text-red-800',
};

export default function RequestsPage() {
  const [requests, setRequests] = useState<ServiceRequest[]>([]);
  const [loading, setLoading] = useState(true);
  const [search, setSearch] = useState('');
  const [statusFilter, setStatusFilter] = useState<string>('all');
  const [page, setPage] = useState(1);
  const [totalPages, setTotalPages] = useState(1);
  const [total, setTotal] = useState(0);
  const [selectedRequest, setSelectedRequest] = useState<ServiceRequest | null>(null);
  const [detailsOpen, setDetailsOpen] = useState(false);

  useEffect(() => {
    fetchRequests();
  }, [page, search, statusFilter]);

  const fetchRequests = async () => {
    setLoading(true);
    const result = await getRequests(page, 20, {
      search: search || undefined,
      status: statusFilter !== 'all' ? statusFilter : undefined,
    });
    setRequests(result.requests);
    setTotalPages(result.totalPages);
    setTotal(result.total);
    setLoading(false);
  };

  const handleViewDetails = async (id: string) => {
    const request = await getRequestById(id);
    if (request) {
      setSelectedRequest(request);
      setDetailsOpen(true);
    }
  };

  const formatCurrency = (amount: number) => {
    return new Intl.NumberFormat('ar-EG', {
      style: 'currency',
      currency: 'EGP',
      maximumFractionDigits: 0,
    }).format(amount);
  };

  const formatDate = (dateString: string) => {
    return new Date(dateString).toLocaleDateString('ar-EG', {
      year: 'numeric',
      month: 'short',
      day: 'numeric',
    });
  };

  const formatDateTime = (dateString: string) => {
    return new Date(dateString).toLocaleDateString('ar-EG', {
      year: 'numeric',
      month: 'short',
      day: 'numeric',
      hour: '2-digit',
      minute: '2-digit',
    });
  };

  // Count stats
  const statsCounts = {
    total: total,
    pending: requests.filter((r) => r.status === 'pending').length,
    active: requests.filter((r) => ['quoted', 'accepted', 'in_progress'].includes(r.status)).length,
    completed: requests.filter((r) => r.status === 'completed').length,
  };

  if (loading && requests.length === 0) {
    return (
      <div className="space-y-6">
        <Skeleton className="h-8 w-48" />
        <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
          {[...Array(4)].map((_, i) => (
            <Skeleton key={i} className="h-24" />
          ))}
        </div>
        <Skeleton className="h-96" />
      </div>
    );
  }

  return (
    <div className="space-y-6">
      {/* Header */}
      <div>
        <h1 className="text-2xl font-bold">الطلبات</h1>
        <p className="text-muted-foreground">متابعة وإدارة طلبات الخدمات</p>
      </div>

      {/* Stats */}
      <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
        <Card>
          <CardContent className="pt-6">
            <div className="flex items-center gap-3">
              <div className="p-2 bg-blue-100 rounded-lg">
                <ClipboardList className="h-5 w-5 text-blue-600" />
              </div>
              <div>
                <p className="text-2xl font-bold">{statsCounts.total}</p>
                <p className="text-sm text-muted-foreground">إجمالي الطلبات</p>
              </div>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardContent className="pt-6">
            <div className="flex items-center gap-3">
              <div className="p-2 bg-yellow-100 rounded-lg">
                <Clock className="h-5 w-5 text-yellow-600" />
              </div>
              <div>
                <p className="text-2xl font-bold">{statsCounts.pending}</p>
                <p className="text-sm text-muted-foreground">في الانتظار</p>
              </div>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardContent className="pt-6">
            <div className="flex items-center gap-3">
              <div className="p-2 bg-teal-100 rounded-lg">
                <Filter className="h-5 w-5 text-teal-600" />
              </div>
              <div>
                <p className="text-2xl font-bold">{statsCounts.active}</p>
                <p className="text-sm text-muted-foreground">جارية</p>
              </div>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardContent className="pt-6">
            <div className="flex items-center gap-3">
              <div className="p-2 bg-green-100 rounded-lg">
                <CheckCircle className="h-5 w-5 text-green-600" />
              </div>
              <div>
                <p className="text-2xl font-bold">{statsCounts.completed}</p>
                <p className="text-sm text-muted-foreground">مكتملة</p>
              </div>
            </div>
          </CardContent>
        </Card>
      </div>

      {/* Filters */}
      <Card>
        <CardContent className="pt-6">
          <div className="flex flex-col md:flex-row gap-4">
            <div className="relative flex-1">
              <Search className="absolute right-3 top-1/2 -translate-y-1/2 h-4 w-4 text-muted-foreground" />
              <Input
                placeholder="بحث بالعنوان أو اسم العميل..."
                value={search}
                onChange={(e) => {
                  setSearch(e.target.value);
                  setPage(1);
                }}
                className="pr-10"
              />
            </div>
            <Select
              value={statusFilter}
              onValueChange={(value) => {
                setStatusFilter(value);
                setPage(1);
              }}
            >
              <SelectTrigger className="w-full md:w-48">
                <SelectValue placeholder="الحالة" />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="all">جميع الحالات</SelectItem>
                <SelectItem value="pending">في الانتظار</SelectItem>
                <SelectItem value="quoted">تم التسعير</SelectItem>
                <SelectItem value="accepted">مقبول</SelectItem>
                <SelectItem value="in_progress">جاري العمل</SelectItem>
                <SelectItem value="completed">مكتمل</SelectItem>
                <SelectItem value="cancelled">ملغي</SelectItem>
              </SelectContent>
            </Select>
          </div>
        </CardContent>
      </Card>

      {/* Requests Table */}
      <Card>
        <CardHeader>
          <CardTitle>قائمة الطلبات ({total})</CardTitle>
        </CardHeader>
        <CardContent>
          <Table>
            <TableHeader>
              <TableRow>
                <TableHead>الطلب</TableHead>
                <TableHead>العميل</TableHead>
                <TableHead>الفئة</TableHead>
                <TableHead>الموقع</TableHead>
                <TableHead>الحالة</TableHead>
                <TableHead>الأولوية</TableHead>
                <TableHead>السعر</TableHead>
                <TableHead>التاريخ</TableHead>
                <TableHead></TableHead>
              </TableRow>
            </TableHeader>
            <TableBody>
              {requests.length > 0 ? (
                requests.map((request) => (
                  <TableRow key={request._id}>
                    <TableCell>
                      <p className="font-medium truncate max-w-[200px]">{request.title}</p>
                    </TableCell>
                    <TableCell>
                      <p className="text-sm">{request.customerId?.userId?.name || '-'}</p>
                    </TableCell>
                    <TableCell>
                      <span className="text-sm">{request.categoryId?.nameAr || '-'}</span>
                    </TableCell>
                    <TableCell>
                      <div className="flex items-center gap-1 text-sm">
                        <MapPin className="h-3 w-3" />
                        {request.location?.city || '-'}
                      </div>
                    </TableCell>
                    <TableCell>
                      <Badge className={statusColors[request.status] || 'bg-gray-100'}>
                        {statusLabels[request.status] || request.status}
                      </Badge>
                    </TableCell>
                    <TableCell>
                      <Badge className={urgencyColors[request.urgency] || 'bg-gray-100'}>
                        {urgencyLabels[request.urgency] || request.urgency}
                      </Badge>
                    </TableCell>
                    <TableCell>
                      {request.finalPrice ? (
                        <span className="font-medium">{formatCurrency(request.finalPrice)}</span>
                      ) : request.quotedPrice ? (
                        <span className="text-muted-foreground">{formatCurrency(request.quotedPrice)}</span>
                      ) : (
                        <span className="text-muted-foreground">-</span>
                      )}
                    </TableCell>
                    <TableCell>
                      <span className="text-sm">{formatDate(request.createdAt)}</span>
                    </TableCell>
                    <TableCell>
                      <Button
                        variant="ghost"
                        size="icon"
                        onClick={() => handleViewDetails(request._id)}
                      >
                        <Eye className="h-4 w-4" />
                      </Button>
                    </TableCell>
                  </TableRow>
                ))
              ) : (
                <TableRow>
                  <TableCell colSpan={9} className="text-center py-8">
                    <ClipboardList className="h-12 w-12 mx-auto text-muted-foreground mb-2" />
                    <p className="text-muted-foreground">لا يوجد طلبات</p>
                  </TableCell>
                </TableRow>
              )}
            </TableBody>
          </Table>

          {/* Pagination */}
          {totalPages > 1 && (
            <div className="flex items-center justify-between mt-4 pt-4 border-t">
              <p className="text-sm text-muted-foreground">
                صفحة {page} من {totalPages}
              </p>
              <div className="flex gap-2">
                <Button
                  variant="outline"
                  size="sm"
                  onClick={() => setPage(page - 1)}
                  disabled={page === 1}
                >
                  السابق
                </Button>
                <Button
                  variant="outline"
                  size="sm"
                  onClick={() => setPage(page + 1)}
                  disabled={page === totalPages}
                >
                  التالي
                </Button>
              </div>
            </div>
          )}
        </CardContent>
      </Card>

      {/* Request Details Dialog */}
      <Dialog open={detailsOpen} onOpenChange={setDetailsOpen}>
        <DialogContent className="max-w-2xl">
          <DialogHeader>
            <DialogTitle>تفاصيل الطلب</DialogTitle>
          </DialogHeader>
          {selectedRequest && (
            <div className="space-y-6">
              <div className="flex items-start justify-between">
                <div>
                  <h3 className="text-lg font-semibold">{selectedRequest.title}</h3>
                  <p className="text-muted-foreground">{selectedRequest.description}</p>
                </div>
                <div className="flex gap-2">
                  <Badge className={statusColors[selectedRequest.status]}>
                    {statusLabels[selectedRequest.status]}
                  </Badge>
                  <Badge className={urgencyColors[selectedRequest.urgency]}>
                    {urgencyLabels[selectedRequest.urgency]}
                  </Badge>
                </div>
              </div>

              <div className="grid grid-cols-2 gap-4">
                <Card>
                  <CardHeader className="pb-2">
                    <CardTitle className="text-sm">العميل</CardTitle>
                  </CardHeader>
                  <CardContent>
                    <p className="font-medium">{selectedRequest.customerId?.userId?.name}</p>
                    <p className="text-sm text-muted-foreground">
                      {selectedRequest.customerId?.userId?.phone}
                    </p>
                  </CardContent>
                </Card>

                {selectedRequest.craftsmanId && (
                  <Card>
                    <CardHeader className="pb-2">
                      <CardTitle className="text-sm">الصنايعي</CardTitle>
                    </CardHeader>
                    <CardContent>
                      <p className="font-medium">{selectedRequest.craftsmanId?.userId?.name}</p>
                      <p className="text-sm text-muted-foreground">
                        {selectedRequest.craftsmanId?.userId?.phone}
                      </p>
                    </CardContent>
                  </Card>
                )}
              </div>

              <div className="grid grid-cols-2 gap-4">
                <div>
                  <p className="text-sm text-muted-foreground">الفئة</p>
                  <p className="font-medium">{selectedRequest.categoryId?.nameAr}</p>
                </div>
                <div>
                  <p className="text-sm text-muted-foreground">الموقع</p>
                  <p className="font-medium flex items-center gap-1">
                    <MapPin className="h-4 w-4" />
                    {selectedRequest.location?.city}، {selectedRequest.location?.governorate}
                  </p>
                </div>
                <div>
                  <p className="text-sm text-muted-foreground">تاريخ الإنشاء</p>
                  <p className="font-medium flex items-center gap-1">
                    <Calendar className="h-4 w-4" />
                    {formatDateTime(selectedRequest.createdAt)}
                  </p>
                </div>
                {selectedRequest.completedAt && (
                  <div>
                    <p className="text-sm text-muted-foreground">تاريخ الإكمال</p>
                    <p className="font-medium flex items-center gap-1">
                      <CheckCircle className="h-4 w-4 text-green-600" />
                      {formatDateTime(selectedRequest.completedAt)}
                    </p>
                  </div>
                )}
              </div>

              {(selectedRequest.quotedPrice || selectedRequest.finalPrice) && (
                <div className="flex gap-4 p-4 bg-muted rounded-lg">
                  {selectedRequest.quotedPrice && (
                    <div>
                      <p className="text-sm text-muted-foreground">السعر المعروض</p>
                      <p className="text-xl font-bold">{formatCurrency(selectedRequest.quotedPrice)}</p>
                    </div>
                  )}
                  {selectedRequest.finalPrice && (
                    <div>
                      <p className="text-sm text-muted-foreground">السعر النهائي</p>
                      <p className="text-xl font-bold text-green-600">
                        {formatCurrency(selectedRequest.finalPrice)}
                      </p>
                    </div>
                  )}
                </div>
              )}
            </div>
          )}
        </DialogContent>
      </Dialog>
    </div>
  );
}
