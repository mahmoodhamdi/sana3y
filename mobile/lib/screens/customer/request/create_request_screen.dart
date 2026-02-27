import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../models/category.dart';
import '../../../models/request.dart';
import '../../../providers/category_provider.dart';
import '../../../providers/request_provider.dart';

class CreateRequestScreen extends ConsumerStatefulWidget {
  final String? categoryId;

  const CreateRequestScreen({super.key, this.categoryId});

  @override
  ConsumerState<CreateRequestScreen> createState() => _CreateRequestScreenState();
}

class _CreateRequestScreenState extends ConsumerState<CreateRequestScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _addressController = TextEditingController();

  Category? _selectedCategory;
  SubCategory? _selectedSubcategory;
  RequestUrgency _urgency = RequestUrgency.normal;
  DateTime? _preferredDate;
  TimeOfDay? _preferredTimeStart;
  TimeOfDay? _preferredTimeEnd;
  double? _budgetMin;
  double? _budgetMax;
  final List<String> _images = [];
  bool _isSubmitting = false;
  int _currentStep = 0;

  // Location (will be fetched from device later)
  final double _latitude = 30.0444;  // Cairo default
  final double _longitude = 31.2357;
  String _governorate = 'القاهرة';
  String _city = 'القاهرة';

  @override
  void initState() {
    super.initState();
    if (widget.categoryId != null) {
      _loadCategory();
    }
    // Add listeners to update button state when text changes
    _titleController.addListener(_onTextChanged);
    _descriptionController.addListener(_onTextChanged);
    _addressController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    setState(() {});
  }

  void _loadCategory() {
    final categories = ref.read(activeCategoriesProvider).valueOrNull ?? [];
    _selectedCategory = categories.where((c) => c.id == widget.categoryId).firstOrNull;
  }

  @override
  void dispose() {
    _titleController.removeListener(_onTextChanged);
    _descriptionController.removeListener(_onTextChanged);
    _addressController.removeListener(_onTextChanged);
    _titleController.dispose();
    _descriptionController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  bool _canContinueStep(int step) {
    switch (step) {
      case 0:
        return _selectedCategory != null;
      case 1:
        // Title >= 3 chars and description >= 10 chars
        return _titleController.text.trim().length >= 3 &&
            _descriptionController.text.trim().length >= 10;
      case 2:
        return _addressController.text.trim().isNotEmpty;
      case 3:
        return true;
      default:
        return false;
    }
  }

  void _onStepContinue() {
    if (_canContinueStep(_currentStep)) {
      if (_currentStep < 3) {
        setState(() => _currentStep++);
      }
    }
  }

  void _onStepCancel() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
    }
  }

  @override
  Widget build(BuildContext context) {
    final categoriesAsync = ref.watch(activeCategoriesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('طلب خدمة جديد'),
      ),
      body: Form(
        key: _formKey,
        child: Stepper(
          type: StepperType.vertical,
          currentStep: _currentStep,
          onStepContinue: _onStepContinue,
          onStepCancel: _onStepCancel,
          onStepTapped: (step) {
            if (step < _currentStep) {
              setState(() => _currentStep = step);
            }
          },
          controlsBuilder: (context, details) {
            final canContinue = _canContinueStep(details.currentStep);
            return Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Row(
                children: [
                  if (details.currentStep > 0)
                    TextButton(
                      onPressed: details.onStepCancel,
                      child: const Text('السابق'),
                    ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: details.currentStep == 3
                        ? (_isSubmitting ? null : _submitRequest)
                        : (canContinue ? details.onStepContinue : null),
                    child: Text(
                      details.currentStep == 3
                          ? (_isSubmitting ? 'جاري الإرسال...' : 'إرسال الطلب')
                          : 'التالي',
                    ),
                  ),
                ],
              ),
            );
          },
          steps: [
            // Step 1: Select Category
            Step(
              title: const Text('اختر الخدمة'),
              content: categoriesAsync.when(
                data: (categories) => _buildCategoryStep(categories),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (_, __) => const Text('فشل في تحميل الخدمات'),
              ),
              isActive: _currentStep >= 0,
              state: _currentStep > 0 ? StepState.complete : StepState.indexed,
            ),

            // Step 2: Request Details
            Step(
              title: const Text('تفاصيل الطلب'),
              content: _buildDetailsStep(),
              isActive: _currentStep >= 1,
              state: _currentStep > 1 ? StepState.complete : StepState.indexed,
            ),

            // Step 3: Location & Time
            Step(
              title: const Text('الموقع والوقت'),
              content: _buildLocationStep(),
              isActive: _currentStep >= 2,
              state: _currentStep > 2 ? StepState.complete : StepState.indexed,
            ),

            // Step 4: Review
            Step(
              title: const Text('مراجعة الطلب'),
              content: _buildReviewStep(),
              isActive: _currentStep >= 3,
              state: _currentStep == 3 ? StepState.indexed : StepState.indexed,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryStep(List<Category> categories) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'ما نوع الخدمة التي تحتاجها؟',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: categories.map((category) {
            final isSelected = _selectedCategory?.id == category.id;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedCategory = category;
                  _selectedSubcategory = null;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Theme.of(context).primaryColor
                      : Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected
                        ? Theme.of(context).primaryColor
                        : Colors.grey[300]!,
                    width: 2,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
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
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
        if (_selectedCategory != null &&
            _selectedCategory!.subcategories.isNotEmpty) ...[
          const SizedBox(height: 24),
          const Text(
            'اختر التخصص (اختياري)',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _selectedCategory!.subcategories.map((sub) {
              final isSelected = _selectedSubcategory?.id == sub.id;
              return ChoiceChip(
                label: Text(sub.nameAr),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    _selectedSubcategory = selected ? sub : null;
                  });
                },
              );
            }).toList(),
          ),
        ],
      ],
    );
  }

  Widget _buildDetailsStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: _titleController,
          decoration: const InputDecoration(
            labelText: 'عنوان الطلب *',
            hintText: 'مثال: إصلاح تسريب مياه',
            helperText: '3 أحرف على الأقل',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.trim().length < 3) {
              return 'العنوان يجب أن يكون 3 أحرف على الأقل';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _descriptionController,
          maxLines: 4,
          decoration: const InputDecoration(
            labelText: 'وصف المشكلة *',
            hintText: 'اشرح المشكلة بالتفصيل...',
            helperText: '10 أحرف على الأقل',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.trim().length < 10) {
              return 'الوصف يجب أن يكون 10 أحرف على الأقل';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        const Text('مستوى الأهمية', style: TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        SegmentedButton<RequestUrgency>(
          segments: const [
            ButtonSegment(
              value: RequestUrgency.normal,
              label: Text('عادي'),
              icon: Icon(Icons.schedule),
            ),
            ButtonSegment(
              value: RequestUrgency.urgent,
              label: Text('مستعجل'),
              icon: Icon(Icons.priority_high),
            ),
            ButtonSegment(
              value: RequestUrgency.emergency,
              label: Text('طوارئ'),
              icon: Icon(Icons.warning),
            ),
          ],
          selected: {_urgency},
          onSelectionChanged: (value) {
            setState(() {
              _urgency = value.first;
            });
          },
        ),
        const SizedBox(height: 16),
        const Text('الميزانية المتوقعة (اختياري)',
            style: TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'من',
                  suffixText: 'ج.م',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  _budgetMin = double.tryParse(value);
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'إلى',
                  suffixText: 'ج.م',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  _budgetMax = double.tryParse(value);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLocationStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: _addressController,
          maxLines: 2,
          decoration: const InputDecoration(
            labelText: 'العنوان التفصيلي',
            hintText: 'مثال: شارع 15، بجوار مسجد النور',
            prefixIcon: Icon(Icons.location_on),
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'العنوان مطلوب';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<String>(
                initialValue: _governorate,
                decoration: const InputDecoration(
                  labelText: 'المحافظة',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: 'القاهرة', child: Text('القاهرة')),
                  DropdownMenuItem(value: 'الجيزة', child: Text('الجيزة')),
                  DropdownMenuItem(value: 'الإسكندرية', child: Text('الإسكندرية')),
                ],
                onChanged: (value) {
                  setState(() {
                    _governorate = value ?? 'القاهرة';
                  });
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: DropdownButtonFormField<String>(
                initialValue: _city,
                decoration: const InputDecoration(
                  labelText: 'المدينة',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: 'القاهرة', child: Text('القاهرة')),
                  DropdownMenuItem(value: 'مدينة نصر', child: Text('مدينة نصر')),
                  DropdownMenuItem(value: 'المعادي', child: Text('المعادي')),
                ],
                onChanged: (value) {
                  setState(() {
                    _city = value ?? 'القاهرة';
                  });
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        const Text('الموعد المفضل (اختياري)',
            style: TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const Icon(Icons.calendar_today),
          title: Text(
            _preferredDate != null
                ? '${_preferredDate!.day}/${_preferredDate!.month}/${_preferredDate!.year}'
                : 'اختر التاريخ',
          ),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: DateTime.now().add(const Duration(days: 1)),
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 30)),
            );
            if (date != null) {
              setState(() => _preferredDate = date);
            }
          },
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const Icon(Icons.access_time),
          title: Text(
            _preferredTimeStart != null && _preferredTimeEnd != null
                ? 'من ${_preferredTimeStart!.format(context)} إلى ${_preferredTimeEnd!.format(context)}'
                : 'اختر الوقت',
          ),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () async {
            final start = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            );
            if (start != null) {
              final end = await showTimePicker(
                context: context,
                initialTime: start.replacing(hour: start.hour + 2),
              );
              if (end != null) {
                setState(() {
                  _preferredTimeStart = start;
                  _preferredTimeEnd = end;
                });
              }
            }
          },
        ),
      ],
    );
  }

  Widget _buildReviewStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ReviewItem(
          label: 'الخدمة',
          value: _selectedCategory?.nameAr ?? '-',
        ),
        if (_selectedSubcategory != null)
          _ReviewItem(
            label: 'التخصص',
            value: _selectedSubcategory!.nameAr,
          ),
        _ReviewItem(
          label: 'عنوان الطلب',
          value: _titleController.text,
        ),
        _ReviewItem(
          label: 'الوصف',
          value: _descriptionController.text,
        ),
        _ReviewItem(
          label: 'الأهمية',
          value: _urgency == RequestUrgency.normal
              ? 'عادي'
              : _urgency == RequestUrgency.urgent
                  ? 'مستعجل'
                  : 'طوارئ',
        ),
        _ReviewItem(
          label: 'الموقع',
          value: '${_addressController.text}\n$_city، $_governorate',
        ),
        if (_preferredDate != null)
          _ReviewItem(
            label: 'الموعد',
            value:
                '${_preferredDate!.day}/${_preferredDate!.month}/${_preferredDate!.year}',
          ),
        if (_budgetMin != null && _budgetMax != null)
          _ReviewItem(
            label: 'الميزانية',
            value: '${_budgetMin!.toInt()} - ${_budgetMax!.toInt()} ج.م',
          ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: Colors.blue[700]),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'سيتم إرسال طلبك للصنايعية المتخصصين في منطقتك',
                  style: TextStyle(color: Colors.blue[700]),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _submitRequest() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('الرجاء اختيار نوع الخدمة')),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      final data = CreateRequestData(
        title: _titleController.text,
        description: _descriptionController.text,
        category: _selectedCategory!.id,
        subcategory: _selectedSubcategory?.id,
        location: RequestLocation(
          address: _addressController.text,
          coordinates: [_longitude, _latitude],
          governorate: _governorate,
          city: _city,
        ),
        preferredDate: _preferredDate,
        preferredTime: _preferredTimeStart != null && _preferredTimeEnd != null
            ? PreferredTime(
                start:
                    '${_preferredTimeStart!.hour.toString().padLeft(2, '0')}:${_preferredTimeStart!.minute.toString().padLeft(2, '0')}',
                end:
                    '${_preferredTimeEnd!.hour.toString().padLeft(2, '0')}:${_preferredTimeEnd!.minute.toString().padLeft(2, '0')}',
              )
            : null,
        images: _images,
        budget: _budgetMin != null && _budgetMax != null
            ? RequestBudget(min: _budgetMin!, max: _budgetMax!)
            : null,
        urgency: _urgency,
      );

      final request =
          await ref.read(customerRequestsNotifierProvider.notifier).createRequest(data);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تم إرسال الطلب بنجاح')),
        );
        context.pop();
        // Navigate to request tracking
        context.push('/request/${request.id}');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('فشل في إرسال الطلب: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }
}

class _ReviewItem extends StatelessWidget {
  final String label;
  final String value;

  const _ReviewItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
            ),
          ),
          Expanded(
            child: Text(value, style: const TextStyle(fontSize: 14)),
          ),
        ],
      ),
    );
  }
}
