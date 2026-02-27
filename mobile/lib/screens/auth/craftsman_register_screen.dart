import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/category_provider.dart';
import '../../models/category.dart';
import '../../widgets/loading_button.dart';

class CraftsmanRegisterScreen extends ConsumerStatefulWidget {
  const CraftsmanRegisterScreen({super.key});

  @override
  ConsumerState<CraftsmanRegisterScreen> createState() => _CraftsmanRegisterScreenState();
}

class _CraftsmanRegisterScreenState extends ConsumerState<CraftsmanRegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _bioController = TextEditingController();
  final _experienceController = TextEditingController();
  final _addressController = TextEditingController();

  String? _selectedCategoryId;
  final List<String> _selectedSubcategories = [];
  bool _isSubmitting = false;

  @override
  void dispose() {
    _bioController.dispose();
    _experienceController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categoriesAsync = ref.watch(activeCategoriesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('التسجيل كصنايعي'),
      ),
      body: categoriesAsync.when(
        data: (categories) => _buildForm(categories),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text('فشل في تحميل التخصصات: $error'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.invalidate(activeCategoriesProvider),
                child: const Text('إعادة المحاولة'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForm(List<Category> categories) {
    final selectedCategory = categories.firstWhere(
      (c) => c.id == _selectedCategoryId,
      orElse: () => categories.first,
    );

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            const Text(
              'أكمل بيانات التسجيل',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'أدخل معلوماتك المهنية للتسجيل كصنايعي',
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 24),

            // Category Selection
            const Text(
              'التخصص الرئيسي',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              initialValue: _selectedCategoryId,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'اختر تخصصك',
              ),
              items: categories.map((category) {
                return DropdownMenuItem(
                  value: category.id,
                  child: Row(
                    children: [
                      if (category.icon != null)
                        Image.network(
                          category.icon!,
                          width: 24,
                          height: 24,
                          errorBuilder: (_, __, ___) =>
                              const Icon(Icons.category, size: 24),
                        )
                      else
                        const Icon(Icons.category, size: 24),
                      const SizedBox(width: 8),
                      Text(category.nameAr),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCategoryId = value;
                  _selectedSubcategories.clear();
                });
              },
              validator: (value) {
                if (value == null) return 'الرجاء اختيار التخصص';
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Subcategories
            if (_selectedCategoryId != null && selectedCategory.subcategories.isNotEmpty) ...[
              const Text(
                'التخصصات الفرعية',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: selectedCategory.subcategories.map((sub) {
                  final isSelected = _selectedSubcategories.contains(sub.id);
                  return FilterChip(
                    label: Text(sub.nameAr),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          _selectedSubcategories.add(sub.id);
                        } else {
                          _selectedSubcategories.remove(sub.id);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
            ],

            // Experience
            const Text(
              'سنوات الخبرة',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _experienceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'مثال: 5',
                suffixText: 'سنة',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) return 'الرجاء إدخال سنوات الخبرة';
                if (int.tryParse(value) == null) return 'الرجاء إدخال رقم صحيح';
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Bio
            const Text(
              'نبذة عنك',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _bioController,
              maxLines: 4,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'اكتب نبذة مختصرة عن خبراتك ومهاراتك...',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) return 'الرجاء إدخال نبذة عنك';
                if (value.length < 20) return 'النبذة يجب أن تكون 20 حرف على الأقل';
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Address
            const Text(
              'العنوان',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _addressController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'الباجور، المنوفية',
                prefixIcon: Icon(Icons.location_on_outlined),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) return 'الرجاء إدخال العنوان';
                return null;
              },
            ),
            const SizedBox(height: 32),

            // Submit Button
            SizedBox(
              width: double.infinity,
              child: LoadingButton(
                text: 'متابعة لرفع الوثائق',
                isLoading: _isSubmitting,
                onPressed: _submitForm,
              ),
            ),
            const SizedBox(height: 16),

            // Info Note
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
                      'بعد إكمال التسجيل، سيتم مراجعة طلبك من فريقنا خلال 24-48 ساعة',
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

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    try {
      // Navigate to documents upload screen with data
      if (mounted) {
        context.push(
          '/craftsman/register/documents',
          extra: {
            'categoryId': _selectedCategoryId,
            'subcategories': _selectedSubcategories,
            'experience': int.parse(_experienceController.text),
            'bio': _bioController.text,
            'address': _addressController.text,
          },
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }
}
