import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';

import '../../../data/provider/loading_state_provider.dart';
import '../../../data/repository/authentication_repository/authentication_repository.dart';
import '../model/password.dart';
import '../model/username.dart';
import 'login_state.dart';

class LoginViewModel extends StateNotifier<LoginState> {
  LoginViewModel({
    required this.authenticationRepository,
    required this.ref,
  }) : super(LoginState.initial());

  AuthenticationRepository authenticationRepository;

  Ref ref;

  void init() {}

  void changeUsername(String value) {
    final userName = UserName.dirty(value);
    state = state.copyWith(
      userName: userName,
      formStatus: Formz.validate([
        userName,
        state.password,
      ]),
    );
  }

  void changePassword(String value) {
    final password = Password.dirty(value);
    state = state.copyWith(
      password: password,
      formStatus: Formz.validate([
        state.userName,
        password,
      ]),
    );
  }

  Future<bool> submitLogin() async {
    ref.read(loadingStateProvider).toLoading();
    final isAuthenticated = await authenticationRepository.loginManual(
      state.userName.value ?? '',
      state.password.value ?? '',
    );
    ref.read(loadingStateProvider).toIdle();
    return isAuthenticated;
  }
}
