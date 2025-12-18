import 'package:client/features/medical/domain/entities/position_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'position_model.freezed.dart';
part 'position_model.g.dart';

@freezed
class PositionModel with _$PositionModel {
  const factory PositionModel({
    required double latitude,
    required double longitude,
    required String address
  }) = _PositionModel;

  factory PositionModel.fromJson(Map<String, dynamic> json ) => _$PositionModelFromJson(json);

}

extension PositionModelMapper on PositionModel {
  Position toEntity() {
    return Position(
      latitude: latitude,
      longitude: longitude, 
      address: address,
    );
  }
}