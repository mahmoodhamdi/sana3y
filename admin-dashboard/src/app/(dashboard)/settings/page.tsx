'use client';

import { useState, useEffect } from 'react';
import { Save, Settings, Percent, DollarSign, MapPin, Phone, Mail, FileText } from 'lucide-react';
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Skeleton } from '@/components/ui/skeleton';
import { Separator } from '@/components/ui/separator';
import { getSettings, updateSettings, AppSettings } from '@/services/admin.service';

export default function SettingsPage() {
  const [settings, setSettings] = useState<AppSettings | null>(null);
  const [loading, setLoading] = useState(true);
  const [saving, setSaving] = useState(false);
  const [formData, setFormData] = useState<AppSettings>({
    commissionRate: 15,
    serviceFee: 5,
    urgentFee: 20,
    defaultRadius: 10,
    minWithdrawal: 100,
    maxWithdrawal: 10000,
    supportPhone: '',
    supportEmail: '',
    termsUrl: '',
    privacyUrl: '',
  });

  useEffect(() => {
    fetchSettings();
  }, []);

  const fetchSettings = async () => {
    setLoading(true);
    const data = await getSettings();
    setSettings(data);
    setFormData(data);
    setLoading(false);
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setSaving(true);
    const success = await updateSettings(formData);
    if (success) {
      setSettings(formData);
      alert('تم حفظ الإعدادات بنجاح');
    } else {
      alert('حدث خطأ أثناء حفظ الإعدادات');
    }
    setSaving(false);
  };

  if (loading) {
    return (
      <div className="space-y-6">
        <Skeleton className="h-8 w-48" />
        <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
          {[...Array(4)].map((_, i) => (
            <Skeleton key={i} className="h-64" />
          ))}
        </div>
      </div>
    );
  }

  return (
    <div className="space-y-6">
      {/* Header */}
      <div>
        <h1 className="text-2xl font-bold">الإعدادات</h1>
        <p className="text-muted-foreground">إدارة إعدادات المنصة</p>
      </div>

      <form onSubmit={handleSubmit} className="space-y-6">
        <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
          {/* Commission Settings */}
          <Card>
            <CardHeader>
              <CardTitle className="flex items-center gap-2">
                <Percent className="h-5 w-5" />
                إعدادات العمولة
              </CardTitle>
              <CardDescription>
                نسب العمولة والرسوم على المعاملات
              </CardDescription>
            </CardHeader>
            <CardContent className="space-y-4">
              <div className="space-y-2">
                <Label htmlFor="commissionRate">نسبة العمولة من الصنايعي (%)</Label>
                <Input
                  id="commissionRate"
                  type="number"
                  min="0"
                  max="100"
                  value={formData.commissionRate}
                  onChange={(e) =>
                    setFormData({ ...formData, commissionRate: Number(e.target.value) })
                  }
                />
                <p className="text-xs text-muted-foreground">
                  النسبة المستقطعة من كل طلب مكتمل
                </p>
              </div>

              <div className="space-y-2">
                <Label htmlFor="serviceFee">رسوم الخدمة من العميل (%)</Label>
                <Input
                  id="serviceFee"
                  type="number"
                  min="0"
                  max="100"
                  value={formData.serviceFee}
                  onChange={(e) =>
                    setFormData({ ...formData, serviceFee: Number(e.target.value) })
                  }
                />
                <p className="text-xs text-muted-foreground">
                  النسبة المضافة على سعر الخدمة للعميل
                </p>
              </div>

              <div className="space-y-2">
                <Label htmlFor="urgentFee">رسوم الطلب العاجل (%)</Label>
                <Input
                  id="urgentFee"
                  type="number"
                  min="0"
                  max="100"
                  value={formData.urgentFee}
                  onChange={(e) =>
                    setFormData({ ...formData, urgentFee: Number(e.target.value) })
                  }
                />
                <p className="text-xs text-muted-foreground">
                  النسبة الإضافية للطلبات العاجلة
                </p>
              </div>
            </CardContent>
          </Card>

          {/* Withdrawal Settings */}
          <Card>
            <CardHeader>
              <CardTitle className="flex items-center gap-2">
                <DollarSign className="h-5 w-5" />
                إعدادات السحب
              </CardTitle>
              <CardDescription>
                حدود السحب للصنايعية
              </CardDescription>
            </CardHeader>
            <CardContent className="space-y-4">
              <div className="space-y-2">
                <Label htmlFor="minWithdrawal">الحد الأدنى للسحب (ج.م)</Label>
                <Input
                  id="minWithdrawal"
                  type="number"
                  min="0"
                  value={formData.minWithdrawal}
                  onChange={(e) =>
                    setFormData({ ...formData, minWithdrawal: Number(e.target.value) })
                  }
                />
              </div>

              <div className="space-y-2">
                <Label htmlFor="maxWithdrawal">الحد الأقصى للسحب (ج.م)</Label>
                <Input
                  id="maxWithdrawal"
                  type="number"
                  min="0"
                  value={formData.maxWithdrawal}
                  onChange={(e) =>
                    setFormData({ ...formData, maxWithdrawal: Number(e.target.value) })
                  }
                />
              </div>

              <div className="space-y-2">
                <Label htmlFor="defaultRadius">نطاق الخدمة الافتراضي (كم)</Label>
                <Input
                  id="defaultRadius"
                  type="number"
                  min="1"
                  value={formData.defaultRadius}
                  onChange={(e) =>
                    setFormData({ ...formData, defaultRadius: Number(e.target.value) })
                  }
                />
                <p className="text-xs text-muted-foreground">
                  المسافة الافتراضية للبحث عن صنايعية
                </p>
              </div>
            </CardContent>
          </Card>

          {/* Support Settings */}
          <Card>
            <CardHeader>
              <CardTitle className="flex items-center gap-2">
                <Phone className="h-5 w-5" />
                بيانات الدعم
              </CardTitle>
              <CardDescription>
                معلومات التواصل مع الدعم الفني
              </CardDescription>
            </CardHeader>
            <CardContent className="space-y-4">
              <div className="space-y-2">
                <Label htmlFor="supportPhone">رقم الدعم</Label>
                <Input
                  id="supportPhone"
                  type="tel"
                  value={formData.supportPhone}
                  onChange={(e) =>
                    setFormData({ ...formData, supportPhone: e.target.value })
                  }
                  placeholder="+201000000000"
                  dir="ltr"
                />
              </div>

              <div className="space-y-2">
                <Label htmlFor="supportEmail">بريد الدعم</Label>
                <Input
                  id="supportEmail"
                  type="email"
                  value={formData.supportEmail}
                  onChange={(e) =>
                    setFormData({ ...formData, supportEmail: e.target.value })
                  }
                  placeholder="support@sana3y.com"
                  dir="ltr"
                />
              </div>
            </CardContent>
          </Card>

          {/* Legal Settings */}
          <Card>
            <CardHeader>
              <CardTitle className="flex items-center gap-2">
                <FileText className="h-5 w-5" />
                الصفحات القانونية
              </CardTitle>
              <CardDescription>
                روابط الشروط والأحكام وسياسة الخصوصية
              </CardDescription>
            </CardHeader>
            <CardContent className="space-y-4">
              <div className="space-y-2">
                <Label htmlFor="termsUrl">رابط الشروط والأحكام</Label>
                <Input
                  id="termsUrl"
                  type="url"
                  value={formData.termsUrl || ''}
                  onChange={(e) =>
                    setFormData({ ...formData, termsUrl: e.target.value })
                  }
                  placeholder="https://..."
                  dir="ltr"
                />
              </div>

              <div className="space-y-2">
                <Label htmlFor="privacyUrl">رابط سياسة الخصوصية</Label>
                <Input
                  id="privacyUrl"
                  type="url"
                  value={formData.privacyUrl || ''}
                  onChange={(e) =>
                    setFormData({ ...formData, privacyUrl: e.target.value })
                  }
                  placeholder="https://..."
                  dir="ltr"
                />
              </div>
            </CardContent>
          </Card>
        </div>

        {/* Save Button */}
        <div className="flex justify-end">
          <Button type="submit" disabled={saving} className="min-w-32">
            {saving ? (
              <div className="animate-spin rounded-full h-4 w-4 border-b-2 border-white"></div>
            ) : (
              <>
                <Save className="h-4 w-4 ml-2" />
                حفظ الإعدادات
              </>
            )}
          </Button>
        </div>
      </form>
    </div>
  );
}
