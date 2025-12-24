import 'package:client/core/error/failure.dart';
import 'package:client/features/chat/domain/repositories/call_repo.dart';

class StartUseCase {
  final CallRepository repository;

  StartUseCase(this.repository);

  Future<Failure?> call(String roomId) async {
    return await repository.startCall(roomId);
  }
}
