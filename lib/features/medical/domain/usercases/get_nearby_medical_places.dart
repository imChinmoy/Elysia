import 'package:client/features/medical/domain/entities/medical_place.dart';
import 'package:client/features/medical/domain/repositories/medical_repository.dart';

class GetNearbyMedicalPlacesUseCase {
  final MedicalRepository repository;
  GetNearbyMedicalPlacesUseCase(this.repository);

  Future<List<MedicalPlaceEntity>> call (double latitude, double longitude ) async => await repository.getNearbyMedicalPlaces(latitude, longitude);
  
}