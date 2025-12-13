import 'package:client/core/themes.dart';
import 'package:client/features/auth/presentation/screens/login_screen.dart';
import 'package:client/features/auth/presentation/widgets/text_field.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Hello!',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        leading: const BackButton(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
          
                Text('Welcome', style: Theme.of(context).textTheme.titleLarge),
          
                const SizedBox(height: 32),
          
                const AppTextField(
                  label: 'Email or Mobile Number',
                  hint: 'example@example.com',
                ),
          
                const SizedBox(height: 20),
          
                AppTextField(
                  label: 'Password',
                  hint: 'password@123',
                  obscureText: hidePassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      hidePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                    ),
                    onPressed: () {
                      setState(() => hidePassword = !hidePassword);
                    },
                  ),
                ),
          
                const SizedBox(height: 20),
          
                AppTextField(
                  label: 'Username',
                  hint: 'happy_user123',
                  obscureText: hidePassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      hidePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                    ),
                    onPressed: () {
                      setState(() => hidePassword = !hidePassword);
                    },
                  ),
                ),
          
                const SizedBox(height: 8),
          
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Forget Password',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
          
                const SizedBox(height: 24),
          
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'Log In',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
          
                const SizedBox(height: 20),
          
                Center(
                  child: Text(
                    'or',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
          
                const SizedBox(height: 16),
          
                Center(
                  child: CircleAvatar(
                    radius: 26,
                    backgroundColor: AppThemes.primaryBlue.withOpacity(0.15),
                    child: const Icon(
                      Icons.fingerprint,
                      color: AppThemes.primaryBlue,
                      size: 30,
                    ),
                  ),
                ),
          
                const SizedBox(height: 40),
          
                Center(
                  child: GestureDetector(
                    onTap: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                    ),
                    child: Text.rich(
                      TextSpan(
                        text: "Already have an account? ",
                        children: [
                          TextSpan(
                            text: 'Login',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
          
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
