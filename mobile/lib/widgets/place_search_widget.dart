import 'dart:async';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import '../services/map_service.dart';

/// FREE Place Search Widget using Nominatim
/// TODO: Switch to Google Places when billing is ready
class PlaceSearchWidget extends StatefulWidget {
  final Function(PlaceResult) onPlaceSelected;
  final LatLng? searchNear;
  final String? hintText;
  final bool autofocus;

  const PlaceSearchWidget({
    super.key,
    required this.onPlaceSelected,
    this.searchNear,
    this.hintText,
    this.autofocus = false,
  });

  @override
  State<PlaceSearchWidget> createState() => _PlaceSearchWidgetState();
}

class _PlaceSearchWidgetState extends State<PlaceSearchWidget> {
  final TextEditingController _controller = TextEditingController();
  final MapService _mapService = MapService();
  List<PlaceResult> _results = [];
  bool _isLoading = false;
  Timer? _debounceTimer;

  // Rate limiting for Nominatim (1 request/second)
  DateTime? _lastSearchTime;

  @override
  void dispose() {
    _controller.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    _debounceTimer?.cancel();

    if (query.length < 3) {
      setState(() => _results = []);
      return;
    }

    // Debounce: Wait 500ms after user stops typing
    // Also respect Nominatim rate limit (1 req/sec)
    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      // Check rate limit
      if (_lastSearchTime != null) {
        final timeSinceLastSearch =
            DateTime.now().difference(_lastSearchTime!);
        if (timeSinceLastSearch.inMilliseconds < 1000) {
          await Future.delayed(
            Duration(milliseconds: 1000 - timeSinceLastSearch.inMilliseconds),
          );
        }
      }

      setState(() => _isLoading = true);
      _lastSearchTime = DateTime.now();

      final results = await _mapService.searchPlaces(
        query,
        near: widget.searchNear,
      );

      if (mounted) {
        setState(() {
          _results = results;
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Search Input
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextField(
            controller: _controller,
            autofocus: widget.autofocus,
            textDirection: TextDirection.rtl,
            decoration: InputDecoration(
              hintText: widget.hintText ?? 'ابحث عن موقع...',
              hintTextDirection: TextDirection.rtl,
              prefixIcon: _isLoading
                  ? const Padding(
                      padding: EdgeInsets.all(12),
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    )
                  : const Icon(Icons.search),
              suffixIcon: _controller.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _controller.clear();
                        setState(() => _results = []);
                      },
                    )
                  : null,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
            ),
            onChanged: _onSearchChanged,
          ),
        ),

        // Results List
        if (_results.isNotEmpty)
          Container(
            margin: const EdgeInsets.only(top: 8),
            constraints: const BoxConstraints(maxHeight: 250),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: _results.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final place = _results[index];
                  return ListTile(
                    leading: Icon(
                      _getIconForType(place.type),
                      color: Theme.of(context).primaryColor,
                    ),
                    title: Text(
                      place.name,
                      textDirection: TextDirection.rtl,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text(
                      place.address,
                      textDirection: TextDirection.rtl,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    onTap: () {
                      widget.onPlaceSelected(place);
                      _controller.text = place.name;
                      setState(() => _results = []);
                    },
                  );
                },
              ),
            ),
          ),
      ],
    );
  }

  IconData _getIconForType(String type) {
    switch (type.toLowerCase()) {
      case 'house':
      case 'residential':
      case 'apartments':
        return Icons.home;
      case 'shop':
      case 'commercial':
      case 'supermarket':
        return Icons.store;
      case 'hospital':
      case 'clinic':
      case 'pharmacy':
        return Icons.local_hospital;
      case 'school':
      case 'university':
        return Icons.school;
      case 'restaurant':
      case 'cafe':
        return Icons.restaurant;
      case 'mosque':
        return Icons.mosque;
      case 'bank':
        return Icons.account_balance;
      case 'hotel':
        return Icons.hotel;
      default:
        return Icons.location_on;
    }
  }
}

/// Compact search bar that expands to full search
class PlaceSearchBar extends StatelessWidget {
  final VoidCallback onTap;
  final String? selectedAddress;

  const PlaceSearchBar({
    super.key,
    required this.onTap,
    this.selectedAddress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            const Icon(Icons.search, color: Colors.grey),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                selectedAddress ?? 'ابحث عن موقع...',
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  color: selectedAddress != null ? Colors.black : Colors.grey,
                  fontSize: 14,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (selectedAddress != null)
              const Icon(Icons.check_circle, color: Colors.green, size: 20),
          ],
        ),
      ),
    );
  }
}
