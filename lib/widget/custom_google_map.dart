import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps/model/place_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;

class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({super.key});

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  late CameraPosition initialCameraPosition;
  late GoogleMapController googleMapController;
  @override
  void initState() {
    super.initState();
    initialCameraPosition = CameraPosition(
      zoom: 11,
      target: LatLng(26.558765822863013, 31.696653189407332),
    );
    initMarkers();
    //! initMapStyle();
  }

  @override
  void dispose() {
    super.dispose();
    googleMapController.dispose();
  }

  Set<Marker> markers = {};
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          zoomControlsEnabled: false,
          markers: markers,
          mapType: MapType.terrain,
          onMapCreated: (controller) {
            googleMapController = controller;
            initMapStyle();
          },
          // cameraTargetBounds: CameraTargetBounds(
          //   fixLatLngBounds(
          //     LatLng(27.183877589838243, 31.180285778995984),
          //     LatLng(26.160958736939453, 32.71255166309634),
          //   ),
          // ),
          initialCameraPosition: initialCameraPosition,
        ),
        Positioned(
          bottom: 16,
          left: 16,
          right: 16,
          child: ElevatedButton(
            onPressed: () {
              CameraPosition newLoaction = CameraPosition(
                target: LatLng(26.048756360339567, 32.32866193533733),
                zoom: 12,
              );
              googleMapController.animateCamera(
                CameraUpdate.newCameraPosition(newLoaction),
              );
            },
            child: Text("Change loaction"),
          ),
        ),
      ],
    );
  }

  LatLngBounds fixLatLngBounds(LatLng point1, LatLng point2) {
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

  Future<void> initMapStyle() async {
    var nightMapStyle = await DefaultAssetBundle.of(
      context,
    ).loadString("assets/map_styles/night_map_style.json");
    googleMapController.setMapStyle(nightMapStyle);
  }

  Future<Uint8List> getImageFromRawData(String image, double width) async {
    var imageData = await rootBundle.load(image);
    var imageCodec = await ui.instantiateImageCodec(
      imageData.buffer.asUint8List(),
      targetWidth: width.round(),
    );
    var imageFrame = await imageCodec.getNextFrame();
    var imageByDate = await imageFrame.image.toByteData(
      format: ui.ImageByteFormat.png,
    );

    return imageByDate!.buffer.asUint8List();
  }

  Future<void> initMarkers() async {
    // var myMarker = Marker(
    //   markerId: MarkerId("marker1"),
    //   position: LatLng(26.558765822863013, 31.696653189407332),
    // );
    // markers.add(myMarker);

    var customMarkerIcon = await BitmapDescriptor.asset(
      ImageConfiguration(size: Size(50, 50), devicePixelRatio: 2),
      'assets/icons/marker.png',
    );

    // var customMarkerIcon = BitmapDescriptor.bytes(
    //   await getImageFromRawData('assets/icons/marker.png', 50),
    // );

    // var customMarkerIcon = await BitmapDescriptor.defaultMarkerWithHue(
    //   BitmapDescriptor.hueViolet,
    // );
    List<Marker> myMarker = places
        .map(
          (place) => Marker(
            markerId: MarkerId(place.id.toString()),
            position: place.latLng,
            infoWindow: InfoWindow(title: place.name),
            icon: customMarkerIcon,
          ),
        )
        .toList();
    markers.addAll(myMarker);
    setState(() {});
  }
}

// ~ zoom
//^ world view 0 => 3
//^ country view 4 => 6
//^ city view 10 => 12
//^ street view 13 => 17
//^ building view 18 => 20
