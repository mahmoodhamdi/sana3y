import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/loading_button.dart';

class AddAddressScreen extends ConsumerStatefulWidget {
  final String? editId;

  const AddAddressScreen({super.key, this.editId});

  @override
  ConsumerState<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends ConsumerState<AddAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  final _addressController = TextEditingController();
  final _landmarkController = TextEditingController();
  String _selectedLabel = 'المنزل';
  String _selectedGovernorate = 'المنوفية';
  String _selectedCity = 'الباجور';
  bool _isDefault = false;
  bool _isSubmitting = false;

  final List<String> _labels = ['المنزل', 'العمل', 'أخرى'];
  final List<String> _governorates = ['المنوفية', 'القاهرة', 'الجيزة', 'الإسكندرية'];
  final Map<String, List<String>> _cities = {
    'المنوفية': ['الباجور', 'شبين الكوم', 'منوف', 'قويسنا', 'أشمون'],
    'القاهرة': ['القاهرة', 'مدينة نصر', 'المعادي', 'حلوان'],
    'الجيزة': ['الجيزة', '6 أكتوبر', 'الشيخ زايد', 'الهرم'],
    'الإسكندرية': ['الإسكندرية', 'برج العرب', 'العجمي'],
  };

  @override
  void dispose() {
    _addressController.dispose();
    _landmarkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.editId != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'تعديل العنوان' : 'إضافة عنوان جديد'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Label Selection
              const Text(
                'نوع العنوان',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                children: _labels.map((label) {
                  final isSelected = _selectedLabel == label;
                  return ChoiceChip(
                    label: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _getIconForLabel(label),
                          size: 18,
                          color: isSelected ? Colors.white : Colors.grey[700],
                        ),
                        const SizedBox(width: 4),
                        Text(label),
                      ],
                    ),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) {
                        setState(() => _selectedLabel = label);
                      }
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),

              // Governorate & City
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedGovernorate,
                      decoration: const InputDecoration(
                        labelText: 'المحافظة',
                        border: OutlineInputBorder(),
                      ),
                      items: _governorates.map((gov) {
                        return DropdownMenuItem(value: gov, child: Text(gov));
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedGovernorate = value!;
                          _selectedCity = _cities[value]!.first;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedCity,
                      decoration: const InputDecoration(
                        labelText: 'المدينة',
                        border: OutlineInputBorder(),
                      ),
                      items: (_cities[_selectedGovernorate] ?? []).map((city) {
                        return DropdownMenuItem(value: city, child: Text(city));
                      }).toList(),
                      onChanged: (value) {
                        setState(() => _selectedCity = value!);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Address Details
              TextFormField(
                controller: _addressController,
                maxLines: 2,
                decoration: InputDecoration(
                  labelText: 'العنوان التفصيلي',
                  hintText: 'مثال: شارع 15، عمارة 7، شقة 3',
                  prefixIcon: const Icon(Icons.location_on_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء إدخال العنوان';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Landmark
              TextFormField(
                controller: _landmarkController,
                decoration: InputDecoration(
                  labelText: 'علامة مميزة (اختياري)',
                  hintText: 'مثال: بجوار مسجد النور',
                  prefixIcon: const Icon(Icons.place_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Map Placeholder
              Container(
                height: 180,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.map, size: 48, color: Colors.grey[400]),
                          const SizedBox(height: 8),
                          Text(
                            'اضغط لتحديد الموقع على الخريطة',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 8,
                      left: 8,
                      child: ElevatedButton.icon(
                        onPressed: _getCurrentLocation,
                        icon: const Icon(Icons.my_location, size: 18),
                        label: const Text('موقعي الحالي'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Default Checkbox
              CheckboxListTile(
                value: _isDefault,
                onChanged: (value) {
                  setState(() => _isDefault = value ?? false);
                },
                title: const Text('تعيين كعنوان افتراضي'),
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
              ),
              const SizedBox(height: 24),

              // Save Button
              SizedBox(
                width: double.infinity,
                child: LoadingButton(
                  text: isEdit ? 'حفظ التغييرات' : 'حفظ العنوان',
                  isLoading: _isSubmitting,
                  onPressed: _saveAddress,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getIconForLabel(String label) {
    switch (label) {
      case 'المنزل':
        return Icons.home_outlined;
      case 'العمل':
        return Icons.work_outline;
      default:
        return Icons.location_on_outlined;
    }
  }

  void _getCurrentLocation() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('جاري تحديد الموقع...')),
    );
  }

  Future<void> _saveAddress() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('تم حفظ العنوان بنجاح'),
            backgroundColor: Colors.green,
          ),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('فشل في حفظ العنوان: $e'),
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
