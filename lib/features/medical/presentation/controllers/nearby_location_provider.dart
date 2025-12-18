import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/medical_place.dart';
import '../../domain/repositories/medical_repository.dart';
import 'medical_providers.dart';

final nearbyMedicalPlacesProvider =
    StateNotifierProvider<
      NearbyMedicalPlacesNotifier,
      AsyncValue<List<MedicalPlaceEntity>>
    >((ref) {
      final repository = ref.watch(medicalRepositoryProvider);
      return NearbyMedicalPlacesNotifier(repository);
    });

class NearbyMedicalPlacesNotifier
    extends StateNotifier<AsyncValue<List<MedicalPlaceEntity>>> {
  final MedicalRepository repository;

  NearbyMedicalPlacesNotifier(this.repository)
    : super(const AsyncValue.loading());

  Future<void> fetchNearbyPlaces({
    required double latitude,
    required double longitude,
  }) async {
    try {
      state = const AsyncValue.loading();

      final places = await repository.getNearbyMedicalPlaces(
        latitude,
        longitude
      );

      state = AsyncValue.data(places);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
