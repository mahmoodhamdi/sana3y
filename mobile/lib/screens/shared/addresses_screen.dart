import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/routes.dart';

class AddressesScreen extends ConsumerStatefulWidget {
  const AddressesScreen({super.key});

  @override
  ConsumerState<AddressesScreen> createState() => _AddressesScreenState();
}

class _AddressesScreenState extends ConsumerState<AddressesScreen> {
  // Mock addresses - in production, this would come from a provider
  final List<Map<String, dynamic>> _addresses = [
    {
      'id': '1',
      'label': 'المنزل',
      'address': 'شارع 15، بجوار مسجد النور',
      'area': 'الباجور',
      'city': 'المنوفية',
      'isDefault': true,
    },
    {
      'id': '2',
      'label': 'العمل',
      'address': 'شارع الجمهورية، عمارة 7',
      'area': 'شبين الكوم',
      'city': 'المنوفية',
      'isDefault': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('العناوين المحفوظة'),
      ),
      body: _addresses.isEmpty
          ? _buildEmptyState()
          : _buildAddressList(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(AppRoutes.addAddress),
        icon: const Icon(Icons.add),
        label: const Text('إضافة عنوان'),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.location_off, size: 80, color: Colors.grey[300]),
          const SizedBox(height: 16),
          const Text(
            'لا توجد عناوين محفوظة',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'أضف عنوانك الأول لتسهيل طلب الخدمات',
            style: TextStyle(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _addresses.length,
      itemBuilder: (context, index) {
        final address = _addresses[index];
        return _AddressCard(
          address: address,
          onSetDefault: () => _setDefaultAddress(address['id']),
          onEdit: () => _editAddress(address['id']),
          onDelete: () => _deleteAddress(address['id']),
        );
      },
    );
  }

  void _setDefaultAddress(String id) {
    setState(() {
      for (var address in _addresses) {
        address['isDefault'] = address['id'] == id;
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم تعيين العنوان كافتراضي')),
    );
  }

  void _editAddress(String id) {
    context.push('${AppRoutes.addAddress}?edit=$id');
  }

  void _deleteAddress(String id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('حذف العنوان'),
        content: const Text('هل أنت متأكد من حذف هذا العنوان؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _addresses.removeWhere((a) => a['id'] == id);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('تم حذف العنوان')),
              );
            },
            child: const Text('حذف', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

class _AddressCard extends StatelessWidget {
  final Map<String, dynamic> address;
  final VoidCallback onSetDefault;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _AddressCard({
    required this.address,
    required this.onSetDefault,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDefault = address['isDefault'] ?? false;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    _getIconForLabel(address['label']),
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            address['label'],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (isDefault) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.green[100],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                'الافتراضي',
                                style: TextStyle(
                                  color: Colors.green[700],
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        address['address'],
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      Text(
                        '${address['area']}، ${address['city']}',
                        style: TextStyle(color: Colors.grey[500], fontSize: 13),
                      ),
                    ],
                  ),
                ),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    switch (value) {
                      case 'default':
                        onSetDefault();
                        break;
                      case 'edit':
                        onEdit();
                        break;
                      case 'delete':
                        onDelete();
                        break;
                    }
                  },
                  itemBuilder: (context) => [
                    if (!isDefault)
                      const PopupMenuItem(
                        value: 'default',
                        child: Row(
                          children: [
                            Icon(Icons.check_circle_outline),
                            SizedBox(width: 8),
                            Text('تعيين كافتراضي'),
                          ],
                        ),
                      ),
                    const PopupMenuItem(
                      value: 'edit',
                      child: Row(
                        children: [
                          Icon(Icons.edit_outlined),
                          SizedBox(width: 8),
                          Text('تعديل'),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(Icons.delete_outline, color: Colors.red),
                          SizedBox(width: 8),
                          Text('حذف', style: TextStyle(color: Colors.red)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
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
}
