import 'package:client/features/auth/domain/entities/user_entity.dart';
import 'package:client/features/auth/domain/failure/auth_failure.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_state.freezed.dart';

@freezed
class RegisterState with _$RegisterState {
  const factory RegisterState.initial() = _Initial;
  const factory RegisterState.loading() = _Loading;
  const factory RegisterState.success(UserEntity user) = _Success;
  const factory RegisterState.failure(AuthFailure failure) = _Failure;
}
