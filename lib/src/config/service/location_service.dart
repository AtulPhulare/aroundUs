import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../logger/logger.dart';

class LocationService {
  static const String keyLatitude = 'latitude';
  static const String keyLongitude = 'longitude';
  static const String keyCity = 'city';
  static const String keyCountry = 'country';

  static Future<void> fetchAndStoreLocation() async {
    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        logService.w("Location services are disabled");
        throw Exception("Location services are disabled");
      }

      // Check permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          logService.w("Location permission denied");
          throw Exception("Location permission denied");
        }
      }

      if (permission == LocationPermission.deniedForever) {
        logService.w("Location permission permanently denied");
        throw Exception("Location permission permanently denied");
      }

      // Get current position
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );

      // Get address from coordinates
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      String city = placemarks.isNotEmpty
          ? (placemarks.first.locality ?? "Unknown")
          : "Unknown";
      String country = placemarks.isNotEmpty
          ? (placemarks.first.country ?? "Unknown")
          : "Unknown";

      // Store in SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setDouble(keyLatitude, position.latitude);
      await prefs.setDouble(keyLongitude, position.longitude);
      await prefs.setString(keyCity, city);
      await prefs.setString(keyCountry, country);

      logService.i(
        "Location saved: $city, $country [${position.latitude}, ${position.longitude}]",
      );
    } catch (e, stack) {
      logService.e("Error while fetching location", e, stack);
      rethrow; // Important: rethrow so the controller can handle it
    }
  }

  static Future<Map<String, dynamic>?> getStoredLocation() async {
    final prefs = await SharedPreferences.getInstance();
    final lat = prefs.getDouble(keyLatitude);
    final lon = prefs.getDouble(keyLongitude);
    final city = prefs.getString(keyCity);
    final country = prefs.getString(keyCountry);

    if (lat == null || lon == null) {
      logService.w("No stored location found");
      return null;
    }

    return {
      "latitude": lat,
      "longitude": lon,
      "city": city ?? "Unknown",
      "country": country ?? "Unknown",
    };
  }

  static Future<void> clearStoredLocation() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(keyLatitude);
      await prefs.remove(keyLongitude);
      await prefs.remove(keyCity);
      await prefs.remove(keyCountry);

      logService.i("Stored location data cleared successfully");
    } catch (e, stack) {
      logService.e("Error while clearing stored location", e, stack);
    }
  }
}
