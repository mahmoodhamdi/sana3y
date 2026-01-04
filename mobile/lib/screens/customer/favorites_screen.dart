import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../models/craftsman.dart';
import '../../providers/craftsman_provider.dart';

// Provider to get favorite craftsmen IDs (from customer profile)
// TODO: Replace with actual customer provider when available
final favoriteCraftsmenIdsProvider = StateProvider<List<String>>((ref) {
  // This would normally come from customer profile
  return [];
});

// Provider to fetch craftsman details for favorites
final favoriteCraftsmenProvider = FutureProvider<List<Craftsman>>((ref) async {
  final favoriteIds = ref.watch(favoriteCraftsmenIdsProvider);
  if (favoriteIds.isEmpty) return [];

  final service = ref.watch(craftsmanServiceProvider);
  final craftsmen = <Craftsman>[];

  for (final id in favoriteIds) {
    try {
      final craftsman = await service.getCraftsmanById(id);
      if (craftsman != null) {
        craftsmen.add(craftsman);
      }
    } catch (e) {
      // Skip if craftsman not found
    }
  }

  return craftsmen;
});

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritesAsync = ref.watch(favoriteCraftsmenProvider);
    final favoriteIds = ref.watch(favoriteCraftsmenIdsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('المفضلة'),
        actions: [
          if (favoriteIds.isNotEmpty)
            TextButton(
              onPressed: () => _clearAllFavorites(context, ref),
              child: const Text('مسح الكل'),
            ),
        ],
      ),
      body: favoritesAsync.when(
        data: (craftsmen) {
          if (craftsmen.isEmpty) {
            return _buildEmptyState(context);
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: craftsmen.length,
            itemBuilder: (context, index) {
              return _FavoriteCard(
                craftsman: craftsmen[index],
                onRemove: () =>
                    _removeFromFavorites(context, ref, craftsmen[index].id),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text('فشل في تحميل المفضلة: $error'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.invalidate(favoriteCraftsmenProvider),
                child: const Text('إعادة المحاولة'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.favorite_border, size: 80, color: Colors.grey[300]),
            const SizedBox(height: 24),
            const Text(
              'لا توجد عناصر مفضلة',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'أضف الصنايعية المفضلين لديك للوصول إليهم بسهولة',
              style: TextStyle(
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => context.go('/customer'),
              icon: const Icon(Icons.search),
              label: const Text('ابحث عن صنايعية'),
            ),
          ],
        ),
      ),
    );
  }

  void _removeFromFavorites(BuildContext context, WidgetRef ref, String id) {
    final currentFavorites = ref.read(favoriteCraftsmenIdsProvider);
    ref.read(favoriteCraftsmenIdsProvider.notifier).state =
        currentFavorites.where((fid) => fid != id).toList();

    // TODO: Call API to remove from favorites
    // await ref.read(customerServiceProvider).removeFromFavorites(id);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('تمت الإزالة من المفضلة'),
        action: SnackBarAction(
          label: 'تراجع',
          onPressed: () {
            ref.read(favoriteCraftsmenIdsProvider.notifier).state = [
              ...ref.read(favoriteCraftsmenIdsProvider),
              id
            ];
          },
        ),
      ),
    );
  }

  Future<void> _clearAllFavorites(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('مسح المفضلة'),
        content: const Text('هل أنت متأكد من مسح جميع العناصر المفضلة؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('مسح', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    ref.read(favoriteCraftsmenIdsProvider.notifier).state = [];

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم مسح جميع العناصر المفضلة')),
      );
    }
  }
}

class _FavoriteCard extends StatelessWidget {
  final Craftsman craftsman;
  final VoidCallback onRemove;

  const _FavoriteCard({
    required this.craftsman,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => context.push('/craftsman/${craftsman.id}'),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Avatar
              CircleAvatar(
                radius: 32,
                backgroundImage: craftsman.profileImage != null
                    ? NetworkImage(craftsman.profileImage!)
                    : null,
                child: craftsman.profileImage == null
                    ? const Icon(Icons.person, size: 32)
                    : null,
              ),
              const SizedBox(width: 16),

              // Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      craftsman.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Category
                    if (craftsman.services.isNotEmpty)
                      Text(
                        craftsman.services.first.category?['nameAr'] ?? 'صنايعي',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 13,
                        ),
                      ),
                    const SizedBox(height: 4),
                    // Rating
                    Row(
                      children: [
                        const Icon(Icons.star, size: 16, color: Colors.amber),
                        const SizedBox(width: 4),
                        Text(
                          (craftsman.rating ?? 0).toStringAsFixed(1),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '(${craftsman.totalRatings} تقييم)',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Actions
              Column(
                children: [
                  // Remove button
                  IconButton(
                    onPressed: onRemove,
                    icon: const Icon(Icons.favorite, color: Colors.red),
                    tooltip: 'إزالة من المفضلة',
                  ),
                  // Online status
                  if (craftsman.isOnline)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green[50],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'متاح',
                            style: TextStyle(
                              color: Colors.green[700],
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
