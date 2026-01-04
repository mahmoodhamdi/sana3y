import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EarningsHistoryScreen extends ConsumerStatefulWidget {
  const EarningsHistoryScreen({super.key});

  @override
  ConsumerState<EarningsHistoryScreen> createState() => _EarningsHistoryScreenState();
}

class _EarningsHistoryScreenState extends ConsumerState<EarningsHistoryScreen> {
  String _selectedPeriod = 'month';
  final List<_EarningEntry> _earnings = [
    _EarningEntry(
      id: '1',
      title: 'تركيب سخان مياه',
      customerName: 'أحمد محمد',
      amount: 450,
      commission: 67.5,
      date: DateTime.now().subtract(const Duration(days: 1)),
    ),
    _EarningEntry(
      id: '2',
      title: 'إصلاح صنبور',
      customerName: 'محمد علي',
      amount: 150,
      commission: 22.5,
      date: DateTime.now().subtract(const Duration(days: 3)),
    ),
    _EarningEntry(
      id: '3',
      title: 'تمديد مواسير',
      customerName: 'علي أحمد',
      amount: 800,
      commission: 120,
      date: DateTime.now().subtract(const Duration(days: 5)),
    ),
    _EarningEntry(
      id: '4',
      title: 'إصلاح تسريب',
      customerName: 'محمود سعيد',
      amount: 200,
      commission: 30,
      date: DateTime.now().subtract(const Duration(days: 10)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final totalEarnings = _earnings.fold<double>(0, (sum, e) => sum + e.amount);
    final totalCommission = _earnings.fold<double>(0, (sum, e) => sum + e.commission);
    final netEarnings = totalEarnings - totalCommission;

    return Scaffold(
      appBar: AppBar(
        title: const Text('سجل الأرباح'),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('جاري تحميل التقرير...')),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Period Selector
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                _PeriodChip(
                  label: 'هذا الأسبوع',
                  isSelected: _selectedPeriod == 'week',
                  onTap: () => setState(() => _selectedPeriod = 'week'),
                ),
                const SizedBox(width: 8),
                _PeriodChip(
                  label: 'هذا الشهر',
                  isSelected: _selectedPeriod == 'month',
                  onTap: () => setState(() => _selectedPeriod = 'month'),
                ),
                const SizedBox(width: 8),
                _PeriodChip(
                  label: 'هذه السنة',
                  isSelected: _selectedPeriod == 'year',
                  onTap: () => setState(() => _selectedPeriod = 'year'),
                ),
              ],
            ),
          ),

          // Summary Card
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _SummaryItem(
                            label: 'إجمالي الأرباح',
                            value: '${totalEarnings.toInt()} ج.م',
                            color: Colors.blue,
                          ),
                        ),
                        Container(width: 1, height: 50, color: Colors.grey[300]),
                        Expanded(
                          child: _SummaryItem(
                            label: 'العمولة',
                            value: '${totalCommission.toInt()} ج.م',
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 24),
                    _SummaryItem(
                      label: 'صافي الأرباح',
                      value: '${netEarnings.toInt()} ج.م',
                      color: Colors.green,
                      isLarge: true,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Transactions List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _earnings.length,
              itemBuilder: (context, index) {
                final earning = _earnings[index];
                return _EarningCard(earning: earning);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _PeriodChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _PeriodChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).primaryColor
              : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey[700],
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  final bool isLarge;

  const _SummaryItem({
    required this.label,
    required this.value,
    required this.color,
    this.isLarge = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.grey[600], fontSize: 12),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: isLarge ? 28 : 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}

class _EarningEntry {
  final String id;
  final String title;
  final String customerName;
  final double amount;
  final double commission;
  final DateTime date;

  _EarningEntry({
    required this.id,
    required this.title,
    required this.customerName,
    required this.amount,
    required this.commission,
    required this.date,
  });
}

class _EarningCard extends StatelessWidget {
  final _EarningEntry earning;

  const _EarningCard({required this.earning});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        earning.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        earning.customerName,
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '+${earning.amount.toInt()} ج.م',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.green,
                      ),
                    ),
                    Text(
                      '-${earning.commission.toInt()} عمولة',
                      style: TextStyle(
                        color: Colors.red[400],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Divider(height: 16),
            Row(
              children: [
                Icon(Icons.calendar_today, size: 14, color: Colors.grey[500]),
                const SizedBox(width: 4),
                Text(
                  '${earning.date.day}/${earning.date.month}/${earning.date.year}',
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'صافي: ${(earning.amount - earning.commission).toInt()} ج.م',
                    style: TextStyle(
                      color: Colors.green[700],
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
