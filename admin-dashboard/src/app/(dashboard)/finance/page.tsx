'use client';

import { useState, useEffect } from 'react';
import {
  DollarSign,
  TrendingUp,
  ArrowUpRight,
  ArrowDownLeft,
  Wallet,
  CreditCard,
  Filter,
} from 'lucide-react';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
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
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs';
import { getTransactions, getFinanceStats, Transaction, FinanceStats } from '@/services/admin.service';

const transactionTypeLabels: Record<string, string> = {
  payment: 'دفع',
  payout: 'سحب',
  refund: 'استرداد',
  commission: 'عمولة',
};

const transactionTypeColors: Record<string, string> = {
  payment: 'bg-green-100 text-green-800',
  payout: 'bg-blue-100 text-blue-800',
  refund: 'bg-orange-100 text-orange-800',
  commission: 'bg-purple-100 text-purple-800',
};

const transactionStatusLabels: Record<string, string> = {
  pending: 'قيد المعالجة',
  completed: 'مكتمل',
  failed: 'فشل',
  cancelled: 'ملغي',
};

const transactionStatusColors: Record<string, string> = {
  pending: 'bg-yellow-100 text-yellow-800',
  completed: 'bg-green-100 text-green-800',
  failed: 'bg-red-100 text-red-800',
  cancelled: 'bg-gray-100 text-gray-800',
};

