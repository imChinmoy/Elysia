import 'package:client/core/either.dart';
import 'package:client/features/auth/data/models/user_model.dart';
import 'package:client/features/auth/domain/failure/auth_failure.dart';

abstract class AuthRepo {
  Future<Either<AuthFailure, UserModel>> login(String email, String password);

  Future<Either<AuthFailure, UserModel>> register(
    String email,
    String password,
    String username,
    String phoneNumber,
    String role,
  );

  Future<void> logout();
}
