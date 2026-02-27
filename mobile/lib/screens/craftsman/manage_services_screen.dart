import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/category_provider.dart';
import '../../providers/craftsman_provider.dart';
import '../../models/category.dart';

class ManageServicesScreen extends ConsumerStatefulWidget {
  const ManageServicesScreen({super.key});

  @override
  ConsumerState<ManageServicesScreen> createState() => _ManageServicesScreenState();
}

class _ManageServicesScreenState extends ConsumerState<ManageServicesScreen> {
  final Map<String, bool> _selectedCategories = {};
  final Map<String, List<String>> _selectedSubcategories = {};
  final Map<String, TextEditingController> _experienceControllers = {};
  final Map<String, String> _priceTypes = {};
  final Map<String, TextEditingController> _basePriceControllers = {};
  bool _isSaving = false;

  @override
  void dispose() {
    for (var controller in _experienceControllers.values) {
      controller.dispose();
    }
    for (var controller in _basePriceControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categoriesAsync = ref.watch(activeCategoriesProvider);
    // Profile is used to pre-populate saved services
  // ignore: unused_local_variable
  final profileAsync = ref.watch(myCraftsmanProfileProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('إدارة الخدمات'),
        actions: [
          IconButton(
            icon: _isSaving
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.save),
            onPressed: _isSaving ? null : _saveServices,
          ),
        ],
      ),
      body: categoriesAsync.when(
        data: (categories) => _buildContent(categories),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text('فشل في تحميل الخدمات: $error'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(List<Category> categories) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'اختر الخدمات التي تقدمها',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          'يمكنك اختيار أكثر من خدمة وتحديد تفاصيل كل خدمة',
          style: TextStyle(color: Colors.grey[600]),
        ),
        const SizedBox(height: 24),
        ...categories.map((category) => _ServiceCard(
              category: category,
              isSelected: _selectedCategories[category.id] ?? false,
              selectedSubcategories: _selectedSubcategories[category.id] ?? [],
              experienceController: _experienceControllers.putIfAbsent(
                category.id,
                () => TextEditingController(),
              ),
              priceType: _priceTypes[category.id] ?? 'quote',
              basePriceController: _basePriceControllers.putIfAbsent(
                category.id,
                () => TextEditingController(),
              ),
              onSelectionChanged: (selected) {
                setState(() {
                  _selectedCategories[category.id] = selected;
                  if (!selected) {
                    _selectedSubcategories.remove(category.id);
                  }
                });
              },
              onSubcategoryChanged: (subcategories) {
                setState(() {
                  _selectedSubcategories[category.id] = subcategories;
                });
              },
              onPriceTypeChanged: (type) {
                setState(() {
                  _priceTypes[category.id] = type;
                });
              },
            )),
      ],
    );
  }

  Future<void> _saveServices() async {
    final selectedServices = _selectedCategories.entries
        .where((e) => e.value)
        .map((e) => e.key)
        .toList();

    if (selectedServices.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('الرجاء اختيار خدمة واحدة على الأقل')),
      );
      return;
    }

    setState(() => _isSaving = true);

    try {
      // Build services data
      final services = selectedServices.map((categoryId) {
        return {
          'categoryId': categoryId,
          'subcategories': _selectedSubcategories[categoryId] ?? [],
          'experience': int.tryParse(_experienceControllers[categoryId]?.text ?? '') ?? 0,
          'priceType': _priceTypes[categoryId] ?? 'quote',
          'basePrice': double.tryParse(_basePriceControllers[categoryId]?.text ?? ''),
        };
      }).toList();

      // Save via provider - update profile with new services
      await ref.read(craftsmanServiceProvider).updateProfile({'services': services});

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('تم حفظ الخدمات بنجاح'),
            backgroundColor: Colors.green,
          ),
        );
        ref.invalidate(myCraftsmanProfileProvider);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('فشل في حفظ الخدمات: $e'),
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

class _ServiceCard extends StatelessWidget {
  final Category category;
  final bool isSelected;
  final List<String> selectedSubcategories;
  final TextEditingController experienceController;
  final String priceType;
  final TextEditingController basePriceController;
  final ValueChanged<bool> onSelectionChanged;
  final ValueChanged<List<String>> onSubcategoryChanged;
  final ValueChanged<String> onPriceTypeChanged;

  const _ServiceCard({
    required this.category,
    required this.isSelected,
    required this.selectedSubcategories,
    required this.experienceController,
    required this.priceType,
    required this.basePriceController,
    required this.onSelectionChanged,
    required this.onSubcategoryChanged,
    required this.onPriceTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          // Header
          CheckboxListTile(
            value: isSelected,
            onChanged: (value) => onSelectionChanged(value ?? false),
            title: Row(
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
                Text(
                  category.nameAr,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            secondary: isSelected
                ? const Icon(Icons.check_circle, color: Colors.green)
                : null,
          ),

          // Details (when selected)
          if (isSelected) ...[
            const Divider(height: 0),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Subcategories
                  if (category.subcategories.isNotEmpty) ...[
                    const Text(
                      'التخصصات',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: category.subcategories.map((sub) {
                        final isSubSelected = selectedSubcategories.contains(sub.id);
                        return FilterChip(
                          label: Text(sub.nameAr),
                          selected: isSubSelected,
                          onSelected: (selected) {
                            final newList = List<String>.from(selectedSubcategories);
                            if (selected) {
                              newList.add(sub.id);
                            } else {
                              newList.remove(sub.id);
                            }
                            onSubcategoryChanged(newList);
                          },
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16),
                  ],

                  // Experience
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: experienceController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'سنوات الخبرة',
                            border: OutlineInputBorder(),
                            suffixText: 'سنة',
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          initialValue: priceType,
                          decoration: const InputDecoration(
                            labelText: 'نوع التسعير',
                            border: OutlineInputBorder(),
                          ),
                          items: const [
                            DropdownMenuItem(
                              value: 'quote',
                              child: Text('حسب الطلب'),
                            ),
                            DropdownMenuItem(
                              value: 'fixed',
                              child: Text('سعر ثابت'),
                            ),
                            DropdownMenuItem(
                              value: 'hourly',
                              child: Text('بالساعة'),
                            ),
                          ],
                          onChanged: (value) => onPriceTypeChanged(value!),
                        ),
                      ),
                    ],
                  ),

                  // Base Price (if fixed or hourly)
                  if (priceType != 'quote') ...[
                    const SizedBox(height: 16),
                    TextField(
                      controller: basePriceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: priceType == 'hourly' ? 'السعر بالساعة' : 'السعر الأساسي',
                        border: const OutlineInputBorder(),
                        suffixText: 'ج.م',
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
