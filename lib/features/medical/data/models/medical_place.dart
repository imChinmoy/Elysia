import 'package:client/features/medical/data/models/lat_lng_converter.dart';
import 'package:client/features/medical/domain/entities/medical_place.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'medical_place.freezed.dart';
part 'medical_place.g.dart';

@freezed 
class MedicalPlace with _$MedicalPlace  {
  const factory MedicalPlace({
    required String id,
    required String name,
    required String address,
    required MedicalType type,
    @LatLngConverter() required LatLng location,
    required double distance,
    required double rating,
    required bool isOpen
  }) = _MedicalPlace;

  factory MedicalPlace.fromJson(Map<String, dynamic > json ) => _$MedicalPlaceFromJson(json);
} 

extension MedicalPlaceMapper on MedicalPlace {
  MedicalPlaceEntity toEntity() => MedicalPlaceEntity(
    id: id,
    name: name,
    address: address,
    type: type,
    location: location,
    distance: distance,
    rating: rating,
    isOpen: isOpen
  );
}

