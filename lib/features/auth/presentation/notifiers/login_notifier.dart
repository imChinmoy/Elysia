import 'package:client/features/auth/domain/usecases/login_usecase.dart';
import 'package:client/features/auth/presentation/state/login_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginNotifier extends StateNotifier<LoginState> {
  final LoginUseCase loginUseCase;

  LoginNotifier(this.loginUseCase) : super(const LoginState.initial());

  Future<void> login(String email, String password) async {
    state = const LoginState.loading();

    final result = await loginUseCase(email, password);

    result.fold(
      (failure) => state = LoginState.failure(failure),
      (user) => state = LoginState.success(user),
    );
  }
}
