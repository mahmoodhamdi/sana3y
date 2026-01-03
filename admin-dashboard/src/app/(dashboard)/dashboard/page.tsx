import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';

const stats = [
  { title: 'إجمالي الطلبات', value: '0', icon: '📋' },
  { title: 'الصنايعية النشطين', value: '0', icon: '👷' },
  { title: 'العملاء', value: '0', icon: '👥' },
  { title: 'الإيرادات (ج.م)', value: '0', icon: '💰' },
];

export default function DashboardPage() {
  return (
    <div className="p-6">
      <h1 className="text-2xl font-bold mb-6">لوحة التحكم</h1>

      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
        {stats.map((stat) => (
          <Card key={stat.title}>
            <CardHeader className="flex flex-row items-center justify-between pb-2">
              <CardTitle className="text-sm font-medium text-muted-foreground">
                {stat.title}
              </CardTitle>
              <span className="text-2xl">{stat.icon}</span>
            </CardHeader>
            <CardContent>
              <div className="text-3xl font-bold">{stat.value}</div>
            </CardContent>
          </Card>
        ))}
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        <Card>
          <CardHeader>
            <CardTitle>طلبات الموافقة المعلقة</CardTitle>
          </CardHeader>
          <CardContent>
            <p className="text-muted-foreground">لا يوجد طلبات معلقة</p>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>آخر الطلبات</CardTitle>
          </CardHeader>
          <CardContent>
            <p className="text-muted-foreground">لا يوجد طلبات حديثة</p>
          </CardContent>
        </Card>
      </div>
    </div>
  );
}
