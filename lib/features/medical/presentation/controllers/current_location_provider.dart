import 'package:client/features/medical/presentation/controllers/medical_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../domain/repositories/medical_repository.dart';

final currentLocationProvider =
    StateNotifierProvider<CurrentLocationNotifier, AsyncValue<LatLng>>((ref) {
      final repository = ref.watch(medicalRepositoryProvider);
      return CurrentLocationNotifier(repository);
    });

class CurrentLocationNotifier extends StateNotifier<AsyncValue<LatLng>> {
  final MedicalRepository repository;

  CurrentLocationNotifier(this.repository) : super(const AsyncValue.loading());

  Future<void> fetchCurrentLocation() async {
    try {
      state = const AsyncValue.loading();

      final position = await repository.getCurrentLocation();

      state = AsyncValue.data(LatLng(position.latitude, position.longitude));
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  void setLocation(double latitude, double longitude) {
    state = AsyncValue.data(LatLng(latitude, longitude));
  }
}
