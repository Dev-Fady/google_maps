import 'package:flutter/material.dart';
import 'package:google_maps/widget/custom_google_map_widget.dart';
// import 'package:google_maps/widget/location_change_button.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Map'), centerTitle: true),
      body: Stack(
        children: [
          const CustomGoogleMapWidget(),
          // LocationChangeButton(
          //   // onPressed: () {
          //   //   // Controller will be passed from the widget
          //   // },
          // ),
        ],
      ),
    );
  }
}
