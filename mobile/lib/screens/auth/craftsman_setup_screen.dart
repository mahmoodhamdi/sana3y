import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/category_provider.dart';
import '../../services/craftsman_service.dart';
import '../../models/category.dart';
import '../../widgets/loading_button.dart';

final _craftsmanServiceProvider = Provider<CraftsmanService>((ref) {
  final client = ref.watch(apiClientProvider);
  return CraftsmanService(client);
});

class CraftsmanSetupScreen extends ConsumerStatefulWidget {
  const CraftsmanSetupScreen({super.key});

  @override
  ConsumerState<CraftsmanSetupScreen> createState() =>
      _CraftsmanSetupScreenState();
}

class _CraftsmanSetupScreenState extends ConsumerState<CraftsmanSetupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _bioController = TextEditingController();
  final _experienceController = TextEditingController();

  String? _selectedCategoryId;
  final List<String> _selectedSubcategories = [];
  bool _isSubmitting = false;

  @override
  void dispose() {
    _bioController.dispose();
    _experienceController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedCategoryId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('الرجاء اختيار التخصص'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      final craftsmanService = ref.read(_craftsmanServiceProvider);
      await craftsmanService.updateProfile({
        'services': [
          {
            'categoryId': _selectedCategoryId,
            'subcategories': _selectedSubcategories,
            'experience': int.tryParse(_experienceController.text) ?? 1,
          }
        ],
        'bio': _bioController.text.trim(),
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('تم حفظ البيانات بنجاح'),
            backgroundColor: Colors.green,
          ),
        );
        context.go('/');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString().replaceAll('Exception: ', '')),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final categoriesAsync = ref.watch(activeCategoriesProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('إكمال البيانات'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: categoriesAsync.when(
        data: (categories) => _buildForm(categories, theme),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
                const SizedBox(height: 16),
                Text(
                  'فشل في تحميل التخصصات',
                  style: theme.textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  error.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[600]),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () => ref.invalidate(activeCategoriesProvider),
                  icon: const Icon(Icons.refresh),
                  label: const Text('إعادة المحاولة'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildForm(List<Category> categories, ThemeData theme) {
    final selectedCategory = _selectedCategoryId != null
        ? categories.firstWhere(
            (c) => c.id == _selectedCategoryId,
            orElse: () => categories.first,
          )
        : null;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Header
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.handyman,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'مرحباً بك كصنايعي!',
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'أكمل بياناتك للبدء في تلقي الطلبات',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Category Selection
            Text(
              'التخصص الرئيسي *',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'اختر التخصص الذي تجيده',
              style: TextStyle(color: Colors.grey[600], fontSize: 13),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              initialValue: _selectedCategoryId,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: 'اختر تخصصك',
                prefixIcon: const Icon(Icons.category_outlined),
              ),
              items: categories.map((category) {
                return DropdownMenuItem(
                  value: category.id,
                  child: Row(
                    children: [
                      if (category.icon != null)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Image.network(
                            category.icon!,
                            width: 24,
                            height: 24,
                            errorBuilder: (_, __, ___) =>
                                const Icon(Icons.category, size: 24),
                          ),
                        )
                      else
                        const Icon(Icons.category, size: 24),
                      const SizedBox(width: 12),
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
            const SizedBox(height: 24),

            // Subcategories
            if (selectedCategory != null &&
                selectedCategory.subcategories.isNotEmpty) ...[
              Text(
                'التخصصات الفرعية',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'اختر الخدمات التي تقدمها (اختياري)',
                style: TextStyle(color: Colors.grey[600], fontSize: 13),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: selectedCategory.subcategories.map((sub) {
                  final isSelected = _selectedSubcategories.contains(sub.id);
                  return FilterChip(
                    label: Text(sub.nameAr),
                    selected: isSelected,
                    selectedColor:
                        theme.colorScheme.primary.withValues(alpha: 0.2),
                    checkmarkColor: theme.colorScheme.primary,
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
              const SizedBox(height: 24),
            ],

            // Experience
            Text(
              'سنوات الخبرة',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _experienceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: 'مثال: 5',
                prefixIcon: const Icon(Icons.work_history_outlined),
                suffixText: 'سنة',
              ),
              validator: (value) {
                if (value != null && value.isNotEmpty) {
                  final years = int.tryParse(value);
                  if (years == null || years < 0 || years > 50) {
                    return 'الرجاء إدخال رقم صحيح';
                  }
                }
                return null;
              },
            ),
            const SizedBox(height: 24),

            // Bio
            Text(
              'نبذة عنك',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'اكتب نبذة قصيرة عن خبراتك وخدماتك',
              style: TextStyle(color: Colors.grey[600], fontSize: 13),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _bioController,
              maxLines: 4,
              maxLength: 500,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: 'مثال: صنايعي محترف مع خبرة في...',
                alignLabelWithHint: true,
              ),
            ),
            const SizedBox(height: 32),

            // Submit Button
            LoadingButton(
              text: 'حفظ والمتابعة',
              onPressed: _submit,
              isLoading: _isSubmitting,
            ),
            const SizedBox(height: 16),

            // Skip Button
            Center(
              child: TextButton(
                onPressed: _isSubmitting ? null : () => context.go('/'),
                child: Text(
                  'تخطي الآن',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
