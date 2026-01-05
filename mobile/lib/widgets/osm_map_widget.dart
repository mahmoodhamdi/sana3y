import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../config/constants.dart';

/// FREE OpenStreetMap Widget
/// TODO: Switch to Google Maps when billing is ready
class OSMMapWidget extends StatefulWidget {
  final LatLng? initialCenter;
  final double initialZoom;
  final List<MapMarkerData>? markers;
  final Function(LatLng)? onTap;
  final Function(LatLng)? onLongPress;
  final bool showUserLocation;
  final LatLng? userLocation;
  final bool showZoomButtons;
  final bool showMyLocationButton;
  final Function()? onMyLocationPressed;
  final MapController? mapController;

  const OSMMapWidget({
    super.key,
    this.initialCenter,
    this.initialZoom = 14.0,
    this.markers,
    this.onTap,
    this.onLongPress,
    this.showUserLocation = true,
    this.userLocation,
    this.showZoomButtons = true,
    this.showMyLocationButton = true,
    this.onMyLocationPressed,
    this.mapController,
  });

  @override
  State<OSMMapWidget> createState() => _OSMMapWidgetState();
}

class _OSMMapWidgetState extends State<OSMMapWidget> {
  late final MapController _mapController;

  @override
  void initState() {
    super.initState();
    _mapController = widget.mapController ?? MapController();
  }

  @override
  Widget build(BuildContext context) {
    // /* GOOGLE MAPS - COMMENTED FOR FUTURE USE
    // return GoogleMap(
    //   initialCameraPosition: CameraPosition(
    //     target: LatLng(widget.initialCenter?.latitude ?? 30.4522,
    //                    widget.initialCenter?.longitude ?? 30.9667),
    //     zoom: widget.initialZoom,
    //   ),
    //   markers: widget.markers?.map((m) => Marker(
    //     markerId: MarkerId(m.id),
    //     position: LatLng(m.position.latitude, m.position.longitude),
    //     infoWindow: InfoWindow(title: m.title),
    //   )).toSet() ?? {},
    //   onTap: widget.onTap != null ? (pos) => widget.onTap!(LatLng(pos.latitude, pos.longitude)) : null,
    //   myLocationEnabled: widget.showUserLocation,
    //   myLocationButtonEnabled: widget.showMyLocationButton,
    // );
    // */

    final center = widget.initialCenter ??
        LatLng(AppConstants.defaultLatitude, AppConstants.defaultLongitude);

    return Stack(
      children: [
        FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            initialCenter: center,
            initialZoom: widget.initialZoom,
            onTap: widget.onTap != null
                ? (tapPosition, point) => widget.onTap!(point)
                : null,
            onLongPress: widget.onLongPress != null
                ? (tapPosition, point) => widget.onLongPress!(point)
                : null,
          ),
          children: [
            // OpenStreetMap Tile Layer (FREE)
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.sana3y.app',
              maxZoom: 19,
            ),

            // User Location Marker
            if (widget.showUserLocation && widget.userLocation != null)
              MarkerLayer(
                markers: [
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
                ],
              ),

            // Custom Markers
            if (widget.markers != null && widget.markers!.isNotEmpty)
              MarkerLayer(
                markers: widget.markers!.map((markerData) {
                  return Marker(
                    point: markerData.position,
                    width: markerData.width ?? 40,
                    height: markerData.height ?? 40,
                    child: GestureDetector(
                      onTap: markerData.onTap,
                      child: markerData.child ??
                          Icon(
                            Icons.location_pin,
                            color: markerData.color ?? Colors.red,
                            size: 40,
                          ),
                    ),
                  );
                }).toList(),
              ),
          ],
        ),

        // Zoom Buttons
        if (widget.showZoomButtons)
          Positioned(
            right: 16,
            bottom: 100,
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
              ],
            ),
          ),

        // My Location Button
        if (widget.showMyLocationButton)
          Positioned(
            right: 16,
            bottom: 40,
            child: _MapButton(
              icon: Icons.my_location,
              onPressed: widget.onMyLocationPressed ??
                  () {
                    if (widget.userLocation != null) {
                      _mapController.move(widget.userLocation!, 15);
                    }
                  },
            ),
          ),
      ],
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

/// Data class for map markers
class MapMarkerData {
  final String id;
  final LatLng position;
  final String? title;
  final String? snippet;
  final Color? color;
  final Widget? child;
  final double? width;
  final double? height;
  final VoidCallback? onTap;

  MapMarkerData({
    required this.id,
    required this.position,
    this.title,
    this.snippet,
    this.color,
    this.child,
    this.width,
    this.height,
    this.onTap,
  });
}
