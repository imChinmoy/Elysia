import 'package:client/core/error/failure.dart';

abstract class CallRepository {
  Future<Failure?> initialize(String roomId);
  Future<Failure?> startCall(String roomId);
  // Future<void> answerCall(String receiverId);
  Future<void> endCall(String roomId);

}