import axios from 'axios';

/**
 * FREE Location Service using OpenStreetMap APIs
 * TODO: Switch to Google Maps APIs when billing is ready
 *
 * Uses:
 * - Nominatim for geocoding/reverse geocoding (FREE, 1 req/sec)
 * - OSRM for routing/distance calculation (FREE)
 *
 * Note: MongoDB geospatial queries are used for nearby search (also FREE)
 */
class LocationService {
  private readonly nominatimBase = 'https://nominatim.openstreetmap.org';
  private readonly osrmBase = 'https://router.project-osrm.org';
  private lastRequestTime = 0;

  /**
   * Rate limit for Nominatim (1 request per second)
   */
  private async respectRateLimit(): Promise<void> {
    const now = Date.now();
    const timeSinceLastRequest = now - this.lastRequestTime;
    if (timeSinceLastRequest < 1000) {
      await new Promise((resolve) => setTimeout(resolve, 1000 - timeSinceLastRequest));
    }
    this.lastRequestTime = Date.now();
  }

  /**
   * Search for places using Nominatim
   * FREE alternative to Google Places API
   */
  async searchPlaces(
    query: string,
    options: {
      lat?: number;
      lng?: number;
      limit?: number;
      countryCode?: string;
    } = {}
  ): Promise<PlaceResult[]> {
    /* GOOGLE PLACES - COMMENTED FOR FUTURE USE
    const response = await axios.get(
      'https://maps.googleapis.com/maps/api/place/autocomplete/json',
      { params: { input: query, key: GOOGLE_API_KEY } }
    );
    */

    try {
      await this.respectRateLimit();

      const params: Record<string, string> = {
        q: query,
        format: 'json',
        addressdetails: '1',
        limit: (options.limit || 10).toString(),
        countrycodes: options.countryCode || 'eg',
      };

      if (options.lat && options.lng) {
        const offset = 0.5;
        params.viewbox = `${options.lng - offset},${options.lat - offset},${options.lng + offset},${options.lat + offset}`;
        params.bounded = '1';
      }

      const response = await axios.get(`${this.nominatimBase}/search`, {
        params,
        headers: {
          'User-Agent': 'Sana3y-Backend/1.0',
          'Accept-Language': 'ar,en',
        },
      });

      return response.data.map((item: NominatimResult) => ({
        placeId: item.place_id.toString(),
        name: this.extractName(item),
        address: item.display_name || '',
        lat: parseFloat(item.lat),
        lng: parseFloat(item.lon),
        type: item.type || '',
      }));
    } catch (error) {
      console.error('Nominatim search error:', error);
      return [];
    }
  }

  /**
   * Get address from coordinates (Reverse Geocoding)
   * FREE alternative to Google Geocoding API
   */
  async getAddressFromCoordinates(lat: number, lng: number): Promise<string | null> {
    /* GOOGLE GEOCODING - COMMENTED FOR FUTURE USE
    const response = await axios.get(
      'https://maps.googleapis.com/maps/api/geocode/json',
      { params: { latlng: `${lat},${lng}`, key: GOOGLE_API_KEY } }
    );
    */

    try {
      await this.respectRateLimit();

      const response = await axios.get(`${this.nominatimBase}/reverse`, {
        params: {
          lat: lat.toString(),
          lon: lng.toString(),
          format: 'json',
          addressdetails: '1',
          'accept-language': 'ar',
        },
        headers: {
          'User-Agent': 'Sana3y-Backend/1.0',
        },
      });

      const data = response.data;
      return this.formatArabicAddress(data.address) || data.display_name || null;
    } catch (error) {
      console.error('Reverse geocoding error:', error);
      return null;
    }
  }

  /**
   * Get coordinates from address (Forward Geocoding)
   * FREE alternative to Google Geocoding API
   */
  async getCoordinatesFromAddress(address: string): Promise<{ lat: number; lng: number } | null> {
    try {
      const results = await this.searchPlaces(address, { limit: 1 });
      if (results.length > 0) {
        return { lat: results[0].lat, lng: results[0].lng };
      }
      return null;
    } catch (error) {
      console.error('Geocoding error:', error);
      return null;
    }
  }

  /**
   * Get distance and duration between two points using OSRM
   * FREE alternative to Google Distance Matrix API
   */
  async getDistance(
    originLat: number,
    originLng: number,
    destLat: number,
    destLng: number
  ): Promise<DistanceResult | null> {
    /* GOOGLE DISTANCE MATRIX - COMMENTED FOR FUTURE USE
    const response = await axios.get(
      'https://maps.googleapis.com/maps/api/distancematrix/json',
      {
        params: {
          origins: `${originLat},${originLng}`,
          destinations: `${destLat},${destLng}`,
          key: GOOGLE_API_KEY,
        },
      }
    );
    */

    try {
      const response = await axios.get(
        `${this.osrmBase}/route/v1/driving/${originLng},${originLat};${destLng},${destLat}`,
        { params: { overview: 'false' } }
      );

      if (response.data.routes && response.data.routes.length > 0) {
        const route = response.data.routes[0];
        return {
          distanceMeters: route.distance,
          durationSeconds: route.duration,
          distanceText: this.formatDistance(route.distance),
          durationText: this.formatDuration(route.duration),
        };
      }
      return null;
    } catch (error) {
      console.error('OSRM distance error:', error);
      return null;
    }
  }

