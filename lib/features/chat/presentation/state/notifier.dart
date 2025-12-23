import 'package:client/features/chat/data/models/chat_model.dart';
import 'package:client/features/chat/domain/entities/chat_message.dart';
import 'package:client/features/chat/domain/repositories/chat_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatNotifier extends StateNotifier<List<ChatMessage>> {
  final ChatRepository repository;
  final String currentUserId;

  ChatNotifier(this.repository, this.currentUserId) : super([]) {
    repository.incomingMessages.listen((chat) {
      _mapChatToMessages(chat);
    });
  }

  Future<void> loadChats(List<String> ids) async {
    final chats = await repository.getMessages(ids);

    final allMessages = chats.expand((chat) {
      return chat.messages.map(
        (msg) => ChatMessage(text: msg, isMe: chat.senderId == currentUserId),
      );
    }).toList();

    state = allMessages;
  }

  void _mapChatToMessages(ChatModel chat) {
    final newMessages = chat.messages.map(
      (msg) => ChatMessage(text: msg, isMe: chat.senderId == currentUserId),
    );

    state = [...state, ...newMessages];
  }

  Future<void> sendMessage(String message) async {
    await repository.sendMessage(message);
  }
}
