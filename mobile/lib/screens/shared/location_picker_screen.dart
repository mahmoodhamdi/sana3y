import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import '../../widgets/osm_map_widget.dart';
import '../../widgets/place_search_widget.dart';
import '../../services/map_service.dart';
import '../../config/constants.dart';
import 'package:flutter_map/flutter_map.dart';

/// FREE Location Picker Screen using OpenStreetMap
/// TODO: Switch to Google Maps when billing is ready
class LocationPickerScreen extends ConsumerStatefulWidget {
  final double? initialLatitude;
  final double? initialLongitude;
  final String? title;

  const LocationPickerScreen({
    super.key,
    this.initialLatitude,
    this.initialLongitude,
    this.title,
  });

  @override
  ConsumerState<LocationPickerScreen> createState() =>
      _LocationPickerScreenState();
}

class _LocationPickerScreenState extends ConsumerState<LocationPickerScreen> {
  final MapService _mapService = MapService();
  final MapController _mapController = MapController();

  late LatLng _selectedLocation;
  LatLng? _userLocation;
  String? _selectedAddress;
  bool _isLoadingAddress = false;
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _selectedLocation = LatLng(
      widget.initialLatitude ?? AppConstants.defaultLatitude,
      widget.initialLongitude ?? AppConstants.defaultLongitude,
    );
    _getUserLocation();
    _getAddressForLocation(_selectedLocation);
  }

  Future<void> _getUserLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) return;

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) return;
      }

      if (permission == LocationPermission.deniedForever) return;

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      if (mounted) {
        setState(() {
          _userLocation = LatLng(position.latitude, position.longitude);
        });

        // If no initial location was provided, move to user location
        if (widget.initialLatitude == null && widget.initialLongitude == null) {
          _selectedLocation = _userLocation!;
          _mapController.move(_userLocation!, 15);
          _getAddressForLocation(_selectedLocation);
        }
      }
    } catch (e) {
      debugPrint('Error getting user location: $e');
    }
  }

  Future<void> _getAddressForLocation(LatLng location) async {
    setState(() => _isLoadingAddress = true);

    final address = await _mapService.getAddressFromCoordinates(location);

    if (mounted) {
      setState(() {
        _selectedAddress = address;
        _isLoadingAddress = false;
      });
    }
  }

  void _onMapTap(LatLng point) {
    setState(() {
      _selectedLocation = point;
    });
    _getAddressForLocation(point);
  }

  void _onPlaceSelected(PlaceResult place) {
    setState(() {
      _selectedLocation = place.location;
      _selectedAddress = place.address;
      _isSearching = false;
    });
    _mapController.move(place.location, 16);
  }

  void _confirmLocation() {
    context.pop(LocationResult(
      latitude: _selectedLocation.latitude,
      longitude: _selectedLocation.longitude,
      address: _selectedAddress,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? 'اختر الموقع'),
        actions: [
          TextButton(
            onPressed: _selectedAddress != null ? _confirmLocation : null,
            child: Text(
              'تأكيد',
              style: TextStyle(
                color:
                    _selectedAddress != null ? Colors.white : Colors.grey[400],
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          // Map
          OSMMapWidget(
            mapController: _mapController,
            initialCenter: _selectedLocation,
            initialZoom: 15,
            showUserLocation: true,
            userLocation: _userLocation,
            showZoomButtons: true,
            showMyLocationButton: true,
            onTap: _onMapTap,
            onMyLocationPressed: () {
              if (_userLocation != null) {
                _mapController.move(_userLocation!, 15);
                setState(() {
                  _selectedLocation = _userLocation!;
                });
                _getAddressForLocation(_userLocation!);
              }
            },
            markers: [
              MapMarkerData(
                id: 'selected',
                position: _selectedLocation,
                child: const _AnimatedPinMarker(),
              ),
            ],
          ),

          // Search Bar
          Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: _isSearching
                ? PlaceSearchWidget(
                    onPlaceSelected: _onPlaceSelected,
                    searchNear: _userLocation,
                    autofocus: true,
                  )
                : PlaceSearchBar(
                    onTap: () => setState(() => _isSearching = true),
                    selectedAddress: _selectedAddress,
                  ),
          ),

          // Close search button
          if (_isSearching)
            Positioned(
              top: 16,
              left: 16,
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(8),
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => setState(() => _isSearching = false),
                ),
              ),
            ),

          // Address Card at bottom
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Handle
                    Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),

                    // Address
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .primaryColor
                                .withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.location_on,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'الموقع المحدد',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 4),
                              _isLoadingAddress
                                  ? const SizedBox(
                                      height: 16,
                                      width: 16,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : Text(
                                      _selectedAddress ?? 'جاري تحديد العنوان...',
                                      textDirection: TextDirection.rtl,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Confirm Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed:
                            _selectedAddress != null ? _confirmLocation : null,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'تأكيد الموقع',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Animated pin marker for selected location
class _AnimatedPinMarker extends StatefulWidget {
  const _AnimatedPinMarker();

  @override
  State<_AnimatedPinMarker> createState() => _AnimatedPinMarkerState();
}

class _AnimatedPinMarkerState extends State<_AnimatedPinMarker>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.scale(
          scale: _animation.value,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.location_pin,
                color: Theme.of(context).primaryColor,
                size: 48,
              ),
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Result returned when location is confirmed
class LocationResult {
  final double latitude;
  final double longitude;
  final String? address;

  LocationResult({
    required this.latitude,
    required this.longitude,
    this.address,
  });
}
