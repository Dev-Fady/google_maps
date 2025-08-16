import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../constants/map_constants.dart';

class LocationChangeButton extends StatefulWidget {
  final GoogleMapController? controller;
  final VoidCallback? onPressed;

  const LocationChangeButton({
    super.key,
    this.controller,
    this.onPressed,
  });

  @override
  State<LocationChangeButton> createState() => _LocationChangeButtonState();
}

class _LocationChangeButtonState extends State<LocationChangeButton> {
  void _changeLocation() {
    if (widget.controller != null) {
      widget.controller!.animateCamera(
        CameraUpdate.newCameraPosition(MapConstants.newLocationCameraPosition),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 16,
      left: 16,
      right: 16,
      child: ElevatedButton(
        onPressed: _changeLocation,
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          "Change Location",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}