// import 'package:client/features/auth/presentation/screens/login_screen.dart';
import 'package:client/features/auth/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:client/core/themes.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  void _onIntroEnd(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  Widget _buildLottie(String assetName, {double width = 300}) {
    return Lottie.asset(
      assetName,
      width: width,
      repeat: true,
      fit: BoxFit.contain,
    );
  }

  @override
  Widget build(BuildContext context) {
    final pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(
        fontSize: 38,
        fontWeight: FontWeight.w800,
        color:
            Theme.of(context).appBarTheme.titleTextStyle?.color ?? Colors.white,
        letterSpacing: -0.5,
        height: 1.2,
      ),
      bodyTextStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color:
            Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.85) ??
            Colors.white70,
        height: 1.5,
      ),
      titlePadding: const EdgeInsets.only(top: 24, bottom: 16),
      bodyPadding: const EdgeInsets.symmetric(horizontal: 24),
      pageColor: Colors.transparent,
      imagePadding: const EdgeInsets.only(top: 60, bottom: 24),
      contentMargin: const EdgeInsets.symmetric(horizontal: 16),
    );

    return Container(
      decoration: const BoxDecoration(gradient: AppThemes.gradient),
      child: SafeArea(
        child: IntroductionScreen(
          globalBackgroundColor: Colors.transparent,
          pages: [
            PageViewModel(
              title: "Welcome to Elysia",
              body:
                  "Your trusted healthcare companion for comprehensive medical management and wellness tracking. Experience healthcare reimagined.",
              image: _buildLottie('assets/animations/Doctor.json', width: 320),
              decoration: pageDecoration,
            ),
            PageViewModel(
              title: "Track Your Health Journey",
              body:
                  "Monitor vital signs, track medications, and maintain detailed health records. Stay informed with real-time insights and personalized health analytics.",
              image: _buildLottie('assets/animations/beat.json', width: 320),
              decoration: pageDecoration,
            ),
            PageViewModel(
              title: "Connect with Experts",
              body:
                  "Book appointments with certified healthcare professionals, access telemedicine consultations, and receive expert medical guidance anytime, anywhere.",
              image: _buildLottie('assets/animations/loading.json', width: 320),
              decoration: pageDecoration,
            ),
            PageViewModel(
              title: "Begin Your Wellness Journey",
              body:
                  "Join thousands of users who trust MediCare for their health management. Start today and take the first step toward a healthier tomorrow.",
              image: _buildLottie('assets/animations/Ultrasound.json', width: 300),
              footer: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: Column(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 48,
                          vertical: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        backgroundColor: Colors.white,
                        foregroundColor: AppThemes.primaryBlue,
                        elevation: 4,
                        shadowColor: Colors.black26,
                      ),
                      onPressed: () => _onIntroEnd(context),
                      child: const Text(
                        'Get Started',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextButton(
                      onPressed: () {

                      },
                      child: Text(
                        'Learn More',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white.withOpacity(0.9),
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              decoration: pageDecoration,
            ),
          ],
          onDone: () => _onIntroEnd(context),
          onSkip: () => _onIntroEnd(context),
          showSkipButton: true,
          showBackButton: false,
          showDoneButton: true,
          skip: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.blueGrey.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'Skip',
              style: TextStyle(
                color: AppThemes.primaryBlue,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
          next: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(
              Icons.arrow_forward,
              color: AppThemes.primaryBlue,
              size: 24,
            ),
          ),
          done: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Text(
              'Done',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: AppThemes.primaryBlue,
                fontSize: 15,
              ),
            ),
          ),
          dotsDecorator: DotsDecorator(
            activeColor: AppThemes.navigationBarColor.colors.first,
            color: Colors.indigoAccent,
            size: const Size(8, 8),
            activeSize: const Size(32, 8),
            spacing: const EdgeInsets.symmetric(horizontal: 4),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
          ),
          curve: Curves.easeInOut,
          controlsPadding: const EdgeInsets.all(16),
          dotsContainerDecorator: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(24),
          ),
        ),
      ),
    );
  }
}
