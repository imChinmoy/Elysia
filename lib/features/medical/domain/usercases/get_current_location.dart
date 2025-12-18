import 'package:client/features/medical/domain/entities/position_entity.dart';
import 'package:client/features/medical/domain/repositories/medical_repository.dart';

class GetCurrentLocationUseCase {
  final MedicalRepository repository;
  GetCurrentLocationUseCase({required this.repository});

  Future<Position> call () async  => await repository.getCurrentLocation();

}