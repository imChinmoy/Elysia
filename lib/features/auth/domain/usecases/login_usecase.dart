import 'package:client/core/either.dart';

import '../entities/user_entity.dart';
import '../failure/auth_failure.dart';
import '../repositories/auth_repo.dart';

class LoginUseCase {
  final AuthRepo repository;

  LoginUseCase(this.repository);

  Future<Either<AuthFailure, UserEntity>> call(
    String email,
    String password,
  ) async {
    final result = await repository.login(email, password);

    return result.fold(
      (failure) => Left(failure),

      (userModel) => Right(userModel.toEntity()),
    );
  }
}
