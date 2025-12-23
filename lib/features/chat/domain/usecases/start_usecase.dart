import 'package:client/features/chat/domain/repositories/call_repo.dart';

class StartUseCase {
  final CallRepository repository;

  StartUseCase(
    this.repository
  );

  Future<void> call (String roomId) async {
    await repository.startCall(roomId);
  }
}
