import 'package:client/features/auth/presentation/notifiers/login_notifier.dart';
import 'package:client/features/auth/presentation/notifiers/register_notifier.dart';
import 'package:client/features/auth/presentation/providers/usecase_provider.dart';
import 'package:client/features/auth/presentation/state/login_state.dart';
import 'package:client/features/auth/presentation/state/register_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginNotifierProvider = StateNotifierProvider<LoginNotifier, LoginState>(
  (ref) => LoginNotifier(ref.read(loginUseCaseProvider)),
);

final registerNotifierProvider =
    StateNotifierProvider<RegisterNotifier, RegisterState>(
      (ref) => RegisterNotifier(ref.read(registerUseCaseProvider)),
    );
