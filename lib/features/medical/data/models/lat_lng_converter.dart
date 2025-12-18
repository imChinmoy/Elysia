import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

class LatLngConverter
    implements JsonConverter<LatLng, Map<String, dynamic>> {
  const LatLngConverter();

  @override
  LatLng fromJson(Map<String, dynamic> json) {
    return LatLng(
      (json['lat'] as num).toDouble(),
      (json['lng'] as num).toDouble(),
    );
  }

  @override
  Map<String, dynamic> toJson(LatLng object) {
    return {
      'lat': object.latitude,
      'lng': object.longitude,
    };
  }
}
