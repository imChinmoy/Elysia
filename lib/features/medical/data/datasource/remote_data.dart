import 'dart:developer';

import 'package:client/core/constants.dart';
import 'package:client/core/network/dio_client.dart';
import 'package:client/features/medical/data/models/position_model.dart';
import 'package:client/features/medical/data/models/medical_place.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

abstract class RemoteData {
  Future<List<MedicalPlace>> getNearbyMedicalPlaces(
    double latitude,
    double longitude,
  );
  Future<PositionModel> getCurrentLocation();
}

class RemoteDataImpl implements RemoteData {
  final Dio dio;

  RemoteDataImpl({Dio? dio}) : dio = dio ?? DioClient.createDio();

  @override
  Future<PositionModel> getCurrentLocation() async {
    try {
      final res = await dio.get(ApiConfig.baseUrl);
      if (res.statusCode != 200) {
        return PositionModel(latitude: 0, longitude: 0, address: '');
      }
      return PositionModel.fromJson(res.data);
    } on DioException catch (e) {
      throw Exception(
        e.response?.data['message'] ?? 'Failed to get current location',
      );
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<MedicalPlace>> getNearbyMedicalPlaces(
    double latitude,
    double longitude,
  ) async {
    try {
      final res = await dio.post(
        ApiConfig.nearbyPlaces,
        data: {"latitude": latitude, "longitude": longitude},
      );

      if (res.statusCode != 200) {
        return [];
      }
      // log('Places : ${res.data['data']}');
      return (res.data['data'] as List)
          .map((e) => MedicalPlace.fromJson(e))
          .toList();
    } catch (e) {
      log('Error : $e.toString()');
      rethrow;
    }
  }
}
