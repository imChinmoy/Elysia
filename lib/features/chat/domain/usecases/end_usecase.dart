import 'package:client/features/chat/domain/repositories/call_repo.dart';

class EndUseCase {
  final CallRepository repository;

  EndUseCase(this.repository);

  Future<void> call(String roomId) async {
    await repository.endCall(roomId);
  }
}
