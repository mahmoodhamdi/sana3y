import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'api_client.dart';
import '../config/constants.dart';
import '../providers/auth_provider.dart';

class UploadService {
  final ApiClient _client;
  final ImagePicker _picker = ImagePicker();

  UploadService(this._client);

  /// Pick image from gallery
  Future<XFile?> pickImage({
    ImageSource source = ImageSource.gallery,
    int imageQuality = 80,
  }) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        imageQuality: imageQuality,
        maxWidth: 1200,
        maxHeight: 1200,
      );
      return image;
    } catch (e) {
      return null;
    }
  }

  /// Pick multiple images from gallery
  Future<List<XFile>> pickMultipleImages({
    int imageQuality = 80,
    int limit = 5,
  }) async {
    try {
      final List<XFile> images = await _picker.pickMultiImage(
        imageQuality: imageQuality,
        maxWidth: 1200,
        maxHeight: 1200,
        limit: limit,
      );
      return images;
    } catch (e) {
      return [];
    }
  }

  /// Upload a single image to server
  Future<String?> uploadImage(XFile image, {String? folder}) async {
    try {
      final response = await _client.uploadFile(
        ApiEndpoints.upload,
        image.path,
        'image',
        data: folder != null ? {'folder': folder} : null,
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        return response.data['data']['url'] as String?;
      }
    } catch (e) {
      // Handle error
    }
    return null;
  }

  /// Upload multiple images to server
  Future<List<String>> uploadMultipleImages(
    List<XFile> images, {
    String? folder,
  }) async {
    final List<String> urls = [];

    for (final image in images) {
      final url = await uploadImage(image, folder: folder);
      if (url != null) {
        urls.add(url);
      }
    }

    return urls;
  }

  /// Pick and upload image in one step
  Future<String?> pickAndUploadImage({
    ImageSource source = ImageSource.gallery,
    String? folder,
  }) async {
    final image = await pickImage(source: source);
    if (image == null) return null;
    return uploadImage(image, folder: folder);
  }

  /// Add work photo for craftsman
  Future<String?> addWorkPhoto(XFile image) async {
    try {
      final response = await _client.uploadFile(
        '${ApiEndpoints.craftsmen}/photos',
        image.path,
        'photo',
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        return response.data['data']['url'] as String?;
      }
    } catch (e) {
      // Handle error
    }
    return null;
  }

  /// Remove work photo for craftsman
  Future<bool> removeWorkPhoto(String photoUrl) async {
    try {
      final response = await _client.delete(
        '${ApiEndpoints.craftsmen}/photos',
        queryParameters: {'url': photoUrl},
      );
      return response.statusCode == 200 && response.data['success'] == true;
    } catch (e) {
      return false;
    }
  }
}

// Provider for UploadService
final uploadServiceProvider = Provider<UploadService>((ref) {
  final client = ref.watch(apiClientProvider);
  return UploadService(client);
});
