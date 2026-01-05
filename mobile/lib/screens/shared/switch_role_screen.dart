import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../models/user.dart';
import '../../providers/auth_provider.dart';

class SwitchRoleScreen extends ConsumerWidget {
  const SwitchRoleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentRole = ref.watch(userRoleProvider);
    final user = ref.watch(currentUserProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('تبديل الحساب'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Current User Info
            if (user != null)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundImage:
                          user.avatar != null ? NetworkImage(user.avatar!) : null,
                      child: user.avatar == null
                          ? const Icon(Icons.person, size: 28)
                          : null,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            user.email,
                            style: TextStyle(color: Colors.grey[600]),
                            textDirection: TextDirection.ltr,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 32),

            const Text(
              'اختر نوع الحساب',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // Customer Role
            _RoleCard(
              icon: Icons.person,
              title: 'عميل',
              description: 'ابحث عن صنايعية واطلب خدمات',
              isSelected: currentRole == UserRole.customer,
              color: Colors.blue,
              onTap: () => _switchRole(context, ref, UserRole.customer),
            ),
            const SizedBox(height: 12),

            // Craftsman Role
            _RoleCard(
              icon: Icons.construction,
              title: 'صنايعي',
              description: 'استقبل طلبات العمل وقدم خدماتك',
              isSelected: currentRole == UserRole.craftsman,
              color: Colors.orange,
              onTap: () => _switchRole(context, ref, UserRole.craftsman),
            ),
            const Spacer(),

            // Info Box
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
                      'يمكنك التبديل بين الحسابين في أي وقت من الإعدادات',
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

  Future<void> _switchRole(
    BuildContext context,
    WidgetRef ref,
    UserRole newRole,
  ) async {
    final currentRole = ref.read(userRoleProvider);

    if (currentRole == newRole) {
      // Already on this role, navigate to home
      _navigateToHome(context, newRole);
      return;
    }

    // Show confirmation dialog
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تبديل الحساب'),
        content: Text(
          'هل تريد التبديل إلى حساب ${newRole == UserRole.customer ? 'العميل' : 'الصنايعي'}؟',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('تبديل'),
          ),
        ],
      ),
    );

    if (confirmed != true || !context.mounted) return;

    // Show loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      // Call API to switch role
      await ref.read(authProvider.notifier).switchRole(newRole);

      if (context.mounted) {
        Navigator.pop(context); // Close loading
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'تم التبديل إلى حساب ${newRole == UserRole.customer ? 'العميل' : 'الصنايعي'}',
            ),
            backgroundColor: Colors.green,
          ),
        );
        _navigateToHome(context, newRole);
      }
    } catch (e) {
      if (context.mounted) {
        Navigator.pop(context); // Close loading
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('فشل في تبديل الحساب: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _navigateToHome(BuildContext context, UserRole role) {
    if (role == UserRole.craftsman) {
      context.go('/craftsman');
    } else {
      context.go('/customer');
    }
  }
}

class _RoleCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final bool isSelected;
  final Color color;
  final VoidCallback onTap;

  const _RoleCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.isSelected,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected ? color.withValues(alpha: 0.1) : Colors.grey[100],
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? color : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected ? color.withValues(alpha: 0.2) : Colors.grey[200],
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: isSelected ? color : Colors.grey[600],
                size: 28,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? color : Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: color,
                size: 28,
              ),
          ],
        ),
      ),
    );
  }
}
