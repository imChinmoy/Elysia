import 'package:client/core/error/failure.dart';
import 'package:client/features/chat/domain/repositories/call_repo.dart';

class InitUseCase {
  final CallRepository repository;

  InitUseCase(
    this.repository
  );

  Future<Failure?> call (String roomId) async {
    return await repository.initialize(roomId);
  }
}
