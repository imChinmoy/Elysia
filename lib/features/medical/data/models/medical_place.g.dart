// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medical_place.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MedicalPlaceImpl _$$MedicalPlaceImplFromJson(Map<String, dynamic> json) =>
    _$MedicalPlaceImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      address: json['address'] as String,
      type: $enumDecode(_$MedicalTypeEnumMap, json['type']),
      location: const LatLngConverter()
          .fromJson(json['location'] as Map<String, dynamic>),
      distance: (json['distance'] as num).toDouble(),
      rating: (json['rating'] as num).toDouble(),
      isOpen: json['isOpen'] as bool,
    );

Map<String, dynamic> _$$MedicalPlaceImplToJson(_$MedicalPlaceImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address,
      'type': _$MedicalTypeEnumMap[instance.type]!,
      'location': const LatLngConverter().toJson(instance.location),
      'distance': instance.distance,
      'rating': instance.rating,
      'isOpen': instance.isOpen,
    };

const _$MedicalTypeEnumMap = {
  MedicalType.hospital: 'hospital',
  MedicalType.clinic: 'clinic',
  MedicalType.pharmacy: 'pharmacy',
};
