import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../models/category.dart';
import '../../models/craftsman.dart';
import '../../providers/category_provider.dart';
import '../../providers/craftsman_provider.dart';
import '../../widgets/craftsman_card.dart';

class CategoryCraftsmenScreen extends ConsumerStatefulWidget {
  final String categoryId;

  const CategoryCraftsmenScreen({
    super.key,
    required this.categoryId,
  });

  @override
  ConsumerState<CategoryCraftsmenScreen> createState() =>
      _CategoryCraftsmenScreenState();
}

class _CategoryCraftsmenScreenState
    extends ConsumerState<CategoryCraftsmenScreen> {
  final ScrollController _scrollController = ScrollController();
  String _sortBy = 'rating';
  double? _minRating;
  String? _selectedSubcategory;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _loadCraftsmen();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(craftsmanListProvider.notifier).loadMore();
    }
  }

  void _loadCraftsmen({bool refresh = false}) {
    ref.read(craftsmanListProvider.notifier).loadCraftsmen(
          categoryId: widget.categoryId,
          refresh: refresh,
        );
  }

  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => _FilterSheet(
        sortBy: _sortBy,
        minRating: _minRating,
        selectedSubcategory: _selectedSubcategory,
        categoryId: widget.categoryId,
        onApply: (sortBy, minRating, subcategory) {
          setState(() {
            _sortBy = sortBy;
            _minRating = minRating;
            _selectedSubcategory = subcategory;
          });
          _loadCraftsmen(refresh: true);
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final categoryAsync = ref.watch(categoryByIdProvider(widget.categoryId));
    final craftsmenAsync = ref.watch(craftsmanListProvider);

    return Scaffold(
      appBar: AppBar(
        title: categoryAsync.when(
          data: (category) => Text(category?.nameAr ?? 'الصنايعية'),
          loading: () => const Text('جارِ التحميل...'),
          error: (_, __) => const Text('الصنايعية'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterSheet,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _loadCraftsmen(refresh: true);
        },
        child: craftsmenAsync.when(
          data: (craftsmen) {
            if (craftsmen.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.search_off,
                      size: 64,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'لا يوجد صنايعية في هذه الفئة حالياً',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: () => _loadCraftsmen(refresh: true),
                      child: const Text('إعادة المحاولة'),
                    ),
                  ],
                ),
              );
            }

            return ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: craftsmen.length + 1,
              itemBuilder: (context, index) {
                if (index == craftsmen.length) {
                  final hasMore =
                      ref.read(craftsmanListProvider.notifier).hasMore;
                  if (hasMore) {
                    return const Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  return const SizedBox.shrink();
                }

                final craftsman = craftsmen[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: CraftsmanListTile(
                    craftsman: craftsman,
                    showDistance: true,
                    onTap: () {
                      context.push('/craftsman/${craftsman.id}');
                    },
                  ),
                );
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 48, color: Colors.red),
                const SizedBox(height: 16),
                const Text('فشل في تحميل الصنايعية'),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () => _loadCraftsmen(refresh: true),
                  child: const Text('إعادة المحاولة'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FilterSheet extends ConsumerWidget {
  final String sortBy;
  final double? minRating;
  final String? selectedSubcategory;
  final String categoryId;
  final Function(String, double?, String?) onApply;

  const _FilterSheet({
    required this.sortBy,
    this.minRating,
    this.selectedSubcategory,
    required this.categoryId,
    required this.onApply,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoryAsync = ref.watch(categoryByIdProvider(categoryId));

    String currentSortBy = sortBy;
    double? currentMinRating = minRating;
    String? currentSubcategory = selectedSubcategory;

    return StatefulBuilder(
      builder: (context, setState) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'تصفية وترتيب',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Sort options
              const Text(
                'ترتيب حسب',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: [
                  _buildSortChip(
                    'التقييم',
                    'rating',
                    currentSortBy,
                    (value) => setState(() => currentSortBy = value),
                  ),
                  _buildSortChip(
                    'عدد الأعمال',
                    'completedJobs',
                    currentSortBy,
                    (value) => setState(() => currentSortBy = value),
                  ),
                  _buildSortChip(
                    'سرعة الرد',
                    'responseTime',
                    currentSortBy,
                    (value) => setState(() => currentSortBy = value),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Rating filter
              const Text(
                'الحد الأدنى للتقييم',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: [
                  _buildRatingChip(null, currentMinRating,
                      (value) => setState(() => currentMinRating = value)),
                  _buildRatingChip(3.0, currentMinRating,
                      (value) => setState(() => currentMinRating = value)),
                  _buildRatingChip(4.0, currentMinRating,
                      (value) => setState(() => currentMinRating = value)),
                  _buildRatingChip(4.5, currentMinRating,
                      (value) => setState(() => currentMinRating = value)),
                ],
              ),

              const SizedBox(height: 20),

              // Subcategories
              categoryAsync.when(
                data: (category) {
                  if (category == null ||
                      category.subcategories.isEmpty) {
                    return const SizedBox.shrink();
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'الخدمة',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          _buildSubcategoryChip(
                            null,
                            'الكل',
                            currentSubcategory,
                            (value) =>
                                setState(() => currentSubcategory = value),
                          ),
                          ...category.subcategories.map((sub) {
                            return _buildSubcategoryChip(
                              sub.name,
                              sub.nameAr,
                              currentSubcategory,
                              (value) =>
                                  setState(() => currentSubcategory = value),
                            );
                          }),
                        ],
                      ),
                    ],
                  );
                },
                loading: () => const SizedBox.shrink(),
                error: (_, __) => const SizedBox.shrink(),
              ),

              const SizedBox(height: 24),

              // Apply button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    onApply(currentSortBy, currentMinRating, currentSubcategory);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text('تطبيق'),
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSortChip(
    String label,
    String value,
    String current,
    Function(String) onSelect,
  ) {
    final isSelected = current == value;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) => onSelect(value),
    );
  }

  Widget _buildRatingChip(
    double? value,
    double? current,
    Function(double?) onSelect,
  ) {
    final isSelected = current == value;
    final label = value == null ? 'الكل' : '${value.toStringAsFixed(1)}+';
    return ChoiceChip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (value != null)
            const Icon(Icons.star, size: 14, color: Colors.amber),
          if (value != null) const SizedBox(width: 4),
          Text(label),
        ],
      ),
      selected: isSelected,
      onSelected: (_) => onSelect(value),
    );
  }

  Widget _buildSubcategoryChip(
    String? value,
    String label,
    String? current,
    Function(String?) onSelect,
  ) {
    final isSelected = current == value;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) => onSelect(value),
    );
  }
}