export default function FinancePage() {
  const [stats, setStats] = useState<FinanceStats | null>(null);
  const [transactions, setTransactions] = useState<Transaction[]>([]);
  const [loading, setLoading] = useState(true);
  const [typeFilter, setTypeFilter] = useState<string>('all');
  const [statusFilter, setStatusFilter] = useState<string>('all');
  const [page, setPage] = useState(1);
  const [totalPages, setTotalPages] = useState(1);
  const [total, setTotal] = useState(0);

  useEffect(() => {
    fetchData();
  }, [page, typeFilter, statusFilter]);

  const fetchData = async () => {
    setLoading(true);
    const [statsData, transactionsData] = await Promise.all([
      getFinanceStats(),
      getTransactions(page, 20, {
        type: typeFilter !== 'all' ? typeFilter : undefined,
        status: statusFilter !== 'all' ? statusFilter : undefined,
      }),
    ]);
    setStats(statsData);
    setTransactions(transactionsData.transactions);
    setTotalPages(transactionsData.totalPages);
    setTotal(transactionsData.total);
    setLoading(false);
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
      hour: '2-digit',
      minute: '2-digit',
    });
  };

  if (loading && !stats) {
    return (
      <div className="space-y-6">
        <Skeleton className="h-8 w-48" />
        <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
          {[...Array(4)].map((_, i) => (
            <Skeleton key={i} className="h-32" />
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
        <h1 className="text-2xl font-bold">المالية</h1>
        <p className="text-muted-foreground">متابعة الإيرادات والمعاملات المالية</p>
      </div>

      {/* Stats */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
        <Card>
          <CardHeader className="flex flex-row items-center justify-between pb-2">
            <CardTitle className="text-sm font-medium text-muted-foreground">
              إجمالي الإيرادات
            </CardTitle>
            <DollarSign className="h-5 w-5 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-3xl font-bold">{formatCurrency(stats?.totalRevenue || 0)}</div>
            <div className="flex items-center gap-1 mt-1 text-sm text-green-600">
              <TrendingUp className="h-4 w-4" />
              <span>منذ البداية</span>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="flex flex-row items-center justify-between pb-2">
            <CardTitle className="text-sm font-medium text-muted-foreground">
              إيرادات الشهر
            </CardTitle>
            <ArrowUpRight className="h-5 w-5 text-green-500" />
          </CardHeader>
          <CardContent>
            <div className="text-3xl font-bold">{formatCurrency(stats?.monthlyRevenue || 0)}</div>
            <div className="flex items-center gap-1 mt-1 text-sm text-muted-foreground">
              <span>هذا الشهر</span>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="flex flex-row items-center justify-between pb-2">
            <CardTitle className="text-sm font-medium text-muted-foreground">
              العمولات
            </CardTitle>
            <Wallet className="h-5 w-5 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-3xl font-bold">{formatCurrency(stats?.totalCommissions || 0)}</div>
            <div className="flex items-center gap-1 mt-1 text-sm text-muted-foreground">
              <span>إجمالي العمولات</span>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="flex flex-row items-center justify-between pb-2">
            <CardTitle className="text-sm font-medium text-muted-foreground">
              مستحقات معلقة
            </CardTitle>
            <CreditCard className="h-5 w-5 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-3xl font-bold text-yellow-600">
              {formatCurrency(stats?.pendingPayouts || 0)}
            </div>
            <div className="flex items-center gap-1 mt-1 text-sm text-muted-foreground">
              <span>بانتظار التحويل</span>
            </div>
          </CardContent>
        </Card>
      </div>

      {/* Transactions */}
      <Card>
        <CardHeader>
          <div className="flex flex-col md:flex-row items-start md:items-center justify-between gap-4">
            <CardTitle>المعاملات المالية</CardTitle>
            <div className="flex gap-2">
              <Select value={typeFilter} onValueChange={setTypeFilter}>
                <SelectTrigger className="w-32">
                  <SelectValue placeholder="النوع" />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="all">الكل</SelectItem>
                  <SelectItem value="payment">دفع</SelectItem>
                  <SelectItem value="payout">سحب</SelectItem>
                  <SelectItem value="commission">عمولة</SelectItem>
                  <SelectItem value="refund">استرداد</SelectItem>
                </SelectContent>
              </Select>
              <Select value={statusFilter} onValueChange={setStatusFilter}>
                <SelectTrigger className="w-32">
                  <SelectValue placeholder="الحالة" />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="all">الكل</SelectItem>
                  <SelectItem value="pending">قيد المعالجة</SelectItem>
                  <SelectItem value="completed">مكتمل</SelectItem>
                  <SelectItem value="failed">فشل</SelectItem>
                </SelectContent>
              </Select>
            </div>
          </div>
        </CardHeader>
        <CardContent>
          <Table>
            <TableHeader>
              <TableRow>
                <TableHead>النوع</TableHead>
                <TableHead>المبلغ</TableHead>
                <TableHead>المستخدم</TableHead>
                <TableHead>الطلب</TableHead>
                <TableHead>الحالة</TableHead>
                <TableHead>التاريخ</TableHead>
              </TableRow>
            </TableHeader>
            <TableBody>
              {transactions.length > 0 ? (
                transactions.map((transaction) => (
                  <TableRow key={transaction._id}>
                    <TableCell>
                      <Badge className={transactionTypeColors[transaction.type] || 'bg-gray-100'}>
                        {transactionTypeLabels[transaction.type] || transaction.type}
                      </Badge>
                    </TableCell>
                    <TableCell>
                      <div className="flex items-center gap-1">
                        {transaction.type === 'payout' || transaction.type === 'refund' ? (
                          <ArrowDownLeft className="h-4 w-4 text-red-500" />
                        ) : (
                          <ArrowUpRight className="h-4 w-4 text-green-500" />
                        )}
                        <span className="font-medium">{formatCurrency(transaction.amount)}</span>
                      </div>
                    </TableCell>
                    <TableCell>
                      <span className="text-sm">{transaction.userId?.name || '-'}</span>
                    </TableCell>
                    <TableCell>
                      <span className="text-sm truncate max-w-[150px] block">
                        {transaction.requestId?.title || '-'}
                      </span>
                    </TableCell>
                    <TableCell>
                      <Badge className={transactionStatusColors[transaction.status] || 'bg-gray-100'}>
                        {transactionStatusLabels[transaction.status] || transaction.status}
                      </Badge>
                    </TableCell>
                    <TableCell>
                      <span className="text-sm">{formatDate(transaction.createdAt)}</span>
                    </TableCell>
                  </TableRow>
                ))
              ) : (
                <TableRow>
                  <TableCell colSpan={6} className="text-center py-8">
                    <DollarSign className="h-12 w-12 mx-auto text-muted-foreground mb-2" />
                    <p className="text-muted-foreground">لا يوجد معاملات</p>
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
