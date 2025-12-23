import 'package:client/features/chat/domain/entities/chat_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';


part 'chat_model.freezed.dart';
part 'chat_model.g.dart';
@freezed
class ChatModel  with _$ChatModel{
  const factory ChatModel({
    required String id,
    required String name,
    required List<String> messages,
    required String senderId,
    required String receiverId,
  }) = _ChatModel;

  factory ChatModel.fromJson(Map<String, dynamic > json ) => _$ChatModelFromJson(json);

}

extension ChatModelMapper on ChatModel {
  ChatEntity toEntity() => ChatEntity(
    id: id,
    name: name,
    messages: messages,
    senderId: senderId,
    receiverId: receiverId,
  );
}