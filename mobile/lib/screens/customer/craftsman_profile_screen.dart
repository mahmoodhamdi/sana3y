import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../models/craftsman.dart';
import '../../providers/craftsman_provider.dart';
import '../../config/routes.dart';

class CraftsmanProfileScreen extends ConsumerWidget {
  final String craftsmanId;

  const CraftsmanProfileScreen({
    super.key,
    required this.craftsmanId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final craftsmanAsync = ref.watch(craftsmanByIdProvider(craftsmanId));

    return Scaffold(
      body: craftsmanAsync.when(
        data: (craftsman) {
          if (craftsman == null) {
            return const Center(
              child: Text('الصنايعي غير موجود'),
            );
          }
          return _CraftsmanProfileContent(craftsman: craftsman);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              const Text('فشل في تحميل البيانات'),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () => ref.invalidate(craftsmanByIdProvider(craftsmanId)),
                child: const Text('إعادة المحاولة'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CraftsmanProfileContent extends StatelessWidget {
  final Craftsman craftsman;

  const _CraftsmanProfileContent({required this.craftsman});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // Cover and Profile Header
        SliverAppBar(
          expandedHeight: 260,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            background: Stack(
              fit: StackFit.expand,
              children: [
                // Cover Image
                if (craftsman.coverImage != null)
                  Image.network(
                    craftsman.coverImage!,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: Theme.of(context).primaryColor.withValues(alpha: 0.2),
                    ),
                  )
                else
                  Container(
                    color: Theme.of(context).primaryColor.withValues(alpha: 0.2),
                  ),

                // Gradient overlay
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.7),
                      ],
                    ),
                  ),
                ),

                // Profile info overlay
                Positioned(
                  bottom: 16,
                  left: 16,
                  right: 16,
                  child: Row(
                    children: [
                      // Profile Image
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 38,
                          backgroundImage: craftsman.profileImage != null
                              ? NetworkImage(craftsman.profileImage!)
                              : null,
                          child: craftsman.profileImage == null
                              ? const Icon(Icons.person, size: 40)
                              : null,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              craftsman.displayName,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 18,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${craftsman.ratingText} (${craftsman.totalRatings} تقييم)',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        // Status and Quick Info
        SliverToBoxAdapter(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                _StatusChip(
                  icon: Icons.circle,
                  label: craftsman.isOnline ? 'متصل الآن' : 'غير متصل',
                  color: craftsman.isOnline ? Colors.green : Colors.grey,
                ),
                const SizedBox(width: 12),
                _StatusChip(
                  icon: Icons.check_circle,
                  label: craftsman.isAvailable ? 'متاح للعمل' : 'غير متاح',
                  color: craftsman.isAvailable ? Colors.blue : Colors.grey,
                ),
                if (craftsman.isFeatured) ...[
                  const SizedBox(width: 12),
                  _StatusChip(
                    icon: Icons.star,
                    label: 'مميز',
                    color: Colors.amber,
                  ),
                ],
              ],
            ),
          ),
        ),

        // Stats
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _StatItem(
                  value: craftsman.completedJobs.toString(),
                  label: 'أعمال مكتملة',
                ),
                _StatItem(
                  value: '${craftsman.responseTime} د',
                  label: 'وقت الرد',
                ),
                _StatItem(
                  value: '${craftsman.completionRate.toStringAsFixed(0)}%',
                  label: 'نسبة الإتمام',
                ),
              ],
            ),
          ),
        ),

        // Bio
        if (craftsman.bio != null && craftsman.bio!.isNotEmpty)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'نبذة عني',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    craftsman.bio!,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),

        // Services
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'الخدمات',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                ...craftsman.services.map((service) {
                  final categoryName = service.category?['nameAr'] ?? 'خدمة';
                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.handyman,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                categoryName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              if (service.experience > 0)
                                Text(
                                  '${service.experience} سنة خبرة',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                            ],
                          ),
                        ),
                        if (service.basePrice != null)
                          Text(
                            'من ${service.basePrice!.toStringAsFixed(0)} ج.م',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ),

        // Work Photos
        if (craftsman.workPhotos.isNotEmpty)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'صور من أعمالي',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 120,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: craftsman.workPhotos.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(
                            left: index == craftsman.workPhotos.length - 1 ? 0 : 8,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              _showPhotoGallery(
                                context,
                                craftsman.workPhotos,
                                index,
                              );
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                craftsman.workPhotos[index],
                                width: 120,
                                height: 120,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Container(
                                  width: 120,
                                  height: 120,
                                  color: Colors.grey[200],
                                  child: const Icon(Icons.broken_image),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

        // Working Hours
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'أوقات العمل',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                _WorkingHoursWidget(workingHours: craftsman.workingHours),
              ],
            ),
          ),
        ),

        // Badges
        if (craftsman.badges.isNotEmpty)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: craftsman.badges.map((badge) {
                  return _BadgeChip(badge: badge);
                }).toList(),
              ),
            ),
          ),

        // Bottom spacing
        const SliverToBoxAdapter(
          child: SizedBox(height: 100),
        ),
      ],
    );
  }

  void _showPhotoGallery(
    BuildContext context,
    List<String> photos,
    int initialIndex,
  ) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.black,
        insetPadding: EdgeInsets.zero,
        child: Stack(
          children: [
            PageView.builder(
              controller: PageController(initialPage: initialIndex),
              itemCount: photos.length,
              itemBuilder: (context, index) {
                return InteractiveViewer(
                  child: Center(
                    child: Image.network(
                      photos[index],
                      fit: BoxFit.contain,
                    ),
                  ),
                );
              },
            ),
            Positioned(
              top: 40,
              right: 16,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white, size: 30),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _StatusChip({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;

  const _StatItem({
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}

class _WorkingHoursWidget extends StatelessWidget {
  final List<WorkingHour> workingHours;

  const _WorkingHoursWidget({required this.workingHours});

  static const _dayNames = [
    'الأحد',
    'الاثنين',
    'الثلاثاء',
    'الأربعاء',
    'الخميس',
    'الجمعة',
    'السبت',
  ];

  @override
  Widget build(BuildContext context) {
    if (workingHours.isEmpty) {
      return Text(
        'غير محدد',
        style: TextStyle(color: Colors.grey[600]),
      );
    }

    return Column(
      children: List.generate(7, (day) {
        final hour = workingHours.firstWhere(
          (h) => h.day == day,
          orElse: () => WorkingHour(day: day, isWorking: false),
        );

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: [
              SizedBox(
                width: 80,
                child: Text(
                  _dayNames[day],
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
              Expanded(
                child: Text(
                  hour.isWorking
                      ? '${hour.start} - ${hour.end}'
                      : 'إجازة',
                  style: TextStyle(
                    color: hour.isWorking ? Colors.grey[700] : Colors.grey[400],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class _BadgeChip extends StatelessWidget {
  final String badge;

  const _BadgeChip({required this.badge});

  @override
  Widget build(BuildContext context) {
    IconData icon;
    String label;
    Color color;

    switch (badge) {
      case 'verified':
        icon = Icons.verified;
        label = 'موثق';
        color = Colors.blue;
        break;
      case 'top-rated':
        icon = Icons.star;
        label = 'الأعلى تقييماً';
        color = Colors.amber;
        break;
      case 'fast-response':
        icon = Icons.flash_on;
        label = 'سريع الرد';
        color = Colors.green;
        break;
      default:
        icon = Icons.badge;
        label = badge;
        color = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
