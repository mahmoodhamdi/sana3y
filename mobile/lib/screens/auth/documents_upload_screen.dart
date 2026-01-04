import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/loading_button.dart';

class DocumentsUploadScreen extends ConsumerStatefulWidget {
  final Map<String, dynamic>? registrationData;

  const DocumentsUploadScreen({super.key, this.registrationData});

  @override
  ConsumerState<DocumentsUploadScreen> createState() => _DocumentsUploadScreenState();
}

class _DocumentsUploadScreenState extends ConsumerState<DocumentsUploadScreen> {
  bool _idFrontUploaded = false;
  bool _idBackUploaded = false;
  bool _profilePhotoUploaded = false;
  bool _isSubmitting = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('رفع الوثائق'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            const Text(
              'رفع الوثائق المطلوبة',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'الرجاء رفع صور واضحة للوثائق التالية',
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 24),

            // ID Card Front
            _DocumentCard(
              title: 'البطاقة الشخصية (الوجه الأمامي)',
              icon: Icons.credit_card,
              isUploaded: _idFrontUploaded,
              onUpload: () => _uploadDocument('id_front'),
            ),
            const SizedBox(height: 16),

            // ID Card Back
            _DocumentCard(
              title: 'البطاقة الشخصية (الوجه الخلفي)',
              icon: Icons.credit_card,
              isUploaded: _idBackUploaded,
              onUpload: () => _uploadDocument('id_back'),
            ),
            const SizedBox(height: 16),

            // Profile Photo
            _DocumentCard(
              title: 'صورة شخصية حديثة',
              icon: Icons.person,
              isUploaded: _profilePhotoUploaded,
              onUpload: () => _uploadDocument('profile'),
            ),
            const SizedBox(height: 32),

            // Requirements Info
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.orange[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.orange[200]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.warning_amber, color: Colors.orange[700]),
                      const SizedBox(width: 8),
                      Text(
                        'متطلبات الصور',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.orange[700],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _RequirementItem(text: 'يجب أن تكون الصور واضحة وغير مقطوعة'),
                  _RequirementItem(text: 'البطاقة الشخصية سارية المفعول'),
                  _RequirementItem(text: 'الصورة الشخصية حديثة ووجه واضح'),
                  _RequirementItem(text: 'حجم الملف لا يتجاوز 5 ميجابايت'),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Submit Button
            SizedBox(
              width: double.infinity,
              child: LoadingButton(
                text: 'إرسال الطلب',
                isLoading: _isSubmitting,
                onPressed: _canSubmit ? _submitApplication : null,
              ),
            ),
            const SizedBox(height: 16),

            if (!_canSubmit)
              Center(
                child: Text(
                  'الرجاء رفع جميع الوثائق المطلوبة',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ),
          ],
        ),
      ),
    );
  }

  bool get _canSubmit => _idFrontUploaded && _idBackUploaded && _profilePhotoUploaded;

  Future<void> _uploadDocument(String type) async {
    // Show image picker options
    final source = await showModalBottomSheet<String>(
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
              onTap: () => Navigator.pop(context, 'camera'),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('معرض الصور'),
              onTap: () => Navigator.pop(context, 'gallery'),
            ),
          ],
        ),
      ),
    );

    if (source == null) return;

    // Simulate upload
    setState(() {
      switch (type) {
        case 'id_front':
          _idFrontUploaded = true;
          break;
        case 'id_back':
          _idBackUploaded = true;
          break;
        case 'profile':
          _profilePhotoUploaded = true;
          break;
      }
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

  Future<void> _submitApplication() async {
    setState(() => _isSubmitting = true);

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        // Show success dialog
        await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: const Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green),
                SizedBox(width: 8),
                Text('تم إرسال الطلب'),
              ],
            ),
            content: const Text(
              'تم إرسال طلب التسجيل بنجاح. سيتم مراجعة طلبك والتواصل معك خلال 24-48 ساعة.',
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  context.go('/');
                },
                child: const Text('موافق'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('فشل في إرسال الطلب: $e'),
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

class _DocumentCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isUploaded;
  final VoidCallback onUpload;

  const _DocumentCard({
    required this.title,
    required this.icon,
    required this.isUploaded,
    required this.onUpload,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onUpload,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isUploaded
                      ? Colors.green[50]
                      : Theme.of(context).primaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  isUploaded ? Icons.check : icon,
                  color: isUploaded ? Colors.green : Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      isUploaded ? 'تم الرفع' : 'اضغط للرفع',
                      style: TextStyle(
                        color: isUploaded ? Colors.green : Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                isUploaded ? Icons.check_circle : Icons.upload,
                color: isUploaded ? Colors.green : Colors.grey[400],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RequirementItem extends StatelessWidget {
  final String text;

  const _RequirementItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('• ', style: TextStyle(color: Colors.orange[700])),
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: Colors.orange[800], fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}
