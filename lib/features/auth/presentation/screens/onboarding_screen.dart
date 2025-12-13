import 'package:client/features/auth/presentation/screens/login_screen.dart';
import 'package:client/features/home/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:client/core/themes.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  void _onIntroEnd(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  Widget _buildLottie(String assetName, {double width = 300}) {
    return Lottie.asset(assetName, width: width, repeat: true);
  }

  @override
  Widget build(BuildContext context) {
    final pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).appBarTheme.titleTextStyle?.color,
      ),
      bodyTextStyle: TextStyle(fontSize: 16, color: Theme.of(context).textTheme.bodyMedium?.color),
      bodyPadding: EdgeInsets.all(16),
      pageColor: Colors.transparent, 
      imagePadding: EdgeInsets.only(top: 40),
    );

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: const BoxDecoration(gradient: AppThemes.gradient),
        child: IntroductionScreen(
          globalBackgroundColor: Colors.transparent,
          pages: [
            PageViewModel(
              title: "Welcome to HealthPlus",
              body: "Your companion for a healthier life.",
              image: _buildLottie('assets/animations/Doctor.json'),
              decoration: pageDecoration,
            ),
      
            PageViewModel(
              title: "Track Your Health",
              body: "Monitor your daily activities and stay fit.",
              image: _buildLottie('assets/animations/track.json'),
              decoration: pageDecoration,
            ),
            PageViewModel(
              title: "Get Started Now",
              body: "Sign in and take control of your health journey.",
              image: _buildLottie('assets/animations/loading.json'),
              
              footer: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: AppThemes.gradient.colors.first,
                ),
                onPressed: () => _onIntroEnd(context),
                child: const Text('Get Started'),
              ),
              decoration: pageDecoration,
            ),
          ],
          onDone: () => _onIntroEnd(context),
          onSkip: () => _onIntroEnd(context),
          showSkipButton: true,
          skip: Text('Skip', style: TextStyle(color: AppThemes.primaryBlue)),
          next: const Icon(Icons.arrow_forward, color: AppThemes.primaryBlue),
          done: Text(
            'Done',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: AppThemes.primaryBlue,
            ),
          ),
          dotsDecorator: const DotsDecorator(
            activeColor: Colors.lightBlueAccent,
            color: AppThemes.primaryBlue,
            size: Size(10, 10),
            activeSize: Size(32, 10),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25)),
            ),
            
          ),
          
        ),
      ),
    );
  }
}
