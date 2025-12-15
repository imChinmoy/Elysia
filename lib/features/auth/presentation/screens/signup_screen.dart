import 'package:client/core/themes.dart';
import 'package:client/features/auth/presentation/providers/auth_provider.dart';
import 'package:client/features/auth/presentation/screens/login_screen.dart';
import 'package:client/features/auth/presentation/state/register_state.dart';
import 'package:client/features/auth/presentation/widgets/text_field.dart';
import 'package:client/features/home/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  bool hidePassword = true;

  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _usernameController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _role;

  @override
  void initState() {
    super.initState();
     _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _usernameController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _role = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    _phoneNumberController.dispose();
    _role;
  }

  void _signup() {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final username = _usernameController.text.trim();
    final phoneNumber = _phoneNumberController.text.trim();
    final role = _role.text.trim();

    ref
        .read(registerNotifierProvider.notifier)
        .register(email, password, username, phoneNumber, role);
  }

  @override
  Widget build(BuildContext context) {
    final registerState = ref.read(registerNotifierProvider);

    ref.listen<RegisterState>(registerNotifierProvider, (previous, next) {
      next.when(
        initial: () {},
        loading: () {},
        success: (user) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Welcome, ${user.username}!')));
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const HomeScreen(),
            ),
          );
        },
        failure: (failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Login failed: ${failure.runtimeType}')),
          );
        },
      );
    });

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

                AppTextField(
                  label: 'Email or Mobile Number',
                  hint: 'example@example.com',
                  controller: _emailController,
                ),

                const SizedBox(height: 20),

                AppTextField(
                  label: 'Password',
                  hint: 'password@123',
                  obscureText: hidePassword,
                  controller: _passwordController,
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
                  hint: 'dev',
                  controller: _usernameController,
                ),
                const SizedBox(height: 20),
                AppTextField(
                  label: 'Mobile Number',
                  hint: '0000 0000',
                  controller: _phoneNumberController,
                ),
                const SizedBox(height: 20),

                AppTextField(
                  label: 'role',
                  hint: 'doctor/ patient',
                  controller: _emailController,
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
                  child: registerState.when(
                    initial: () => ElevatedButton(
                      onPressed: _signup,
                      child: Text(
                        'Register',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    success: (_) => ElevatedButton(
                      onPressed: () {},
                      child: const Text('Signed Up'),
                    ),
                    failure: (_) => ElevatedButton(
                      onPressed: _signup,
                      child: const Text('Retry Register'),
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
