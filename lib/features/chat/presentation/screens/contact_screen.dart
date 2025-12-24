import 'package:client/core/themes.dart';
import 'package:client/features/chat/domain/entities/doctor_ui_entity.dart';
import 'package:client/features/chat/presentation/widgets/doctor_tile.dart';
import 'package:flutter/material.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final doctors = <DoctorUiEntity>[
      DoctorUiEntity(
        id: '1',
        name: 'Dr. Sarah Johnson',
        specialization: 'Cardiologist',
        imageUrl: 'https://i.pravatar.cc/150?img=32',
        isOnline: true,
      ),
      DoctorUiEntity(
        id: '2',
        name: 'Dr. Michael Lee',
        specialization: 'Dermatologist',
        imageUrl: 'https://i.pravatar.cc/150?img=12',
        isOnline: false,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Doctors'),
        centerTitle: true,
        elevation: 0,
        toolbarHeight: 100,
        backgroundColor: AppThemes.doctorInfoBG,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: doctors.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          return DoctorTile(doctor: doctors[index]);
        },
      ),
    );
  }
}
