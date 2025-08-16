import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapConstants {
  // Basic locations
  static const LatLng soHagCenter = LatLng(26.558765822863013, 31.696653189407332);
  static const LatLng newLocation = LatLng(26.048756360339567, 32.32866193533733);
  
  // Map boundary points
  static const LatLng boundaryPoint1 = LatLng(27.183877589838243, 31.180285778995984);
  static const LatLng boundaryPoint2 = LatLng(26.160958736939453, 32.71255166309634);
  
  // Initial camera settings
  static const CameraPosition initialCameraPosition = CameraPosition(
    zoom: 11,
    target: soHagCenter,
  );
  
  // Camera position for new location
  static const CameraPosition newLocationCameraPosition = CameraPosition(
    target: newLocation,
    zoom: 12,
  );
  
  // Zoom levels
  static const double worldViewZoomMin = 0;
  static const double worldViewZoomMax = 3;
  static const double countryViewZoomMin = 4;
  static const double countryViewZoomMax = 6;
  static const double cityViewZoomMin = 10;
  static const double cityViewZoomMax = 12;
  static const double streetViewZoomMin = 13;
  static const double streetViewZoomMax = 17;
  static const double buildingViewZoomMin = 18;
  static const double buildingViewZoomMax = 20;
  
  // Asset paths
  static const String nightMapStylePath = "assets/map_styles/night_map_style.json";
  static const String customMarkerIconPath = 'assets/icons/marker.png';
  
  // Marker sizes
  static const double defaultMarkerWidth = 50;
  static const double defaultMarkerHeight = 50;
  static const double defaultDevicePixelRatio = 2;

  static var markerSize;
}