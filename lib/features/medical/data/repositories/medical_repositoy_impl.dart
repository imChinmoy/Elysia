import 'package:client/features/medical/data/datasource/remote_data.dart';
import 'package:client/features/medical/data/models/position_model.dart';
import 'package:client/features/medical/data/models/medical_place.dart';
import 'package:client/features/medical/domain/entities/medical_place.dart';
import 'package:client/features/medical/domain/entities/position_entity.dart';
import 'package:client/features/medical/domain/repositories/medical_repository.dart';

class MedicalRepositoryImpl implements MedicalRepository {
  final RemoteData remoteData;
  const MedicalRepositoryImpl({required this.remoteData});

  @override
  Future<Position> getCurrentLocation() async {
    final location = await remoteData.getCurrentLocation();
    return location.toEntity();
  }

  @override
  Future<List<MedicalPlaceEntity>> getNearbyMedicalPlaces(
    double latitude,
    double longitude,
  ) async {
    final places = await remoteData.getNearbyMedicalPlaces(latitude, longitude);
    return places.map((e) => e.toEntity()).toList();
  }
}
