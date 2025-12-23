import 'package:client/features/chat/domain/repositories/call_repo.dart';

class InitUseCase {
  final CallRepository repository;

  InitUseCase(
    this.repository
  );

  Future<void> call (String roomId) async {
    await repository.initialize(roomId);
  }
}