  /**
   * Get route with polyline between two points using OSRM
   * FREE alternative to Google Directions API
   */
  async getRoute(
    originLat: number,
    originLng: number,
    destLat: number,
    destLng: number
  ): Promise<RouteResult | null> {
    /* GOOGLE DIRECTIONS - COMMENTED FOR FUTURE USE
    const response = await axios.get(
      'https://maps.googleapis.com/maps/api/directions/json',
      {
        params: {
          origin: `${originLat},${originLng}`,
          destination: `${destLat},${destLng}`,
          key: GOOGLE_API_KEY,
        },
      }
    );
    */

    try {
      const response = await axios.get(
        `${this.osrmBase}/route/v1/driving/${originLng},${originLat};${destLng},${destLat}`,
        { params: { overview: 'full', geometries: 'geojson', steps: 'true' } }
      );

      if (response.data.routes && response.data.routes.length > 0) {
        const route = response.data.routes[0];
        const coordinates = route.geometry.coordinates;

        return {
          distanceMeters: route.distance,
          durationSeconds: route.duration,
          polylinePoints: coordinates.map((coord: number[]) => ({
            lat: coord[1],
            lng: coord[0],
          })),
        };
      }
      return null;
    } catch (error) {
      console.error('OSRM routing error:', error);
      return null;
    }
  }

  /**
   * Calculate straight-line distance between two points (Haversine formula)
   * No API call needed - pure calculation
   */
  calculateHaversineDistance(
    lat1: number,
    lng1: number,
    lat2: number,
    lng2: number
  ): number {
    const R = 6371; // Earth's radius in km
    const dLat = this.toRad(lat2 - lat1);
    const dLng = this.toRad(lng2 - lng1);
    const a =
      Math.sin(dLat / 2) * Math.sin(dLat / 2) +
      Math.cos(this.toRad(lat1)) *
        Math.cos(this.toRad(lat2)) *
        Math.sin(dLng / 2) *
        Math.sin(dLng / 2);
    const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
    return R * c; // Distance in km
  }

  private toRad(deg: number): number {
    return deg * (Math.PI / 180);
  }

  private extractName(item: NominatimResult): string {
    if (item.address) {
      return (
        item.address.amenity ||
        item.address.building ||
        item.address.road ||
        item.address.suburb ||
        item.display_name?.split(',')[0] ||
        ''
      );
    }
    return item.display_name?.split(',')[0] || '';
  }

  private formatArabicAddress(address: NominatimAddress | undefined): string | null {
    if (!address) return null;
    const parts: string[] = [];

    if (address.road) parts.push(address.road);
    if (address.suburb) parts.push(address.suburb);
    if (address.city_district) parts.push(address.city_district);
    if (address.city) parts.push(address.city);
    if (address.state) parts.push(address.state);

    return parts.length > 0 ? parts.join('، ') : null;
  }

  private formatDistance(meters: number): string {
    if (meters >= 1000) {
      return `${(meters / 1000).toFixed(1)} كم`;
    }
    return `${Math.round(meters)} م`;
  }

  private formatDuration(seconds: number): string {
    const minutes = Math.round(seconds / 60);
    if (minutes >= 60) {
      const hours = Math.floor(minutes / 60);
      const mins = minutes % 60;
      return `${hours} ساعة${mins > 0 ? ` و ${mins} دقيقة` : ''}`;
    }
    return `${minutes} دقيقة`;
  }
}

// ============================================
// Types
// ============================================

interface NominatimResult {
  place_id: number;
  display_name: string;
  lat: string;
  lon: string;
  type?: string;
  address?: NominatimAddress;
}

interface NominatimAddress {
  amenity?: string;
  building?: string;
  road?: string;
  suburb?: string;
  city_district?: string;
  city?: string;
  state?: string;
  country?: string;
}

interface PlaceResult {
  placeId: string;
  name: string;
  address: string;
  lat: number;
  lng: number;
  type: string;
}

interface DistanceResult {
  distanceMeters: number;
  durationSeconds: number;
  distanceText: string;
  durationText: string;
}

interface RouteResult {
  distanceMeters: number;
  durationSeconds: number;
  polylinePoints: Array<{ lat: number; lng: number }>;
}

export default new LocationService();
export { PlaceResult, DistanceResult, RouteResult };
