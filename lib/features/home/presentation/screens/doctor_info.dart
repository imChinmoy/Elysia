import 'package:flutter/material.dart';

class DoctorInfo extends StatelessWidget {
  final Map<String, dynamic> doctor;
  final String heroTag;

  const DoctorInfo({super.key, required this.doctor, required this.heroTag});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),

            gradient: RadialGradient(
              colors: [
                const Color.fromARGB(255, 99, 206, 183),
                const Color.fromARGB(255, 30, 86, 150),
                const Color.fromARGB(255, 253, 253, 253),
              ],
              radius: 3.0,
              center: Alignment.center,
              focal: Alignment.center,
            ),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Hero(
                    tag: heroTag,
                    child: CircleAvatar(
                      radius: 80,
                      backgroundImage: AssetImage(doctor['image']!),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    doctor['name']!,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    doctor['specialty']!,
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium?.copyWith(color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 24),
                  Divider(),
                  const SizedBox(height: 16),
                  Text(
                    "Here you can show detailed information about the doctor including bio, experience, ratings, and appointment options. Add as much content as needed and it will scroll smoothly.",
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(height: 1.5),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
