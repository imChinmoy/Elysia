import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

class LatLngConverter
    implements JsonConverter<LatLng, Map<String, dynamic>?> {
  const LatLngConverter();

  @override
  LatLng fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw Exception('Location is null');
    }

    final lat = json['lat'] ?? json['latitude'];
    final lng = json['lng'] ?? json['longitude'];

    if (lat == null || lng == null) {
      throw Exception('Invalid LatLng json: $json');
    }

    return LatLng(
      (lat as num).toDouble(),
      (lng as num).toDouble(),
    );
  }

  @override
  Map<String, dynamic> toJson(LatLng object) {
    return {
      'latitude': object.latitude,
      'longitude': object.longitude,
    };
  }
}
