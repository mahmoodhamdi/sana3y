import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';
import '../config/constants.dart';
import '../models/craftsman.dart';

/// FREE Craftsmen Map Widget using OpenStreetMap with clustering
/// TODO: Switch to Google Maps when billing is ready
class CraftsmenMapWidget extends StatefulWidget {
  final List<Craftsman> craftsmen;
  final LatLng? userLocation;
  final double initialZoom;
  final Function(Craftsman)? onCraftsmanTap;
  final bool showUserLocation;
  final bool showCluster;

  const CraftsmenMapWidget({
    super.key,
    required this.craftsmen,
    this.userLocation,
    this.initialZoom = 13.0,
    this.onCraftsmanTap,
    this.showUserLocation = true,
    this.showCluster = true,
  });

  @override
  State<CraftsmenMapWidget> createState() => _CraftsmenMapWidgetState();
}

class _CraftsmenMapWidgetState extends State<CraftsmenMapWidget> {
  final MapController _mapController = MapController();
  Craftsman? _selectedCraftsman;

  LatLng get _center {
    if (widget.userLocation != null) {
      return widget.userLocation!;
    }
    if (widget.craftsmen.isNotEmpty) {
      final first = widget.craftsmen.first;
      if (first.location?.coordinates != null &&
          first.location!.coordinates.length >= 2) {
        return LatLng(
          first.location!.coordinates[1],
          first.location!.coordinates[0],
        );
      }
    }
    return LatLng(AppConstants.defaultLatitude, AppConstants.defaultLongitude);
  }

  List<Marker> _buildMarkers() {
    final markers = <Marker>[];

    // User location marker
    if (widget.showUserLocation && widget.userLocation != null) {
      markers.add(
        Marker(
          point: widget.userLocation!,
          width: 40,
          height: 40,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.3),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.blue, width: 2),
            ),
            child: const Center(
              child: Icon(Icons.my_location, color: Colors.blue, size: 20),
            ),
          ),
        ),
      );
    }

    // Craftsmen markers
    for (final craftsman in widget.craftsmen) {
      if (craftsman.location?.coordinates == null ||
          craftsman.location!.coordinates.length < 2) {
        continue;
      }

      final lat = craftsman.location!.coordinates[1];
      final lng = craftsman.location!.coordinates[0];

      markers.add(
        Marker(
          point: LatLng(lat, lng),
          width: 50,
          height: 50,
          child: GestureDetector(
            onTap: () {
              setState(() => _selectedCraftsman = craftsman);
              widget.onCraftsmanTap?.call(craftsman);
            },
            child: _CraftsmanMarker(
              craftsman: craftsman,
              isSelected: _selectedCraftsman?.id == craftsman.id,
            ),
          ),
        ),
      );
    }

    return markers;
  }

  @override
  Widget build(BuildContext context) {
    // /* GOOGLE MAPS - COMMENTED FOR FUTURE USE
    // return GoogleMap(
    //   initialCameraPosition: CameraPosition(
    //     target: LatLng(_center.latitude, _center.longitude),
    //     zoom: widget.initialZoom,
    //   ),
    //   markers: _buildGoogleMarkers(),
    //   myLocationEnabled: widget.showUserLocation,
    //   onMapCreated: (controller) => _googleMapController = controller,
    // );
    // */

    final markers = _buildMarkers();

    return Stack(
      children: [
        FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            initialCenter: _center,
            initialZoom: widget.initialZoom,
            onTap: (_, __) {
              setState(() => _selectedCraftsman = null);
            },
          ),
          children: [
            // OpenStreetMap Tile Layer (FREE)
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.sana3y.app',
              maxZoom: 19,
            ),

            // Clustered markers if enabled
            if (widget.showCluster && markers.length > 5)
              MarkerClusterLayerWidget(
                options: MarkerClusterLayerOptions(
                  maxClusterRadius: 80,
                  size: const Size(40, 40),
                  markers: markers,
                  builder: (context, markers) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          markers.length.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            else
              MarkerLayer(markers: markers),
          ],
        ),

        // Zoom controls
        Positioned(
          right: 16,
          bottom: _selectedCraftsman != null ? 200 : 100,
          child: Column(
            children: [
              _MapButton(
                icon: Icons.add,
                onPressed: () {
                  final currentZoom = _mapController.camera.zoom;
                  _mapController.move(
                    _mapController.camera.center,
                    currentZoom + 1,
                  );
                },
              ),
              const SizedBox(height: 8),
              _MapButton(
                icon: Icons.remove,
                onPressed: () {
                  final currentZoom = _mapController.camera.zoom;
                  _mapController.move(
                    _mapController.camera.center,
                    currentZoom - 1,
                  );
                },
              ),
              const SizedBox(height: 8),
              if (widget.showUserLocation && widget.userLocation != null)
                _MapButton(
                  icon: Icons.my_location,
                  onPressed: () {
                    _mapController.move(widget.userLocation!, 15);
                  },
                ),
            ],
          ),
        ),

        // Selected craftsman info card
        if (_selectedCraftsman != null)
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: _CraftsmanInfoCard(
              craftsman: _selectedCraftsman!,
              onClose: () => setState(() => _selectedCraftsman = null),
              onTap: () => widget.onCraftsmanTap?.call(_selectedCraftsman!),
            ),
          ),
      ],
    );
  }
}

class _CraftsmanMarker extends StatelessWidget {
  final Craftsman craftsman;
  final bool isSelected;

  const _CraftsmanMarker({
    required this.craftsman,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: isSelected ? 50 : 40,
      height: isSelected ? 50 : 40,
      decoration: BoxDecoration(
        color: isSelected
            ? Theme.of(context).primaryColor
            : Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: Theme.of(context).primaryColor,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: craftsman.profileImage != null
            ? ClipOval(
                child: Image.network(
                  craftsman.profileImage!,
                  width: isSelected ? 44 : 34,
                  height: isSelected ? 44 : 34,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Icon(
                    Icons.person,
                    color: isSelected
                        ? Colors.white
                        : Theme.of(context).primaryColor,
                    size: isSelected ? 28 : 22,
                  ),
                ),
              )
            : Icon(
                Icons.engineering,
                color: isSelected
                    ? Colors.white
                    : Theme.of(context).primaryColor,
                size: isSelected ? 28 : 22,
              ),
      ),
    );
  }
}

class _CraftsmanInfoCard extends StatelessWidget {
  final Craftsman craftsman;
  final VoidCallback onClose;
  final VoidCallback? onTap;

  const _CraftsmanInfoCard({
    required this.craftsman,
    required this.onClose,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Theme.of(context).primaryColor,
                width: 2,
              ),
            ),
            child: ClipOval(
              child: craftsman.profileImage != null
                  ? Image.network(
                      craftsman.profileImage!,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: Colors.grey[200],
                        child: const Icon(Icons.person, size: 30),
                      ),
                    )
                  : Container(
                      color: Colors.grey[200],
                      child: const Icon(Icons.engineering, size: 30),
                    ),
            ),
          ),
          const SizedBox(width: 12),

          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  craftsman.user?.name ?? 'صنايعي',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      craftsman.rating.toStringAsFixed(1) ?? '0.0',
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '(${craftsman.completedJobs ?? 0} عمل)',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                if (craftsman.isAvailable == true)
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'متاح الآن',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Actions
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.close, size: 20),
                onPressed: onClose,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: onTap,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  minimumSize: const Size(0, 36),
                ),
                child: const Text('عرض'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MapButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const _MapButton({
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(8),
      color: Colors.white,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          child: Icon(icon, color: Colors.grey[700]),
        ),
      ),
    );
  }
}
