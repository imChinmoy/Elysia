import 'package:client/features/auth/domain/usecases/register_usecase.dart';
import 'package:client/features/auth/presentation/state/register_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class RegisterNotifier extends StateNotifier<RegisterState> {
  final RegisterUseCase registerUseCase;

  RegisterNotifier(this.registerUseCase) : super(const RegisterState.initial());

  Future<void> register(String email, String password, String username, String phoneNumber, String role) async {
    state = const RegisterState.loading();

    final result = await registerUseCase(email, password, username, phoneNumber, role);

    result.fold(
      (failure) => state = RegisterState.failure(failure),
      (user) => state = RegisterState.success(user),
    );
  }
}

