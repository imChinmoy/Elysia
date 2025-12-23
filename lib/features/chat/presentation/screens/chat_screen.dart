import 'package:client/features/chat/domain/entities/doctor_ui_entity.dart';
import 'package:client/features/chat/presentation/state/stream_provider.dart';
import 'package:client/features/chat/presentation/widgets/chat_input_field.dart';
import 'package:client/features/chat/presentation/widgets/message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatScreen extends ConsumerWidget {
  final DoctorUiEntity doctor;

  const ChatScreen({super.key, required this.doctor});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: false,
        titleSpacing: 0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(doctor.imageUrl),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doctor.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  doctor.specialization,
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.videocam_outlined,
              color: doctor.isOnline ? Colors.green : Colors.grey,
            ),
            onPressed: doctor.isOnline
                ? () {
                    // Implement video call
                  }
                : null,
          ),
        ],
      ),
      body: Column(
        children: const [
          Expanded(child: MessageList()),
          ChatInputField(),
        ],
      ),
    );
  }
}

class MessageList extends ConsumerWidget {
  const MessageList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messages = ref.watch(chatProvider);

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      reverse: true,
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[messages.length - 1 - index];
        return MessageBubble(message: message);
      },
    );
  }
}
