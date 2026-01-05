import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

/// FREE Map Service using OpenStreetMap APIs
/// TODO: Switch to Google Maps when billing is ready
class MapService {
  static final MapService _instance = MapService._internal();
  factory MapService() => _instance;
  MapService._internal();

  // ============================================
  // NOMINATIM - Free Geocoding & Places Search
  // Rate limit: 1 request/second
  // ============================================

  static const String _nominatimBase = 'https://nominatim.openstreetmap.org';

  /// Search for places (like Google Places Autocomplete)
  /// FREE alternative to Google Places API
  Future<List<PlaceResult>> searchPlaces(String query, {LatLng? near}) async {
    // /* GOOGLE PLACES - COMMENTED FOR FUTURE USE
    // final response = await http.get(Uri.parse(
    //   'https://maps.googleapis.com/maps/api/place/autocomplete/json'
    //   '?input=$query&key=$GOOGLE_API_KEY'
    //   '${near != null ? '&location=${near.latitude},${near.longitude}' : ''}'
    // ));
    // */

    try {
      final queryParams = {
        'q': query,
        'format': 'json',
        'addressdetails': '1',
        'limit': '10',
        'countrycodes': 'eg', // Egypt
      };

      if (near != null) {
        queryParams['viewbox'] = _getViewbox(near);
        queryParams['bounded'] = '1';
      }

      final uri =
          Uri.parse('$_nominatimBase/search').replace(queryParameters: queryParams);

      final response = await http.get(uri, headers: {
        'User-Agent': 'Sana3y-App/1.0',
        'Accept-Language': 'ar,en',
      });

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data
            .map((item) => PlaceResult(
                  placeId: item['place_id'].toString(),
                  name: _extractName(item),
                  address: item['display_name'] ?? '',
                  location: LatLng(
                    double.parse(item['lat']),
                    double.parse(item['lon']),
                  ),
                  type: item['type'] ?? '',
                ))
            .toList();
      }
      return [];
    } catch (e) {
      print('Nominatim search error: $e');
      return [];
    }
  }

  String _extractName(Map<String, dynamic> item) {
    final address = item['address'] as Map<String, dynamic>?;
    if (address != null) {
      return address['amenity'] ??
          address['building'] ??
          address['road'] ??
          address['suburb'] ??
          item['display_name']?.split(',').first ??
          '';
    }
    return item['display_name']?.split(',').first ?? '';
  }

  /// Reverse Geocoding - Get address from coordinates
  /// FREE alternative to Google Geocoding API
  Future<String?> getAddressFromCoordinates(LatLng location) async {
    // /* GOOGLE GEOCODING - COMMENTED FOR FUTURE USE
    // final response = await http.get(Uri.parse(
    //   'https://maps.googleapis.com/maps/api/geocode/json'
    //   '?latlng=${location.latitude},${location.longitude}&key=$GOOGLE_API_KEY'
    // ));
    // */

    try {
      final uri =
          Uri.parse('$_nominatimBase/reverse').replace(queryParameters: {
        'lat': location.latitude.toString(),
        'lon': location.longitude.toString(),
        'format': 'json',
        'addressdetails': '1',
        'accept-language': 'ar',
      });

      final response = await http.get(uri, headers: {
        'User-Agent': 'Sana3y-App/1.0',
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return _formatArabicAddress(data['address']) ?? data['display_name'];
      }
      return null;
    } catch (e) {
      print('Reverse geocoding error: $e');
      return null;
    }
  }

  String? _formatArabicAddress(Map<String, dynamic>? address) {
    if (address == null) return null;
    final parts = <String>[];

    if (address['road'] != null) parts.add(address['road']);
    if (address['suburb'] != null) parts.add(address['suburb']);
    if (address['city_district'] != null) parts.add(address['city_district']);
    if (address['city'] != null) parts.add(address['city']);
    if (address['state'] != null) parts.add(address['state']);

    return parts.isNotEmpty ? parts.join('، ') : null;
  }

  /// Get coordinates from address
  Future<LatLng?> getCoordinatesFromAddress(String address) async {
    try {
      final results = await searchPlaces(address);
      if (results.isNotEmpty) {
        return results.first.location;
      }
      return null;
    } catch (e) {
      print('Geocoding error: $e');
      return null;
    }
  }

  String _getViewbox(LatLng center) {
    // Create a viewbox around the center point (roughly 50km)
    const offset = 0.5; // degrees
    return '${center.longitude - offset},${center.latitude - offset},'
        '${center.longitude + offset},${center.latitude + offset}';
  }

  // ============================================
  // OSRM - Free Routing & Distance
  // Public server or self-hosted
  // ============================================

  static const String _osrmBase = 'https://router.project-osrm.org';

  /// Get distance and duration between two points
  /// FREE alternative to Google Distance Matrix API
  Future<DistanceResult?> getDistance(LatLng origin, LatLng destination) async {
    // /* GOOGLE DISTANCE MATRIX - COMMENTED FOR FUTURE USE
    // final response = await http.get(Uri.parse(
    //   'https://maps.googleapis.com/maps/api/distancematrix/json'
    //   '?origins=${origin.latitude},${origin.longitude}'
    //   '&destinations=${destination.latitude},${destination.longitude}'
    //   '&key=$GOOGLE_API_KEY'
    // ));
    // */

    try {
      final uri = Uri.parse('$_osrmBase/route/v1/driving/'
          '${origin.longitude},${origin.latitude};'
          '${destination.longitude},${destination.latitude}'
          '?overview=false');

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['routes'] != null && data['routes'].isNotEmpty) {
          final route = data['routes'][0];
          return DistanceResult(
            distanceMeters: (route['distance'] as num).toDouble(),
            durationSeconds: (route['duration'] as num).toDouble(),
            distanceText: _formatDistance((route['distance'] as num).toDouble()),
            durationText: _formatDuration((route['duration'] as num).toDouble()),
          );
        }
      }
      return null;
    } catch (e) {
      print('OSRM distance error: $e');
      return null;
    }
  }

  /// Get route polyline between two points
  /// FREE alternative to Google Directions API
  Future<RouteResult?> getRoute(LatLng origin, LatLng destination) async {
    // /* GOOGLE DIRECTIONS - COMMENTED FOR FUTURE USE
    // final response = await http.get(Uri.parse(
    //   'https://maps.googleapis.com/maps/api/directions/json'
    //   '?origin=${origin.latitude},${origin.longitude}'
    //   '&destination=${destination.latitude},${destination.longitude}'
    //   '&key=$GOOGLE_API_KEY'
    // ));
    // */

    try {
      final uri = Uri.parse('$_osrmBase/route/v1/driving/'
          '${origin.longitude},${origin.latitude};'
          '${destination.longitude},${destination.latitude}'
          '?overview=full&geometries=geojson&steps=true');

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['routes'] != null && data['routes'].isNotEmpty) {
          final route = data['routes'][0];
          final geometry = route['geometry']['coordinates'] as List;

          return RouteResult(
            distanceMeters: (route['distance'] as num).toDouble(),
            durationSeconds: (route['duration'] as num).toDouble(),
            polylinePoints: geometry
                .map((coord) => LatLng(
                      (coord[1] as num).toDouble(),
                      (coord[0] as num).toDouble(),
                    ))
                .toList(),
          );
        }
      }
      return null;
    } catch (e) {
      print('OSRM routing error: $e');
      return null;
    }
  }

  String _formatDistance(double meters) {
    if (meters >= 1000) {
      return '${(meters / 1000).toStringAsFixed(1)} كم';
    }
    return '${meters.round()} م';
  }

  String _formatDuration(double seconds) {
    final minutes = (seconds / 60).round();
    if (minutes >= 60) {
      final hours = minutes ~/ 60;
      final mins = minutes % 60;
      return '$hours ساعة${mins > 0 ? ' و $mins دقيقة' : ''}';
    }
    return '$minutes دقيقة';
  }
}

