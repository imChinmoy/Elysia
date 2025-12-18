import 'package:client/features/auth/domain/entities/user_entity.dart';
import 'package:client/features/auth/domain/failure/auth_failure.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_state.freezed.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState.initial() = _Initial;
  const factory LoginState.loading() = _Loading;
  const factory LoginState.success(UserEntity user) = _Success;
  const factory LoginState.failure(AuthFailure failure) = _Failure;
}
