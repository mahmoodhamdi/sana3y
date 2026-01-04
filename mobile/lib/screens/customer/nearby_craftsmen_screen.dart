import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/craftsman_provider.dart';
import '../../models/craftsman.dart';

class NearbyCraftsmenScreen extends ConsumerStatefulWidget {
  final String? categoryId;

  const NearbyCraftsmenScreen({super.key, this.categoryId});

  @override
  ConsumerState<NearbyCraftsmenScreen> createState() => _NearbyCraftsmenScreenState();
}

class _NearbyCraftsmenScreenState extends ConsumerState<NearbyCraftsmenScreen> {
  double _radius = 10.0;
  bool _isLoading = true;
  List<Craftsman> _craftsmen = [];
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadNearbyCraftsmen();
  }

  Future<void> _loadNearbyCraftsmen() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final craftsmen = await ref.read(craftsmanServiceProvider).getNearbyCraftsmen(
        lat: 30.4522, // Default: الباجور
        lng: 30.9667,
        radius: _radius,
        categoryId: widget.categoryId,
      );

      if (mounted) {
        setState(() {
          _craftsmen = craftsmen;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('صنايعية بالقرب منك'),
        actions: [
          IconButton(
            icon: const Icon(Icons.tune),
            onPressed: _showRadiusDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          // Radius indicator
          Container(
            padding: const EdgeInsets.all(16),
            color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
            child: Row(
              children: [
                const Icon(Icons.location_on, size: 20),
                const SizedBox(width: 8),
                Text('نطاق البحث: ${_radius.toInt()} كم'),
                const Spacer(),
                TextButton(
                  onPressed: _showRadiusDialog,
                  child: const Text('تغيير'),
                ),
              ],
            ),
          ),

          // Content
          Expanded(
            child: _buildContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            Text('فشل في تحميل الصنايعية: $_error'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadNearbyCraftsmen,
              child: const Text('إعادة المحاولة'),
            ),
          ],
        ),
      );
    }

    if (_craftsmen.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 80, color: Colors.grey[300]),
            const SizedBox(height: 16),
            const Text(
              'لا يوجد صنايعية في هذه المنطقة',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'جرب زيادة نطاق البحث',
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _showRadiusDialog,
              child: const Text('تغيير النطاق'),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadNearbyCraftsmen,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _craftsmen.length,
        itemBuilder: (context, index) {
          final craftsman = _craftsmen[index];
          return _CraftsmanCard(
            craftsman: craftsman,
            onTap: () => context.push('/craftsman/${craftsman.id}'),
          );
        },
      ),
    );
  }

  void _showRadiusDialog() {
    showModalBottomSheet(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'نطاق البحث',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              Text(
                '${_radius.toInt()} كم',
                style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Slider(
                value: _radius,
                min: 1,
                max: 50,
                divisions: 49,
                label: '${_radius.toInt()} كم',
                onChanged: (value) {
                  setModalState(() {
                    _radius = value;
                  });
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() {});
                    _loadNearbyCraftsmen();
                  },
                  child: const Text('تطبيق'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CraftsmanCard extends StatelessWidget {
  final Craftsman craftsman;
  final VoidCallback onTap;

  const _CraftsmanCard({
    required this.craftsman,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Avatar
              CircleAvatar(
                radius: 30,
                backgroundImage: craftsman.profileImage != null
                    ? NetworkImage(craftsman.profileImage!)
                    : null,
                child: craftsman.profileImage == null
                    ? const Icon(Icons.person, size: 30)
                    : null,
              ),
              const SizedBox(width: 16),

              // Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            craftsman.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        if (craftsman.isOnline)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green[50],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 6,
                                  height: 6,
                                  decoration: const BoxDecoration(
                                    color: Colors.green,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'متصل',
                                  style: TextStyle(
                                    color: Colors.green[700],
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    if (craftsman.services.isNotEmpty)
                      Text(
                        craftsman.services.first.category?['nameAr'] ?? 'صنايعي',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.star, size: 16, color: Colors.amber),
                        const SizedBox(width: 4),
                        Text(
                          craftsman.rating.toStringAsFixed(1),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '(${craftsman.totalRatings})',
                          style: TextStyle(color: Colors.grey[600], fontSize: 12),
                        ),
                        const Spacer(),
                        Icon(Icons.location_on, size: 14, color: Colors.grey[500]),
                        const SizedBox(width: 4),
                        Text(
                          craftsman.address ?? 'غير محدد',
                          style: TextStyle(color: Colors.grey[600], fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Arrow
              const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
