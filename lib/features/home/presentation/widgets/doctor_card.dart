import 'package:client/core/themes.dart';
import 'package:client/features/home/presentation/screens/doctor_info.dart';
import 'package:flutter/material.dart';

class DoctorCard extends StatelessWidget {
  final Map<String, dynamic> doctor;

  const DoctorCard({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    final heroTag = 'doctor_${doctor['name']}';
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Hero(
        tag: 'image',
        child: Dismissible(
          key: Key(doctor['name']),
          direction: DismissDirection.startToEnd,
          background: _swipeBackground(),
          confirmDismiss: (direction) async {
            return Navigator.push(
              context,
              PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 500),
                reverseTransitionDuration: const Duration(milliseconds: 400),
                pageBuilder: (context, animation, secondaryAnimation) {
                  return DoctorInfo(doctor: doctor, heroTag: heroTag);
                },
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                      final offsetAnimation =
                          Tween<Offset>(
                            begin: const Offset(1.0, 0.0),
                            end: Offset.zero,
                          ).animate(
                            CurvedAnimation(
                              parent: animation,
                              curve: Curves.easeInOut,
                            ),
                          );

                      final fadeAnimation = Tween<double>(begin: 0.0, end: 1.0)
                          .animate(
                            CurvedAnimation(
                              parent: animation,
                              curve: Curves.easeInOut,
                            ),
                          );

                      return SlideTransition(
                        position: offsetAnimation,
                        child: FadeTransition(
                          opacity: fadeAnimation,
                          child: child,
                        ),
                      );
                    },
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Theme.of(context).cardTheme.color,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: _buildCard(context),
          ),
        ),
      ),
    );
  }

  Widget _swipeBackground() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 24),
      decoration: BoxDecoration(
        color: AppThemes.primaryBlue,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Icon(Icons.info_outline, color: Colors.white, size: 28),
    );
  }

  Widget _buildCard(context) {
    return ListTile(
      leading: Stack(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundImage: AssetImage(doctor['image']!),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: const Color(0xFF10B981),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
            ),
          ),
        ],
      ),
      title: Text(
        doctor['name']!,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      subtitle: Text(
        doctor['specialty']!,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: AppThemes.secondaryText,
      ),
    );
  }
}
