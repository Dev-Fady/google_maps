import 'package:flutter/material.dart';
import 'package:google_maps/constants/map_constants.dart';
import 'package:google_maps/services/map_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomGoogleMapWidget extends StatefulWidget {
  final Function(GoogleMapController)? onMapCreated;
  final Set<Marker>? initialMarkers;
  
  const CustomGoogleMapWidget({
    super.key,
    this.onMapCreated,
    this.initialMarkers,
  });

  @override
  State<CustomGoogleMapWidget> createState() => _CustomGoogleMapWidgetState();
}

class _CustomGoogleMapWidgetState extends State<CustomGoogleMapWidget> {
  late GoogleMapController _googleMapController;
  final MapService _mapService = MapService();
  Set<Marker> _markers = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeMarkers();
  }

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  Future<void> _initializeMarkers() async {
    try {
      final markers = await _mapService.initMarkers();
      setState(() {
        _markers = markers;
        _isLoading = false;
      });
    } catch (e) {
      print('Error initializing markers: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    _googleMapController = controller;
    _mapService.initMapStyle(context, controller);
    widget.onMapCreated?.call(controller);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return GoogleMap(
      zoomControlsEnabled: false,
      markers: widget.initialMarkers ?? _markers,
      // mapType: MapType.terrain,
      onMapCreated: _onMapCreated,
      initialCameraPosition: MapConstants.initialCameraPosition,
      // cameraTargetBounds: CameraTargetBounds(
      //   MapUtils.fixLatLngBounds(
      //     MapConstants.boundaryPoint1,
      //     MapConstants.boundaryPoint2,
      //   ),
      // ),
    );
  }
}