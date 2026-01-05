import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../../models/request.dart';
import '../../providers/request_provider.dart';
import '../../widgets/loading_button.dart';
import '../../services/api_client.dart';
import '../../config/constants.dart';

class CompleteJobScreen extends ConsumerStatefulWidget {
  final String jobId;

  const CompleteJobScreen({super.key, required this.jobId});

  @override
  ConsumerState<CompleteJobScreen> createState() => _CompleteJobScreenState();
}

class _CompleteJobScreenState extends ConsumerState<CompleteJobScreen> {
  final _formKey = GlobalKey<FormState>();
  final _actualAmountController = TextEditingController();
  final _notesController = TextEditingController();
  final List<String> _completionPhotos = [];
  final List<File> _localPhotos = [];
  final ImagePicker _picker = ImagePicker();
  bool _isSubmitting = false;
  bool _isUploading = false;

  @override
  void dispose() {
    _actualAmountController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final jobAsync = ref.watch(requestDetailProvider(widget.jobId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('إتمام العمل'),
      ),
      body: jobAsync.when(
        data: (job) => _buildContent(context, job),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Text('فشل في تحميل العمل: $error'),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, ServiceRequest job) {
    // Pre-fill with quoted amount
    if (_actualAmountController.text.isEmpty && job.acceptedQuote != null) {
      _actualAmountController.text = job.acceptedQuote!.amount.toInt().toString();
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Job Summary
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      job.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'العميل: ${job.customer.name}',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    Text(
                      'الفئة: ${job.category.nameAr}',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Completion Form
            const Text(
              'تفاصيل الإتمام',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Actual Amount
            TextFormField(
              controller: _actualAmountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'المبلغ الفعلي',
                hintText: 'المبلغ المستحق بعد إتمام العمل',
                prefixIcon: const Icon(Icons.attach_money),
                suffixText: 'ج.م',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                helperText: job.acceptedQuote != null
                    ? 'السعر المتفق عليه: ${job.acceptedQuote!.amount.toInt()} ج.م'
                    : null,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'الرجاء إدخال المبلغ';
                }
                final amount = double.tryParse(value);
                if (amount == null || amount <= 0) {
                  return 'الرجاء إدخال مبلغ صحيح';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Completion Notes
            TextFormField(
              controller: _notesController,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: 'ملاحظات الإتمام',
                hintText: 'اكتب ملخص للعمل المنجز...',
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

            // Completion Photos
            const Text(
              'صور العمل المنجز (اختياري)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 12),
            _buildPhotoSection(),
            const SizedBox(height: 32),

            // Submit Button
            SizedBox(
              width: double.infinity,
              child: LoadingButton(
                text: 'تأكيد إتمام العمل',
                isLoading: _isSubmitting,
                onPressed: () => _completeJob(job),
              ),
            ),
            const SizedBox(height: 16),

            // Warning
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.amber[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.amber[200]!),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.amber[700]),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'سيتم إشعار العميل لتأكيد إتمام العمل وتقييم الخدمة',
                      style: TextStyle(color: Colors.amber[900]),
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

  Widget _buildPhotoSection() {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Add Photo Button
          GestureDetector(
            onTap: _addPhoto,
            child: Container(
              width: 100,
              height: 100,
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!, style: BorderStyle.solid),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_a_photo, color: Colors.grey[600]),
                  const SizedBox(height: 4),
                  Text(
                    'إضافة صورة',
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
          // Photos List
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(8),
              itemCount: _completionPhotos.length,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      margin: const EdgeInsets.only(left: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: NetworkImage(_completionPhotos[index]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 4,
                      right: 4,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _completionPhotos.removeAt(index);
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _addPhoto() async {
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'اختر مصدر الصورة',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('الكاميرا'),
              onTap: () => Navigator.pop(context, ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('معرض الصور'),
              onTap: () => Navigator.pop(context, ImageSource.gallery),
            ),
          ],
        ),
      ),
    );

    if (source == null) return;

    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        imageQuality: 80,
        maxWidth: 1200,
        maxHeight: 1200,
      );

      if (image == null) return;

      setState(() => _isUploading = true);

      // Upload image to server
      final apiClient = ApiClient();
      final response = await apiClient.uploadFile(
        ApiEndpoints.upload,
        image.path,
        'image',
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        final url = response.data['data']['url'] as String?;
        if (url != null) {
          setState(() {
            _completionPhotos.add(url);
            _localPhotos.add(File(image.path));
          });

          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('تم رفع الصورة بنجاح'),
                backgroundColor: Colors.green,
              ),
            );
          }
        }
      } else {
        throw Exception('فشل رفع الصورة');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('فشل في رفع الصورة: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isUploading = false);
      }
    }
  }

  Future<void> _completeJob(ServiceRequest job) async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    try {
      await ref.read(activeJobsNotifierProvider.notifier).updateStatus(
            job.id,
            RequestStatus.completed,
            completionNotes: _notesController.text.isNotEmpty
                ? _notesController.text
                : null,
            actualAmount: double.parse(_actualAmountController.text),
          );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('تم إتمام العمل بنجاح'),
            backgroundColor: Colors.green,
          ),
        );
        // Go back to craftsman home
        context.go('/craftsman');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('فشل في إتمام العمل: $e'),
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
