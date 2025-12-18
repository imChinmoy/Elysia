import 'package:client/core/network/dio_client.dart';
import 'package:client/features/medical/data/datasource/remote_data.dart';
import 'package:client/features/medical/data/repositories/medical_repositoy_impl.dart';
import 'package:client/features/medical/domain/repositories/medical_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';


final dioProvider = Provider<Dio>((ref) {
  return DioClient.createDio();
});


final remoteDataProvider = Provider<RemoteData>((ref) {
  final dio = ref.watch(dioProvider);
  return RemoteDataImpl(dio: dio);
});


final medicalRepositoryProvider = Provider<MedicalRepository>((ref) {
  final remoteData = ref.watch(remoteDataProvider);
  return MedicalRepositoryImpl(remoteData: remoteData);
});
