import 'package:client/features/chat/data/datasource/api_chat_datasource.dart';
import 'package:client/features/chat/data/models/chat_model.dart';
import 'package:client/features/chat/domain/repositories/chat_repo.dart';

class ChatRepositoryImpl implements ChatRepository {
  final RemoteDataSource remoteDataSource;

  ChatRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<ChatModel>> getMessages(List<String> messageIds) {
    return remoteDataSource.getMessages(messageIds);
  }

  @override
  Future<void> sendMessage(String message) {
    return remoteDataSource.sendMessage(message);
  }

  @override
  Stream<ChatModel> get incomingMessages => remoteDataSource.incomingMessages;
}
