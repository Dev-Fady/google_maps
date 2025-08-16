import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapUtils {
  /// Fix map bounds by ordering points correctly
  static LatLngBounds fixLatLngBounds(LatLng point1, LatLng point2) {
    double southLat = point1.latitude < point2.latitude
        ? point1.latitude
        : point2.latitude;
    double westLng = point1.longitude < point2.longitude
        ? point1.longitude
        : point2.longitude;

    double northLat = point1.latitude > point2.latitude
        ? point1.latitude
        : point2.latitude;
    double eastLng = point1.longitude > point2.longitude
        ? point1.longitude
        : point2.longitude;

    return LatLngBounds(
      southwest: LatLng(southLat, westLng),
      northeast: LatLng(northLat, eastLng),
    );
  }

/*  // /// Calculate distance between two points (in kilometers)
  // static double calculateDistance(LatLng point1, LatLng point2) {
  //   const double earthRadius = 6371; // Earth radius in kilometers
    
  //   double lat1Rad = point1.latitude * (3.14159 / 180);
  //   double lon1Rad = point1.longitude * (3.14159 / 180);
  //   double lat2Rad = point2.latitude * (3.14159 / 180);
  //   double lon2Rad = point2.longitude * (3.14159 / 180);

  //   double dLat = lat2Rad - lat1Rad;
  //   double dLon = lon2Rad - lon1Rad;

  //   // double a = (dLat / 2).sin() * (dLat / 2).sin() +
  //   //     lat1Rad.cos() * lat2Rad.cos() * (dLon / 2).sin() * (dLon / 2).sin();
    
  //   // double c = 2 * (a.sqrt()).asin();
    
  //   return earthRadius * c;
  // }
  // */

  /// Get center point between two points
  static LatLng getCenterPoint(LatLng point1, LatLng point2) {
    double centerLat = (point1.latitude + point2.latitude) / 2;
    double centerLng = (point1.longitude + point2.longitude) / 2;
    
    return LatLng(centerLat, centerLng);
  }

  /// Validate location coordinates
  static bool isValidLatLng(double latitude, double longitude) {
    return latitude >= -90 && 
           latitude <= 90 && 
           longitude >= -180 && 
           longitude <= 180;
  }

  /// Get appropriate zoom level based on distance
  static double getZoomLevelFromDistance(double distanceInKm) {
    if (distanceInKm > 1000) return 6;  // Country view
    if (distanceInKm > 100) return 9;   // Region view
    if (distanceInKm > 10) return 11;   // City view
    if (distanceInKm > 1) return 14;    // Street view
    return 17; // Building view
  }

  /// Convert degrees to radians
  static double degreesToRadians(double degrees) {
    return degrees * (3.14159 / 180);
  }

  /// Convert radians to degrees
  static double radiansToDegrees(double radians) {
    return radians * (180 / 3.14159);
  }
}