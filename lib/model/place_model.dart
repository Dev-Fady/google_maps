import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceModel {
  final int id;
  final String name;
  final LatLng latLng;

  PlaceModel({required this.id, required this.name, required this.latLng});
}

List<PlaceModel> places = [
  PlaceModel(
    id: 1,
    name: 'متحف سوهاج القومي',
    latLng: LatLng(26.562348737464855, 31.706018327674293),
  ),
  PlaceModel(
    id: 2,
    name: 'جزيرة قرمان',
    latLng: LatLng(26.57660517246185, 31.701043822298562),
  ),
  PlaceModel(
    id: 3,
    name: 'دير الأنبا توماس السائح بنجع أولاد صالح',
    latLng: LatLng(26.67511627824856, 31.701089816229416),
  ),
  PlaceModel(
    id: 4,
    name: 'Crinkle',
    latLng: LatLng(29.320038950676324, 30.885264669559987),
  ),
];
