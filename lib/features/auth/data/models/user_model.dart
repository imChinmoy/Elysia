import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/user_entity.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class UserModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String email;

  @HiveField(2)
  final String username;

  @HiveField(3)
  final String? phoneNumber;

  @HiveField(4)
  final String? role;

  @HiveField(5)
  final String? token;

  UserModel({
    required this.id,
    required this.email,
    required this.username,
    this.phoneNumber,
    this.role,
    this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      email: email,
      username: username,
      phoneNumber: phoneNumber,
      role: role,
    );
  }

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      email: entity.email,
      username: entity.username,
      phoneNumber: entity.phoneNumber,
      role: entity.role,
    );
  }
}
