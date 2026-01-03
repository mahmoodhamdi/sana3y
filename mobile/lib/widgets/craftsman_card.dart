import 'package:flutter/material.dart';
import '../models/craftsman.dart';

class CraftsmanCard extends StatelessWidget {
  final Craftsman craftsman;
  final VoidCallback? onTap;
  final bool showDistance;

  const CraftsmanCard({
    super.key,
    required this.craftsman,
    this.onTap,
    this.showDistance = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: SizedBox(
                height: 100,
                width: double.infinity,
                child: craftsman.profileImage != null
                    ? Image.network(
                        craftsman.profileImage!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return _buildPlaceholder(context);
                        },
                      )
                    : _buildPlaceholder(context),
              ),
            ),

            // Info
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name
                    Text(
                      craftsman.displayName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),

                    // Rating
                    Row(
                      children: [
                        const Icon(Icons.star, size: 14, color: Colors.amber),
                        const SizedBox(width: 4),
                        Text(
                          craftsman.ratingText,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          ' (${craftsman.totalRatings})',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 4),

                    // Status indicators
                    Row(
                      children: [
                        if (craftsman.isOnline)
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                          ),
                        if (craftsman.isOnline) const SizedBox(width: 4),
                        if (craftsman.isOnline)
                          const Text(
                            'متصل',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.green,
                            ),
                          ),
                        if (showDistance && craftsman.formattedDistance != null)
                          Expanded(
                            child: Text(
                              craftsman.formattedDistance!,
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholder(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
      child: Center(
        child: Icon(
          Icons.person,
          size: 40,
          color: Theme.of(context).primaryColor.withValues(alpha: 0.5),
        ),
      ),
    );
  }
}

class CraftsmanListTile extends StatelessWidget {
  final Craftsman craftsman;
  final VoidCallback? onTap;
  final bool showDistance;

  const CraftsmanListTile({
    super.key,
    required this.craftsman,
    this.onTap,
    this.showDistance = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        radius: 28,
        backgroundColor: Theme.of(context).primaryColor.withValues(alpha: 0.1),
        backgroundImage: craftsman.profileImage != null
            ? NetworkImage(craftsman.profileImage!)
            : null,
        child: craftsman.profileImage == null
            ? Icon(
                Icons.person,
                color: Theme.of(context).primaryColor,
              )
            : null,
      ),
      title: Text(
        craftsman.displayName,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Row(
        children: [
          const Icon(Icons.star, size: 14, color: Colors.amber),
          const SizedBox(width: 4),
          Text(
            '${craftsman.ratingText} (${craftsman.totalRatings})',
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
          if (craftsman.isOnline) ...[
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'متصل',
                style: TextStyle(fontSize: 10, color: Colors.green),
              ),
            ),
          ],
        ],
      ),
      trailing: showDistance && craftsman.formattedDistance != null
          ? Text(
              craftsman.formattedDistance!,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            )
          : const Icon(Icons.chevron_left),
    );
  }
}
