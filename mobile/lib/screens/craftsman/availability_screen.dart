import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/craftsman_provider.dart';
import '../../widgets/loading_button.dart';

class AvailabilityScreen extends ConsumerStatefulWidget {
  const AvailabilityScreen({super.key});

  @override
  ConsumerState<AvailabilityScreen> createState() => _AvailabilityScreenState();
}

class _AvailabilityScreenState extends ConsumerState<AvailabilityScreen> {
  final Map<String, bool> _workDays = {
    'السبت': true,
    'الأحد': true,
    'الاثنين': true,
    'الثلاثاء': true,
    'الأربعاء': true,
    'الخميس': true,
    'الجمعة': false,
  };

  TimeOfDay _startTime = const TimeOfDay(hour: 8, minute: 0);
  TimeOfDay _endTime = const TimeOfDay(hour: 18, minute: 0);
  bool _isAvailable = true;
  bool _isSaving = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('أوقات العمل'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Availability Toggle
            Card(
              child: SwitchListTile(
                value: _isAvailable,
                onChanged: (value) {
                  setState(() => _isAvailable = value);
                },
                title: const Text(
                  'متاح للعمل',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  _isAvailable ? 'تقبل طلبات جديدة' : 'لا تقبل طلبات جديدة',
                  style: TextStyle(
                    color: _isAvailable ? Colors.green : Colors.red,
                  ),
                ),
                secondary: Icon(
                  _isAvailable ? Icons.check_circle : Icons.cancel,
                  color: _isAvailable ? Colors.green : Colors.red,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Work Hours
            const Text(
              'ساعات العمل',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: _TimeSelector(
                        label: 'من',
                        time: _startTime,
                        onTap: () => _selectTime(true),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Icon(Icons.arrow_forward),
                    ),
                    Expanded(
                      child: _TimeSelector(
                        label: 'إلى',
                        time: _endTime,
                        onTap: () => _selectTime(false),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Work Days
            const Text(
              'أيام العمل',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Card(
              child: Column(
                children: _workDays.entries.map((entry) {
                  return CheckboxListTile(
                    value: entry.value,
                    onChanged: (value) {
                      setState(() {
                        _workDays[entry.key] = value ?? false;
                      });
                    },
                    title: Text(entry.key),
                    secondary: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: entry.value ? Colors.green[50] : Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        entry.value ? 'متاح' : 'عطلة',
                        style: TextStyle(
                          color: entry.value ? Colors.green[700] : Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 24),

            // Quick Actions
            const Text(
              'إجراءات سريعة',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      setState(() {
                        _workDays.updateAll((key, value) => true);
                      });
                    },
                    icon: const Icon(Icons.select_all),
                    label: const Text('تحديد الكل'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      setState(() {
                        _workDays.updateAll((key, value) => key != 'الجمعة');
                      });
                    },
                    icon: const Icon(Icons.restart_alt),
                    label: const Text('إعادة تعيين'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Save Button
            SizedBox(
              width: double.infinity,
              child: LoadingButton(
                text: 'حفظ التغييرات',
                isLoading: _isSaving,
                onPressed: _saveAvailability,
              ),
            ),
            const SizedBox(height: 16),

            // Info
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.blue[700]),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'سيتم عرض أوقات عملك للعملاء عند حجز خدماتك',
                      style: TextStyle(color: Colors.blue[700]),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectTime(bool isStartTime) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: isStartTime ? _startTime : _endTime,
    );

    if (picked != null) {
      setState(() {
        if (isStartTime) {
          _startTime = picked;
        } else {
          _endTime = picked;
        }
      });
    }
  }

  Future<void> _saveAvailability() async {
    setState(() => _isSaving = true);

    try {
      final workDaysList = _workDays.entries
          .where((e) => e.value)
          .map((e) => e.key)
          .toList();

      await ref.read(craftsmanServiceProvider).updateProfile({
        'isAvailable': _isAvailable,
        'workDays': workDaysList,
        'workHours': {
          'start': '${_startTime.hour}:${_startTime.minute.toString().padLeft(2, '0')}',
          'end': '${_endTime.hour}:${_endTime.minute.toString().padLeft(2, '0')}',
        },
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('تم حفظ أوقات العمل'),
            backgroundColor: Colors.green,
          ),
        );
        ref.invalidate(myCraftsmanProfileProvider);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('فشل في الحفظ: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }
}

class _TimeSelector extends StatelessWidget {
  final String label;
  final TimeOfDay time;
  final VoidCallback onTap;

  const _TimeSelector({
    required this.label,
    required this.time,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
            const SizedBox(height: 4),
            Text(
              '${time.hour}:${time.minute.toString().padLeft(2, '0')}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              time.hour < 12 ? 'صباحاً' : 'مساءً',
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
