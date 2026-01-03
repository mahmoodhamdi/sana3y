import 'package:flutter/material.dart';
import '../models/category.dart';

class CategoryCard extends StatelessWidget {
  final Category category;
  final VoidCallback? onTap;

  const CategoryCard({
    super.key,
    required this.category,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: category.icon != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      category.icon!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.handyman,
                          size: 32,
                          color: Theme.of(context).primaryColor,
                        );
                      },
                    ),
                  )
                : Icon(
                    _getIconForCategory(category.slug),
                    size: 32,
                    color: Theme.of(context).primaryColor,
                  ),
          ),
          const SizedBox(height: 8),
          Text(
            category.nameAr,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIconForCategory(String slug) {
    switch (slug.toLowerCase()) {
      case 'plumbing':
      case 'سباكة':
        return Icons.plumbing;
      case 'electrical':
      case 'كهرباء':
        return Icons.electrical_services;
      case 'carpentry':
      case 'نجارة':
        return Icons.carpenter;
      case 'painting':
      case 'دهان':
        return Icons.format_paint;
      case 'cleaning':
      case 'تنظيف':
        return Icons.cleaning_services;
      case 'ac':
      case 'تكييف':
        return Icons.ac_unit;
      case 'appliances':
      case 'أجهزة':
        return Icons.kitchen;
      case 'masonry':
      case 'بناء':
        return Icons.foundation;
      default:
        return Icons.handyman;
    }
  }
}

class CategoryChip extends StatelessWidget {
  final Category category;
  final bool isSelected;
  final VoidCallback? onTap;

  const CategoryChip({
    super.key,
    required this.category,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).primaryColor
              : Colors.grey[100],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? Theme.of(context).primaryColor
                : Colors.grey[300]!,
          ),
        ),
        child: Text(
          category.nameAr,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey[800],
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
