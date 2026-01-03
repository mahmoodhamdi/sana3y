'use client';

import { useState, useEffect } from 'react';
import { Bell, Send, Users, Hammer, Clock, CheckCircle, Plus } from 'lucide-react';
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
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
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
} from '@/components/ui/dialog';
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from '@/components/ui/select';
import { getNotifications, sendNotification, Notification } from '@/services/admin.service';

const typeLabels: Record<string, string> = {
  all: 'الجميع',
  customers: 'العملاء',
  craftsmen: 'الصنايعية',
};

const typeColors: Record<string, string> = {
  all: 'bg-blue-100 text-blue-800',
  customers: 'bg-green-100 text-green-800',
  craftsmen: 'bg-purple-100 text-purple-800',
};

const statusLabels: Record<string, string> = {
  draft: 'مسودة',
  sent: 'تم الإرسال',
  scheduled: 'مجدول',
};

const statusColors: Record<string, string> = {
  draft: 'bg-gray-100 text-gray-800',
  sent: 'bg-green-100 text-green-800',
  scheduled: 'bg-yellow-100 text-yellow-800',
};

export default function NotificationsPage() {
  const [notifications, setNotifications] = useState<Notification[]>([]);
  const [loading, setLoading] = useState(true);
  const [isAddOpen, setIsAddOpen] = useState(false);
  const [sending, setSending] = useState(false);
  const [page, setPage] = useState(1);
  const [totalPages, setTotalPages] = useState(1);
  const [formData, setFormData] = useState({
    title: '',
    titleAr: '',
    body: '',
    bodyAr: '',
    type: 'all' as 'all' | 'customers' | 'craftsmen',
  });

  useEffect(() => {
    fetchNotifications();
  }, [page]);

  const fetchNotifications = async () => {
    setLoading(true);
    const result = await getNotifications(page, 20);
    setNotifications(result.notifications);
    setTotalPages(result.totalPages);
    setLoading(false);
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setSending(true);
    const success = await sendNotification(formData);
    if (success) {
      fetchNotifications();
      setIsAddOpen(false);
      resetForm();
    }
    setSending(false);
  };

  const resetForm = () => {
    setFormData({
      title: '',
      titleAr: '',
      body: '',
      bodyAr: '',
      type: 'all',
    });
  };

  const formatDate = (dateString: string) => {
    return new Date(dateString).toLocaleDateString('ar-EG', {
      year: 'numeric',
      month: 'short',
      day: 'numeric',
      hour: '2-digit',
      minute: '2-digit',
    });
  };

  // Stats
  const stats = {
    total: notifications.length,
    sent: notifications.filter((n) => n.status === 'sent').length,
    scheduled: notifications.filter((n) => n.status === 'scheduled').length,
  };

  if (loading && notifications.length === 0) {
    return (
      <div className="space-y-6">
        <Skeleton className="h-8 w-48" />
        <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
          {[...Array(3)].map((_, i) => (
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
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-2xl font-bold">الإشعارات</h1>
          <p className="text-muted-foreground">إرسال إشعارات للمستخدمين</p>
        </div>
        <Dialog open={isAddOpen} onOpenChange={setIsAddOpen}>
          <DialogTrigger asChild>
            <Button>
              <Plus className="h-4 w-4 ml-2" />
              إرسال إشعار
            </Button>
          </DialogTrigger>
          <DialogContent className="max-w-lg">
            <DialogHeader>
              <DialogTitle>إرسال إشعار جديد</DialogTitle>
            </DialogHeader>
            <form onSubmit={handleSubmit} className="space-y-4">
              <div className="space-y-2">
                <Label htmlFor="type">المستلمين</Label>
                <Select
                  value={formData.type}
                  onValueChange={(value: 'all' | 'customers' | 'craftsmen') =>
                    setFormData({ ...formData, type: value })
                  }
                >
                  <SelectTrigger>
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="all">
                      <div className="flex items-center gap-2">
                        <Users className="h-4 w-4" />
                        الجميع
                      </div>
                    </SelectItem>
                    <SelectItem value="customers">
                      <div className="flex items-center gap-2">
                        <Users className="h-4 w-4" />
                        العملاء فقط
                      </div>
                    </SelectItem>
                    <SelectItem value="craftsmen">
                      <div className="flex items-center gap-2">
                        <Hammer className="h-4 w-4" />
                        الصنايعية فقط
                      </div>
                    </SelectItem>
                  </SelectContent>
                </Select>
              </div>

              <div className="grid grid-cols-2 gap-4">
                <div className="space-y-2">
                  <Label htmlFor="title">العنوان (English)</Label>
                  <Input
                    id="title"
                    value={formData.title}
                    onChange={(e) => setFormData({ ...formData, title: e.target.value })}
                    placeholder="Notification title"
                    dir="ltr"
                    required
                  />
                </div>
                <div className="space-y-2">
                  <Label htmlFor="titleAr">العنوان (عربي)</Label>
                  <Input
                    id="titleAr"
                    value={formData.titleAr}
                    onChange={(e) => setFormData({ ...formData, titleAr: e.target.value })}
                    placeholder="عنوان الإشعار"
                    required
                  />
                </div>
              </div>

              <div className="grid grid-cols-2 gap-4">
                <div className="space-y-2">
                  <Label htmlFor="body">المحتوى (English)</Label>
                  <textarea
                    id="body"
                    value={formData.body}
                    onChange={(e) => setFormData({ ...formData, body: e.target.value })}
                    placeholder="Notification body"
                    dir="ltr"
                    className="w-full min-h-[100px] rounded-md border border-input bg-background px-3 py-2 text-sm"
                    required
                  />
                </div>
                <div className="space-y-2">
                  <Label htmlFor="bodyAr">المحتوى (عربي)</Label>
                  <textarea
                    id="bodyAr"
                    value={formData.bodyAr}
                    onChange={(e) => setFormData({ ...formData, bodyAr: e.target.value })}
                    placeholder="محتوى الإشعار"
                    className="w-full min-h-[100px] rounded-md border border-input bg-background px-3 py-2 text-sm"
                    required
                  />
                </div>
              </div>

              <div className="flex justify-end gap-2">
                <Button
                  type="button"
                  variant="outline"
                  onClick={() => {
                    setIsAddOpen(false);
                    resetForm();
                  }}
                >
                  إلغاء
                </Button>
                <Button type="submit" disabled={sending}>
                  {sending ? (
                    <div className="animate-spin rounded-full h-4 w-4 border-b-2 border-white"></div>
                  ) : (
                    <>
                      <Send className="h-4 w-4 ml-2" />
                      إرسال
                    </>
                  )}
                </Button>
              </div>
            </form>
          </DialogContent>
        </Dialog>
      </div>

      {/* Stats */}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
        <Card>
          <CardContent className="pt-6">
            <div className="flex items-center gap-3">
              <div className="p-2 bg-blue-100 rounded-lg">
                <Bell className="h-5 w-5 text-blue-600" />
              </div>
              <div>
                <p className="text-2xl font-bold">{stats.total}</p>
                <p className="text-sm text-muted-foreground">إجمالي الإشعارات</p>
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
                <p className="text-2xl font-bold">{stats.sent}</p>
                <p className="text-sm text-muted-foreground">تم إرسالها</p>
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
                <p className="text-2xl font-bold">{stats.scheduled}</p>
                <p className="text-sm text-muted-foreground">مجدولة</p>
              </div>
            </div>
          </CardContent>
        </Card>
      </div>

      {/* Notifications Table */}
      <Card>
        <CardHeader>
          <CardTitle>سجل الإشعارات</CardTitle>
        </CardHeader>
        <CardContent>
          <Table>
            <TableHeader>
              <TableRow>
                <TableHead>العنوان</TableHead>
                <TableHead>المستلمين</TableHead>
                <TableHead>الحالة</TableHead>
                <TableHead>عدد المستلمين</TableHead>
                <TableHead>التاريخ</TableHead>
              </TableRow>
            </TableHeader>
            <TableBody>
              {notifications.length > 0 ? (
                notifications.map((notification) => (
                  <TableRow key={notification._id}>
                    <TableCell>
                      <div>
                        <p className="font-medium">{notification.titleAr}</p>
                        <p className="text-sm text-muted-foreground truncate max-w-[300px]">
                          {notification.bodyAr}
                        </p>
                      </div>
                    </TableCell>
                    <TableCell>
                      <Badge className={typeColors[notification.type] || 'bg-gray-100'}>
                        {typeLabels[notification.type] || notification.type}
                      </Badge>
                    </TableCell>
                    <TableCell>
                      <Badge className={statusColors[notification.status] || 'bg-gray-100'}>
                        {statusLabels[notification.status] || notification.status}
                      </Badge>
                    </TableCell>
                    <TableCell>
                      {notification.recipientCount !== undefined ? (
                        <span>{notification.recipientCount}</span>
                      ) : (
                        <span className="text-muted-foreground">-</span>
                      )}
                    </TableCell>
                    <TableCell>
                      <span className="text-sm">
                        {formatDate(notification.sentAt || notification.createdAt)}
                      </span>
                    </TableCell>
                  </TableRow>
                ))
              ) : (
                <TableRow>
                  <TableCell colSpan={5} className="text-center py-8">
                    <Bell className="h-12 w-12 mx-auto text-muted-foreground mb-2" />
                    <p className="text-muted-foreground">لا يوجد إشعارات</p>
                    <Button className="mt-4" onClick={() => setIsAddOpen(true)}>
                      إرسال إشعار
                    </Button>
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
    </div>
  );
}
