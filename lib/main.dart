import 'package:client/core/themes.dart';
import 'package:client/features/auth/presentation/screens/login_screen.dart';
import 'package:client/features/auth/presentation/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppThemes.lightTheme,
      title: 'Elysia',
      builder: (context, child) {
        return Container(
          decoration: const BoxDecoration(
            gradient: AppThemes.gradient,
          ),
          
          child: child,
        );
      },
      home: OnboardingScreen(),
    );
  }
}
