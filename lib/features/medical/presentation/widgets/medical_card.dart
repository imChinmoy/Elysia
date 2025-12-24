import 'package:client/features/medical/domain/entities/medical_place.dart';
import 'package:flutter/material.dart';

class MedicalCard extends StatelessWidget {
  final MedicalPlaceEntity medicalPlace;
  const MedicalCard({super.key, required this.medicalPlace});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                medicalPlace.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Text(
                medicalPlace.isOpen ? 'Open' : 'Closed',
                style: TextStyle(
                  color: medicalPlace.isOpen ? Colors.green : Colors.red,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text(medicalPlace.address, style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 5),
          Text(
            'Distance: ${medicalPlace.distance} km',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 5),
          Text(
            'Rating: ${medicalPlace.rating}',
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
