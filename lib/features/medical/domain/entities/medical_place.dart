import 'package:google_maps_flutter/google_maps_flutter.dart';

enum MedicalType { hospital, clinic, pharmacy }

class MedicalPlaceEntity {
  final String id;
  final String name;
  final MedicalType type;
  final LatLng location;
  final String address;
  final double distance;
  final double rating;
  final bool isOpen;

  const MedicalPlaceEntity({
    required this.id,
    required this.name,
    required this.type,
    required this.location,
    required this.address,
    required this.distance,
    required this.rating,
    required this.isOpen,
  });
}
