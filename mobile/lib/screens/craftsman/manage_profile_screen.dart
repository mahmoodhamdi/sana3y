import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/routes.dart';
import '../../providers/auth_provider.dart';
import '../../providers/craftsman_provider.dart';

class ManageProfileScreen extends ConsumerWidget {
  const ManageProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final profileAsync = ref.watch(myCraftsmanProfileProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('إدارة الحساب'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Profile Header
            profileAsync.when(
              data: (profile) {
                return Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.white,
                            backgroundImage: profile?.profileImage != null
                                ? NetworkImage(profile!.profileImage!)
                                : null,
                            child: profile?.profileImage == null
                                ? Icon(
                                    Icons.person,
                                    size: 40,
                                    color: Theme.of(context).primaryColor,
                                  )
                                : null,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.camera_alt,
                                size: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              profile?.displayName ?? user?.name ?? '',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              user?.email ?? '',
                              style: TextStyle(
                                color: Colors.grey[600],
                              ),
                              textDirection: TextDirection.ltr,
                            ),
                            if (profile != null) ...[
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(Icons.star, size: 16, color: Colors.amber),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${profile.ratingText} (${profile.totalRatings} تقييم)',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (_, __) => const SizedBox.shrink(),
            ),

            const SizedBox(height: 24),

            // Settings sections
            _SettingsSection(
              title: 'الملف الشخصي',
              items: [
                _SettingsItem(
                  icon: Icons.person_outline,
                  title: 'تعديل البيانات',
                  subtitle: 'الاسم، النبذة، الصورة',
                  onTap: () => _showEditProfileSheet(context, ref),
                ),
                _SettingsItem(
                  icon: Icons.build_outlined,
                  title: 'الخدمات',
                  subtitle: 'إدارة الخدمات والأسعار',
                  onTap: () => context.push(AppRoutes.craftsmanServices),
                ),
                _SettingsItem(
                  icon: Icons.access_time,
                  title: 'أوقات العمل',
                  subtitle: 'تحديد ساعات العمل',
                  onTap: () => context.push(AppRoutes.craftsmanAvailability),
                ),
                _SettingsItem(
                  icon: Icons.photo_library_outlined,
                  title: 'صور الأعمال',
                  subtitle: 'إضافة صور لأعمالك السابقة',
                  onTap: () => context.push(AppRoutes.craftsmanWorkPhotos),
                ),
              ],
            ),

            const SizedBox(height: 16),

            _SettingsSection(
              title: 'المالية',
              items: [
                _SettingsItem(
                  icon: Icons.account_balance_wallet_outlined,
                  title: 'الأرباح',
                  subtitle: 'عرض تفاصيل الأرباح',
                  onTap: () => context.push(AppRoutes.craftsmanEarnings),
                ),
                _SettingsItem(
                  icon: Icons.payments_outlined,
                  title: 'طلب سحب',
                  subtitle: 'سحب الأرباح المتاحة',
                  onTap: () => context.push(AppRoutes.craftsmanWithdrawal),
                ),
              ],
            ),

            const SizedBox(height: 16),

            _SettingsSection(
              title: 'الحساب',
              items: [
                _SettingsItem(
                  icon: Icons.notifications_outlined,
                  title: 'الإشعارات',
                  subtitle: 'إدارة إعدادات الإشعارات',
                  onTap: () {},
                ),
                _SettingsItem(
                  icon: Icons.help_outline,
                  title: 'المساعدة والدعم',
                  subtitle: 'تواصل معنا',
                  onTap: () {},
                ),
                _SettingsItem(
                  icon: Icons.logout,
                  title: 'تسجيل الخروج',
                  subtitle: '',
                  isDestructive: true,
                  onTap: () => _showLogoutDialog(context, ref),
                ),
              ],
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  void _showEditProfileSheet(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.read(myCraftsmanProfileProvider);
    final profile = profileAsync.valueOrNull;

    if (profile == null) return;

    final nameController = TextEditingController(text: profile.displayName);
    final bioController = TextEditingController(text: profile.bio ?? '');
    final whatsappController = TextEditingController(text: profile.whatsapp ?? '');

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'تعديل البيانات',
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
              const SizedBox(height: 20),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'اسم العرض',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: bioController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'نبذة عنك',
                  border: OutlineInputBorder(),
                  hintText: 'اكتب نبذة مختصرة عن خبرتك...',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: whatsappController,
                decoration: const InputDecoration(
                  labelText: 'رقم واتساب',
                  border: OutlineInputBorder(),
                  prefixText: '+20 ',
                ),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    final service = ref.read(craftsmanServiceProvider);
                    await service.updateProfile({
                      'displayName': nameController.text,
                      'bio': bioController.text,
                      'whatsapp': whatsappController.text,
                    });
                    ref.invalidate(myCraftsmanProfileProvider);
                    if (context.mounted) Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text('حفظ'),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تسجيل الخروج'),
        content: const Text('هل أنت متأكد من تسجيل الخروج؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ref.read(authProvider.notifier).logout();
            },
            child: const Text(
              'تسجيل الخروج',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  final String title;
  final List<_SettingsItem> items;

  const _SettingsSection({
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 4, bottom: 8),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              return Column(
                children: [
                  ListTile(
                    leading: Icon(
                      item.icon,
                      color: item.isDestructive
                          ? Colors.red
                          : Theme.of(context).primaryColor,
                    ),
                    title: Text(
                      item.title,
                      style: TextStyle(
                        color: item.isDestructive ? Colors.red : null,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: item.subtitle.isNotEmpty
                        ? Text(
                            item.subtitle,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          )
                        : null,
                    trailing: const Icon(Icons.chevron_left, size: 20),
                    onTap: item.onTap,
                  ),
                  if (index < items.length - 1)
                    Divider(height: 1, indent: 56, color: Colors.grey[200]),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class _SettingsItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final bool isDestructive;

  const _SettingsItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.isDestructive = false,
  });
}
