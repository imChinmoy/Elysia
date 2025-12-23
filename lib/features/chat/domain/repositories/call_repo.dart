abstract class CallRepository {
  Future<void> initialize(String roomId);
  Future<void> startCall(String roomId);
  // Future<void> answerCall(String receiverId);
  Future<void> endCall(String roomId);

}