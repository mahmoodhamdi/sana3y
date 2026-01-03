import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../models/category.dart';
import '../../models/craftsman.dart';
import '../../providers/category_provider.dart';
import '../../providers/craftsman_provider.dart';
import '../../widgets/category_card.dart';
import '../../widgets/craftsman_card.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  String _searchQuery = '';
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _performSearch(String query) {
    setState(() {
      _searchQuery = query;
      _isSearching = query.isNotEmpty;
    });

    if (query.isNotEmpty) {
      ref.read(craftsmanListProvider.notifier).loadCraftsmen(
            search: query,
            refresh: true,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final categoriesAsync = ref.watch(activeCategoriesProvider);
    final craftsmenAsync = ref.watch(craftsmanListProvider);

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Container(
          margin: const EdgeInsets.only(left: 16),
          child: TextField(
            controller: _searchController,
            focusNode: _focusNode,
            decoration: InputDecoration(
              hintText: 'ابحث عن صنايعي أو خدمة...',
              border: InputBorder.none,
              hintStyle: TextStyle(color: Colors.grey[500]),
              suffixIcon: _searchQuery.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _searchController.clear();
                        setState(() {
                          _searchQuery = '';
                          _isSearching = false;
                        });
                      },
                    )
                  : null,
            ),
            onChanged: (value) {
              if (value.length >= 2) {
                _performSearch(value);
              } else if (value.isEmpty) {
                setState(() {
                  _searchQuery = '';
                  _isSearching = false;
                });
              }
            },
            onSubmitted: _performSearch,
          ),
        ),
      ),
      body: _isSearching
          ? _buildSearchResults(craftsmenAsync)
          : _buildSuggestions(categoriesAsync),
    );
  }

  Widget _buildSuggestions(AsyncValue<List<Category>> categoriesAsync) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Recent searches section (placeholder)
          const Text(
            'البحث حسب الخدمة',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          // Categories
          categoriesAsync.when(
            data: (categories) {
              return Wrap(
                spacing: 8,
                runSpacing: 8,
                children: categories.map((category) {
                  return GestureDetector(
                    onTap: () {
                      context.push('/category/${category.id}');
                    },
                    child: CategoryChip(
                      category: category,
                      onTap: () {
                        context.push('/category/${category.id}');
                      },
                    ),
                  );
                }).toList(),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (_, __) => const Text('فشل في تحميل الخدمات'),
          ),

          const SizedBox(height: 32),

          // Popular searches
          const Text(
            'عمليات بحث شائعة',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _SearchSuggestionChip(
                label: 'سباك',
                onTap: () => _performSearch('سباك'),
              ),
              _SearchSuggestionChip(
                label: 'كهربائي',
                onTap: () => _performSearch('كهربائي'),
              ),
              _SearchSuggestionChip(
                label: 'نجار',
                onTap: () => _performSearch('نجار'),
              ),
              _SearchSuggestionChip(
                label: 'دهان',
                onTap: () => _performSearch('دهان'),
              ),
              _SearchSuggestionChip(
                label: 'تكييف',
                onTap: () => _performSearch('تكييف'),
              ),
              _SearchSuggestionChip(
                label: 'ألوميتال',
                onTap: () => _performSearch('ألوميتال'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults(AsyncValue<List<Craftsman>> craftsmenAsync) {
    return craftsmenAsync.when(
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
                  'لا توجد نتائج لـ "$_searchQuery"',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'جرب البحث بكلمات أخرى',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: craftsmen.length,
          itemBuilder: (context, index) {
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
            const Text('فشل في البحث'),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => _performSearch(_searchQuery),
              child: const Text('إعادة المحاولة'),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchSuggestionChip extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _SearchSuggestionChip({
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.search, size: 16, color: Colors.grey[600]),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(color: Colors.grey[700]),
            ),
          ],
        ),
      ),
    );
  }
}
