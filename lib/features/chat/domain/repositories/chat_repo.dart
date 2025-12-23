import 'package:client/features/chat/data/models/chat_model.dart';

abstract class ChatRepository {
  Future<List<ChatModel>> getMessages(List<String> messageIds);
  Future<void> sendMessage(String message);
  Stream<ChatModel> get incomingMessages;
}
