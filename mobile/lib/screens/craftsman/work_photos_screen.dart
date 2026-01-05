import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../../providers/craftsman_provider.dart';
import '../../services/api_client.dart';
import '../../config/constants.dart';

class WorkPhotosScreen extends ConsumerStatefulWidget {
  const WorkPhotosScreen({super.key});

  @override
  ConsumerState<WorkPhotosScreen> createState() => _WorkPhotosScreenState();
}

class _WorkPhotosScreenState extends ConsumerState<WorkPhotosScreen> {
  final List<String> _photos = [];
  final ImagePicker _picker = ImagePicker();
  bool _isUploading = false;

  @override
  void initState() {
    super.initState();
    _loadExistingPhotos();
  }

  void _loadExistingPhotos() {
    final profileAsync = ref.read(myCraftsmanProfileProvider);
    profileAsync.whenData((profile) {
      final photos = profile?.workPhotos;
      if (photos != null && photos.isNotEmpty) {
        setState(() {
          _photos.addAll(photos);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('معرض الأعمال'),
        actions: [
          IconButton(
            icon: _isUploading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.add_photo_alternate),
            onPressed: _isUploading ? null : _addPhoto,
          ),
        ],
      ),
      body: _photos.isEmpty ? _buildEmptyState() : _buildPhotoGrid(),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.photo_library, size: 80, color: Colors.grey[300]),
          const SizedBox(height: 16),
          const Text(
            'لا توجد صور أعمال',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'أضف صور أعمالك السابقة لجذب المزيد من العملاء',
            style: TextStyle(color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _addPhoto,
            icon: const Icon(Icons.add_photo_alternate),
            label: const Text('إضافة صورة'),
          ),
        ],
      ),
    );
  }

  Widget _buildPhotoGrid() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'صور الأعمال (${_photos.length}/20)',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'أضف صور أعمالك السابقة لإظهار مهاراتك للعملاء',
            style: TextStyle(color: Colors.grey[600]),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: _photos.length + 1,
              itemBuilder: (context, index) {
                if (index == _photos.length) {
                  return _buildAddPhotoCard();
                }
                return _buildPhotoCard(_photos[index], index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddPhotoCard() {
    return InkWell(
      onTap: _photos.length < 20 ? _addPhoto : null,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(8),
        ),
        child: _photos.length < 20
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add, size: 32, color: Colors.grey[400]),
                  const SizedBox(height: 4),
                  Text(
                    'إضافة',
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.block, size: 32, color: Colors.grey[400]),
                  const SizedBox(height: 4),
                  Text(
                    'الحد الأقصى',
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildPhotoCard(String photoUrl, int index) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            photoUrl,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            errorBuilder: (_, __, ___) => Container(
              color: Colors.grey[200],
              child: const Icon(Icons.broken_image, color: Colors.grey),
            ),
          ),
        ),
        Positioned(
          top: 4,
          left: 4,
          child: InkWell(
            onTap: () => _deletePhoto(index),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close, color: Colors.white, size: 16),
            ),
          ),
        ),
      ],
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
        '${ApiEndpoints.craftsmen}/photos',
        image.path,
        'photo',
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        final url = response.data['data']['url'] as String?;
        if (url != null) {
          setState(() {
            _photos.add(url);
          });

          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('تم إضافة الصورة بنجاح'),
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

  Future<void> _deletePhoto(int index) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('حذف الصورة'),
        content: const Text('هل أنت متأكد من حذف هذه الصورة؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('حذف', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        final photoUrl = _photos[index];
        final apiClient = ApiClient();
        final response = await apiClient.delete(
          '${ApiEndpoints.craftsmen}/photos',
          queryParameters: {'url': photoUrl},
        );

        if (response.statusCode == 200 && response.data['success'] == true) {
          setState(() {
            _photos.removeAt(index);
          });

          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('تم حذف الصورة')),
            );
          }
        } else {
          throw Exception('فشل حذف الصورة');
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('فشل في حذف الصورة: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }
}
