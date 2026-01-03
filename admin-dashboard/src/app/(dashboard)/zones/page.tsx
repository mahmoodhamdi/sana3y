'use client';

import { useState, useEffect } from 'react';
import { Plus, Pencil, Trash2, MapPin, Check, X } from 'lucide-react';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
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
import { getZones, createZone, updateZone, deleteZone, Zone } from '@/services/admin.service';

// Egyptian governorates
const governorates = [
  'المنوفية',
  'القاهرة',
  'الجيزة',
  'الإسكندرية',
  'الدقهلية',
  'الشرقية',
  'الغربية',
  'كفر الشيخ',
  'البحيرة',
  'القليوبية',
];

export default function ZonesPage() {
  const [zones, setZones] = useState<Zone[]>([]);
  const [loading, setLoading] = useState(true);
  const [isAddOpen, setIsAddOpen] = useState(false);
  const [editZone, setEditZone] = useState<Zone | null>(null);
  const [formData, setFormData] = useState({
    governorate: '',
    city: '',
    deliveryFee: 0,
    isActive: true,
  });

  useEffect(() => {
    fetchZones();
  }, []);

  const fetchZones = async () => {
    setLoading(true);
    const result = await getZones(1, 100);
    setZones(result.zones);
    setLoading(false);
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();

    let success = false;
    if (editZone) {
      success = await updateZone(editZone._id, formData);
    } else {
      const zone = await createZone(formData);
      success = zone !== null;
    }

    if (success) {
      fetchZones();
      setIsAddOpen(false);
      setEditZone(null);
      resetForm();
    }
  };

  const handleDelete = async (id: string) => {
    if (!confirm('هل أنت متأكد من حذف هذه المنطقة؟')) return;

    const success = await deleteZone(id);
    if (success) {
      fetchZones();
    }
  };

  const handleToggleStatus = async (zone: Zone) => {
    const success = await updateZone(zone._id, { isActive: !zone.isActive });
    if (success) {
      fetchZones();
    }
  };

  const resetForm = () => {
    setFormData({
      governorate: '',
      city: '',
      deliveryFee: 0,
      isActive: true,
    });
  };

  const openEditDialog = (zone: Zone) => {
    setFormData({
      governorate: zone.governorate,
      city: zone.city,
      deliveryFee: zone.deliveryFee || 0,
      isActive: zone.isActive,
    });
    setEditZone(zone);
    setIsAddOpen(true);
  };

  // Group zones by governorate
  const zonesByGovernorate = zones.reduce((acc, zone) => {
    if (!acc[zone.governorate]) {
      acc[zone.governorate] = [];
    }
    acc[zone.governorate].push(zone);
    return acc;
  }, {} as Record<string, Zone[]>);

  if (loading) {
    return (
      <div className="space-y-6">
        <Skeleton className="h-8 w-48" />
        <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
          {[...Array(4)].map((_, i) => (
            <Skeleton key={i} className="h-48" />
          ))}
        </div>
      </div>
    );
  }

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-2xl font-bold">مناطق الخدمة</h1>
          <p className="text-muted-foreground">إدارة المناطق المتاحة للخدمة</p>
        </div>
        <Dialog
          open={isAddOpen}
          onOpenChange={(open) => {
            setIsAddOpen(open);
            if (!open) {
              setEditZone(null);
              resetForm();
            }
          }}
        >
          <DialogTrigger asChild>
            <Button>
              <Plus className="h-4 w-4 ml-2" />
              إضافة منطقة
            </Button>
          </DialogTrigger>
          <DialogContent className="max-w-md">
            <DialogHeader>
              <DialogTitle>
                {editZone ? 'تعديل منطقة' : 'إضافة منطقة جديدة'}
              </DialogTitle>
            </DialogHeader>
            <form onSubmit={handleSubmit} className="space-y-4">
              <div className="space-y-2">
                <Label htmlFor="governorate">المحافظة</Label>
                <select
                  id="governorate"
                  value={formData.governorate}
                  onChange={(e) => setFormData({ ...formData, governorate: e.target.value })}
                  className="w-full rounded-md border border-input bg-background px-3 py-2"
                  required
                >
                  <option value="">اختر المحافظة</option>
                  {governorates.map((gov) => (
                    <option key={gov} value={gov}>{gov}</option>
                  ))}
                </select>
              </div>

              <div className="space-y-2">
                <Label htmlFor="city">المدينة</Label>
                <Input
                  id="city"
                  value={formData.city}
                  onChange={(e) => setFormData({ ...formData, city: e.target.value })}
                  placeholder="مثال: الباجور"
                  required
                />
              </div>

              <div className="space-y-2">
                <Label htmlFor="deliveryFee">رسوم التوصيل (ج.م)</Label>
                <Input
                  id="deliveryFee"
                  type="number"
                  min="0"
                  value={formData.deliveryFee}
                  onChange={(e) => setFormData({ ...formData, deliveryFee: Number(e.target.value) })}
                />
              </div>

              <div className="flex items-center gap-2">
                <input
                  type="checkbox"
                  id="isActive"
                  checked={formData.isActive}
                  onChange={(e) => setFormData({ ...formData, isActive: e.target.checked })}
                />
                <Label htmlFor="isActive">منطقة نشطة</Label>
              </div>

              <div className="flex justify-end gap-2">
                <Button
                  type="button"
                  variant="outline"
                  onClick={() => {
                    setIsAddOpen(false);
                    setEditZone(null);
                    resetForm();
                  }}
                >
                  إلغاء
                </Button>
                <Button type="submit">
                  {editZone ? 'حفظ' : 'إضافة'}
                </Button>
              </div>
            </form>
          </DialogContent>
        </Dialog>
      </div>

      {/* Stats */}
      <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
        <Card>
          <CardContent className="pt-6">
            <div className="flex items-center gap-3">
              <div className="p-2 bg-blue-100 rounded-lg">
                <MapPin className="h-5 w-5 text-blue-600" />
              </div>
              <div>
                <p className="text-2xl font-bold">{zones.length}</p>
                <p className="text-sm text-muted-foreground">إجمالي المناطق</p>
              </div>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardContent className="pt-6">
            <div className="flex items-center gap-3">
              <div className="p-2 bg-green-100 rounded-lg">
                <Check className="h-5 w-5 text-green-600" />
              </div>
              <div>
                <p className="text-2xl font-bold">{zones.filter(z => z.isActive).length}</p>
                <p className="text-sm text-muted-foreground">مناطق نشطة</p>
              </div>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardContent className="pt-6">
            <div className="flex items-center gap-3">
              <div className="p-2 bg-purple-100 rounded-lg">
                <MapPin className="h-5 w-5 text-purple-600" />
              </div>
              <div>
                <p className="text-2xl font-bold">{Object.keys(zonesByGovernorate).length}</p>
                <p className="text-sm text-muted-foreground">محافظات</p>
              </div>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardContent className="pt-6">
            <div className="flex items-center gap-3">
              <div className="p-2 bg-gray-100 rounded-lg">
                <X className="h-5 w-5 text-gray-600" />
              </div>
              <div>
                <p className="text-2xl font-bold">{zones.filter(z => !z.isActive).length}</p>
                <p className="text-sm text-muted-foreground">مناطق معطلة</p>
              </div>
            </div>
          </CardContent>
        </Card>
      </div>

      {/* Zones Table */}
      <Card>
        <CardHeader>
          <CardTitle>قائمة المناطق</CardTitle>
        </CardHeader>
        <CardContent>
          <Table>
            <TableHeader>
              <TableRow>
                <TableHead>المحافظة</TableHead>
                <TableHead>المدينة</TableHead>
                <TableHead>رسوم التوصيل</TableHead>
                <TableHead>الحالة</TableHead>
                <TableHead></TableHead>
              </TableRow>
            </TableHeader>
            <TableBody>
              {zones.length > 0 ? (
                zones.map((zone) => (
                  <TableRow key={zone._id}>
                    <TableCell>
                      <span className="font-medium">{zone.governorate}</span>
                    </TableCell>
                    <TableCell>
                      <div className="flex items-center gap-1">
                        <MapPin className="h-3 w-3" />
                        {zone.city}
                      </div>
                    </TableCell>
                    <TableCell>
                      {zone.deliveryFee ? `${zone.deliveryFee} ج.م` : 'مجاني'}
                    </TableCell>
                    <TableCell>
                      {zone.isActive ? (
                        <Badge className="bg-green-100 text-green-800 hover:bg-green-100">
                          نشطة
                        </Badge>
                      ) : (
                        <Badge variant="secondary">معطلة</Badge>
                      )}
                    </TableCell>
                    <TableCell>
                      <div className="flex gap-1">
                        <Button
                          variant="ghost"
                          size="icon"
                          onClick={() => handleToggleStatus(zone)}
                          title={zone.isActive ? 'تعطيل' : 'تفعيل'}
                        >
                          {zone.isActive ? (
                            <X className="h-4 w-4" />
                          ) : (
                            <Check className="h-4 w-4" />
                          )}
                        </Button>
                        <Button
                          variant="ghost"
                          size="icon"
                          onClick={() => openEditDialog(zone)}
                        >
                          <Pencil className="h-4 w-4" />
                        </Button>
                        <Button
                          variant="ghost"
                          size="icon"
                          onClick={() => handleDelete(zone._id)}
                        >
                          <Trash2 className="h-4 w-4 text-destructive" />
                        </Button>
                      </div>
                    </TableCell>
                  </TableRow>
                ))
              ) : (
                <TableRow>
                  <TableCell colSpan={5} className="text-center py-8">
                    <MapPin className="h-12 w-12 mx-auto text-muted-foreground mb-2" />
                    <p className="text-muted-foreground">لا يوجد مناطق</p>
                    <Button className="mt-4" onClick={() => setIsAddOpen(true)}>
                      إضافة منطقة
                    </Button>
                  </TableCell>
                </TableRow>
              )}
            </TableBody>
          </Table>
        </CardContent>
      </Card>
    </div>
  );
}