// ============================================
// Data Models
// ============================================

class PlaceResult {
  final String placeId;
  final String name;
  final String address;
  final LatLng location;
  final String type;

  PlaceResult({
    required this.placeId,
    required this.name,
    required this.address,
    required this.location,
    this.type = '',
  });
}

class RouteResult {
  final double distanceMeters;
  final double durationSeconds;
  final List<LatLng> polylinePoints;

  RouteResult({
    required this.distanceMeters,
    required this.durationSeconds,
    required this.polylinePoints,
  });

  String get distanceText {
    if (distanceMeters >= 1000) {
      return '${(distanceMeters / 1000).toStringAsFixed(1)} كم';
    }
    return '${distanceMeters.round()} م';
  }

  String get durationText {
    final minutes = (durationSeconds / 60).round();
    if (minutes >= 60) {
      final hours = minutes ~/ 60;
      final mins = minutes % 60;
      return '$hours ساعة${mins > 0 ? ' و $mins دقيقة' : ''}';
    }
    return '$minutes دقيقة';
  }
}

class DistanceResult {
  final double distanceMeters;
  final double durationSeconds;
  final String distanceText;
  final String durationText;

  DistanceResult({
    required this.distanceMeters,
    required this.durationSeconds,
    required this.distanceText,
    required this.durationText,
  });
}
