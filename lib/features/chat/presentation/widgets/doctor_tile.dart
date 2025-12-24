import 'package:client/features/chat/domain/entities/doctor_ui_entity.dart';
import 'package:client/features/chat/presentation/screens/chat_screen.dart';
import 'package:client/features/chat/presentation/screens/videocall_screen.dart';
import 'package:client/features/chat/presentation/widgets/connect_action_button.dart';
import 'package:flutter/material.dart';

class DoctorTile extends StatelessWidget {
  final DoctorUiEntity doctor;

  const DoctorTile({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(doctor.imageUrl),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: doctor.isOnline ? Colors.green : Colors.grey,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doctor.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  doctor.specialization,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                ),
              ],
            ),
          ),
          ContactActionButton(
            icon: Icons.chat_bubble_outline,
            color: Colors.blueAccent,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ChatScreen(doctor: doctor)),
              );
            },
          ),
          const SizedBox(width: 8),
          ContactActionButton(
            icon: Icons.videocam_outlined,
            color: doctor.isOnline ? Colors.green : Colors.grey,
            onTap: doctor.isOnline
                ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CallScreen(roomId: '1234567890'),
                      ),
                    );
                  }
                : null,
          ),
        ],
      ),
    );
  }
}
