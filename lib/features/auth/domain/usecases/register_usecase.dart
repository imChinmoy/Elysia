import '../entities/user_entity.dart';
import '../failure/auth_failure.dart';
import '../repositories/auth_repo.dart';
import '../../../../core/either.dart';

class RegisterUseCase {
  final AuthRepo repository;

  RegisterUseCase(this.repository);

  Future<Either<AuthFailure, UserEntity>> call(
    String email,
    String password,
    String username,
    String phoneNumber,
    String role,
  ) async {
    final result = await repository.register(
      email,
      password,
      username,
      phoneNumber,
      role,
    );

    return result.fold(
      (failure) => Left(failure),
      (userModel) => Right(userModel.toEntity()),
    );
  }
}
