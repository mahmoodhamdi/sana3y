import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../models/request.dart';
import '../../providers/request_provider.dart';
import '../../widgets/loading_button.dart';

class SendQuoteScreen extends ConsumerStatefulWidget {
  final String requestId;

  const SendQuoteScreen({super.key, required this.requestId});

  @override
  ConsumerState<SendQuoteScreen> createState() => _SendQuoteScreenState();
}

class _SendQuoteScreenState extends ConsumerState<SendQuoteScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _durationController = TextEditingController();
  final _notesController = TextEditingController();
  bool _isSubmitting = false;
  DateTime? _validUntil;

  @override
  void dispose() {
    _amountController.dispose();
    _durationController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final requestAsync = ref.watch(requestDetailProvider(widget.requestId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('تقديم عرض سعر'),
      ),
      body: requestAsync.when(
        data: (request) => _buildContent(context, request),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text('فشل في تحميل الطلب: $error'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.invalidate(requestDetailProvider(widget.requestId)),
                child: const Text('إعادة المحاولة'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, ServiceRequest request) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Request Summary Card
            _RequestSummaryCard(request: request),
            const SizedBox(height: 24),

            // Quote Form
            const Text(
              'تفاصيل العرض',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Amount
            TextFormField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'سعر الخدمة',
                hintText: 'أدخل السعر بالجنيه',
                prefixIcon: const Icon(Icons.attach_money),
                suffixText: 'ج.م',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'الرجاء إدخال السعر';
                }
                final amount = double.tryParse(value);
                if (amount == null || amount <= 0) {
                  return 'الرجاء إدخال سعر صحيح';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Estimated Duration
            TextFormField(
              controller: _durationController,
              decoration: InputDecoration(
                labelText: 'المدة المتوقعة',
                hintText: 'مثال: ساعتين، يوم واحد',
                prefixIcon: const Icon(Icons.access_time),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Valid Until
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.event),
              title: Text(
                _validUntil != null
                    ? 'صالح حتى: ${_validUntil!.day}/${_validUntil!.month}/${_validUntil!.year}'
                    : 'تاريخ انتهاء العرض (اختياري)',
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now().add(const Duration(days: 3)),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 30)),
                );
                if (date != null) {
                  setState(() => _validUntil = date);
                }
              },
            ),
            const SizedBox(height: 16),

            // Notes
            TextFormField(
              controller: _notesController,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: 'ملاحظات إضافية',
                hintText: 'أضف أي تفاصيل أو شروط للعرض...',
                prefixIcon: const Padding(
                  padding: EdgeInsets.only(bottom: 60),
                  child: Icon(Icons.notes),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Customer Budget Info
            if (request.budget != null)
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
                        'ميزانية العميل: ${request.budget!.min.toInt()} - ${request.budget!.max.toInt()} ج.م',
                        style: TextStyle(color: Colors.blue[700]),
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 24),

            // Submit Button
            SizedBox(
              width: double.infinity,
              child: LoadingButton(
                text: 'إرسال العرض',
                isLoading: _isSubmitting,
                onPressed: _submitQuote,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submitQuote() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    try {
      final quoteData = SubmitQuoteData(
        amount: double.parse(_amountController.text),
        estimatedDuration: _durationController.text.isNotEmpty
            ? _durationController.text
            : null,
        notes: _notesController.text.isNotEmpty ? _notesController.text : null,
        validUntil: _validUntil,
      );

      await ref.read(availableRequestsNotifierProvider.notifier).submitQuote(
            widget.requestId,
            quoteData,
          );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('تم إرسال العرض بنجاح'),
            backgroundColor: Colors.green,
          ),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('فشل في إرسال العرض: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }
}

class _RequestSummaryCard extends StatelessWidget {
  final ServiceRequest request;

  const _RequestSummaryCard({required this.request});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.work_outline,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        request.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        request.category.nameAr,
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      ),
                    ],
                  ),
                ),
                _UrgencyBadge(urgency: request.urgency),
              ],
            ),
            const Divider(height: 24),
            Text(
              request.description,
              style: TextStyle(color: Colors.grey[700], height: 1.5),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.location_on, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    '${request.location.city}، ${request.location.governorate}',
                    style: TextStyle(color: Colors.grey[600], fontSize: 13),
                  ),
                ),
              ],
            ),
            if (request.preferredDate != null) ...[
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(
                    '${request.preferredDate!.day}/${request.preferredDate!.month}/${request.preferredDate!.year}',
                    style: TextStyle(color: Colors.grey[600], fontSize: 13),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _UrgencyBadge extends StatelessWidget {
  final RequestUrgency urgency;

  const _UrgencyBadge({required this.urgency});

  @override
  Widget build(BuildContext context) {
    Color color;
    String label;

    switch (urgency) {
      case RequestUrgency.normal:
        color = Colors.grey;
        label = 'عادي';
        break;
      case RequestUrgency.urgent:
        color = Colors.orange;
        label = 'مستعجل';
        break;
      case RequestUrgency.emergency:
        color = Colors.red;
        label = 'طوارئ';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w500),
      ),
    );
  }
}
