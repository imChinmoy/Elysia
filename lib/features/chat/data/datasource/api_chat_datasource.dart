import 'dart:async';
import 'package:client/features/chat/data/models/chat_model.dart';
import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:client/core/constants.dart';

abstract class RemoteDataSource {
  Future<List<ChatModel>> getMessages(List<String> messageIds);
  Future<void> sendMessage(String message);
  Stream<ChatModel> get incomingMessages;
}

class RemoteDataSourceImpl implements RemoteDataSource {
  late final Socket socket;

  final StreamController<ChatModel> _messageController =
      StreamController<ChatModel>.broadcast();

  RemoteDataSourceImpl() {
    socket = io(
      ApiConfig.baseUrl,
      OptionBuilder().setTransports(['websocket']).enableAutoConnect().build(),
    );

    socket.connect();

    socket.onConnect((_) {
      debugPrint('Socket connected');
    });

    socket.on('newMessage', (data) {
      final chat = ChatModel.fromJson(Map<String, dynamic>.from(data));
      _messageController.add(chat);
    });

    socket.onDisconnect((_) {
      debugPrint('Socket disconnected');
    });
  }

  @override
  Future<List<ChatModel>> getMessages(List<String> messageIds) async {
    final data = socket.emitWithAck('getMessages', messageIds);

    return (data as List)
        .map((e) => ChatModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  @override
  Future<void> sendMessage(String message) async {
    socket.emit('sendMessage', {'message': message});
  }

  @override
  Stream<ChatModel> get incomingMessages => _messageController.stream;

  void dispose() {
    _messageController.close();
    socket.dispose();
  }
}
