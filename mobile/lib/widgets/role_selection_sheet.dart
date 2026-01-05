import 'package:flutter/material.dart';
import 'role_selection_card.dart';

class RoleSelectionSheet extends StatefulWidget {
  final String? initialRole;

  const RoleSelectionSheet({super.key, this.initialRole});

  static Future<String?> show(BuildContext context, {String? initialRole}) {
    return showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => RoleSelectionSheet(initialRole: initialRole),
    );
  }

  @override
  State<RoleSelectionSheet> createState() => _RoleSelectionSheetState();
}

class _RoleSelectionSheetState extends State<RoleSelectionSheet> {
  String? _selectedRole;

  @override
  void initState() {
    super.initState();
    _selectedRole = widget.initialRole;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      padding: EdgeInsets.only(bottom: bottomPadding),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle bar
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 24),

              // Title
              Text(
                'اختر نوع الحساب',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'حدد نوع حسابك للمتابعة',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 32),

              // Role cards
              Row(
                children: [
                  Expanded(
                    child: RoleSelectionCard(
                      icon: Icons.person_outline,
                      title: 'عميل',
                      subtitle: 'أبحث عن صنايعي\nلتنفيذ خدمة',
                      isSelected: _selectedRole == 'customer',
                      onTap: () => setState(() => _selectedRole = 'customer'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: RoleSelectionCard(
                      icon: Icons.handyman_outlined,
                      title: 'صنايعي',
                      subtitle: 'أقدم خدماتي\nللعملاء',
                      isSelected: _selectedRole == 'craftsman',
                      onTap: () => setState(() => _selectedRole = 'craftsman'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Continue button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _selectedRole != null
                      ? () => Navigator.of(context).pop(_selectedRole)
                      : null,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    disabledBackgroundColor: Colors.grey[300],
                  ),
                  child: const Text(
                    'متابعة',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Cancel button
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  'إلغاء',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
