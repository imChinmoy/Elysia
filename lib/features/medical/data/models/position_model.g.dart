// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'position_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PositionModelImpl _$$PositionModelImplFromJson(Map<String, dynamic> json) =>
    _$PositionModelImpl(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      address: json['address'] as String,
    );

Map<String, dynamic> _$$PositionModelImplToJson(_$PositionModelImpl instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'address': instance.address,
    };
