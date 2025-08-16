import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps/model/place_model.dart';
import '../utils/marker_utils.dart';

class MapService {
  
  /// Apply night map style
  Future<void> initMapStyle(BuildContext context, GoogleMapController controller) async {
    try {
      final nightMapStyle = await DefaultAssetBundle.of(context)
          .loadString("assets/map_styles/night_map_style.json");
      await controller.setMapStyle(nightMapStyle);
    } catch (e) {
      print('Error loading map style: $e');
    }
  }

  /// Initialize markers on the map
  Future<Set<Marker>> initMarkers() async {
    try {
      final customMarkerIcon = await _createCustomMarkerIcon();
      
      final markers = places.map(
        (place) => Marker(
          markerId: MarkerId(place.id.toString()),
          position: place.latLng,
          infoWindow: InfoWindow(title: place.name),
          icon: customMarkerIcon,
        ),
      ).toSet();

      return markers;
    } catch (e) {
      print('Error creating markers: $e');
      return <Marker>{};
    }
  }

  /// Create custom marker icon
  Future<BitmapDescriptor> _createCustomMarkerIcon() async {
    return await BitmapDescriptor.asset(
      const ImageConfiguration(size: Size(50, 50), devicePixelRatio: 2),
      'assets/icons/marker.png',
    );
  }

  /// Create icon from raw data (alternative method)
  Future<BitmapDescriptor> createMarkerFromRawData(String imagePath, double width) async {
    final imageData = await MarkerUtils.getImageFromRawData(imagePath, width);
    return BitmapDescriptor.bytes(imageData);
  }

  /// Create colored marker (alternative method)
  Future<BitmapDescriptor> createColoredMarker(double hue) async {
    return BitmapDescriptor.defaultMarkerWithHue(hue);
  }

  /// Add new marker
  Future<Marker> createMarker({
    required String id,
    required LatLng position,
    String? title,
    String? snippet,
    BitmapDescriptor? icon,
  }) async {
    final markerIcon = icon ?? await _createCustomMarkerIcon();
    
    return Marker(
      markerId: MarkerId(id),
      position: position,
      infoWindow: InfoWindow(
        title: title,
        snippet: snippet,
      ),
      icon: markerIcon,
    );
  }

  /// Animate camera to specific location
  Future<void> animateToLocation(
    GoogleMapController controller,
    LatLng target, {
    double zoom = 12,
  }) async {
    final cameraPosition = CameraPosition(
      target: target,
      zoom: zoom,
    );
    
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(cameraPosition),
    );
  }
}