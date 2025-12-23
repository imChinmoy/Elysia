class ChatEntity{
  final String id;
  final String name;
  final List<String> messages;
  final String senderId;
  final String receiverId;

  ChatEntity({
    required this.id,
    required this.name,
    required this.messages,
    required this.senderId,
    required this.receiverId,
  });
}