import 'package:client/features/auth/domain/repositories/auth_repo.dart';

class LogoutUseCase {
  final AuthRepo repository;

  LogoutUseCase(this.repository);

  Future<void> call() {
    return repository.logout();
  }
}
