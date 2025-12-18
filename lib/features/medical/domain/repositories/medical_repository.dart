import 'package:client/features/medical/data/repositories/medical_repositoy_impl.dart';
import 'package:client/features/medical/domain/entities/medical_place.dart';
import 'package:client/features/medical/domain/entities/position_entity.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class MedicalRepository {
  Future<Position> getCurrentLocation();
  Future<List<MedicalPlaceEntity>> getNearbyMedicalPlaces(double latitude, double longitude);
}
