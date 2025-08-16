import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';

class PolylineModel {
  final String id;
  final List<LatLng> points;
  final Color? color;
  final int? width;
  // final List<PatternItem> patterns;
  final int? zIndex;
  final Cap? startCap;
  final Cap? endCap;

  PolylineModel({
    required this.id,
    required this.points,
    this.color,
    this.width,
    // this.patterns,
    this.zIndex,
    this.startCap,
    this.endCap,
  });

  Polyline toPolyline() {
    return Polyline(
      polylineId: PolylineId(id),
      points: points,
      startCap: startCap ?? Cap.buttCap,
      endCap: endCap ?? Cap.roundCap,
      geodesic: true,
      zIndex:zIndex?? 1,
      color: color ?? Colors.blue,
      width: width ?? 6,
    );
  }
}

List<PolylineModel> myPolylines = [
  PolylineModel(
    id: "route1",
    points: [
      LatLng(26.562348737464855, 31.706018327674293), // متحف سوهاج القومي
      LatLng(26.57660517246185, 31.701043822298562), // جزيرة قرمان
      LatLng(26.67511627824856, 31.701089816229416), // دير الأنبا توماس
    ],
  ),
  PolylineModel(
    id: "route2",
    points: [
      LatLng(26.57660517246185, 31.701043822298562),
      LatLng(29.320038950676324, 30.885264669559987), // Crinkle
    ],
    color: Colors.red,
    width: 6,
    // patterns: [PatternItem.dash(20), PatternItem.gap(10)],
  ),
  PolylineModel(
    id: "route3",
    points: [
      LatLng(26.55791713251553, 31.709282582237208),
      LatLng(26.560261341818148, 31.710265370775954),
      LatLng(26.567791789778564, 31.707579082103393),
      LatLng(26.56219527838754, 31.721207082913082),
    ],
    color: Colors.green,
    width: 6,
    startCap: Cap.roundCap,
    endCap: Cap.roundCap,
    zIndex: 1,
  ),
];
