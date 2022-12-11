import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:logger/logger.dart';

import '../../../data/model/db/db_user_info.dart';
import '../../../data/provider/loading_state_provider.dart';
import '../../../data/repository/user_repository/user_repository.dart';
import '../model/password.dart';
import '../model/username.dart';
import 'model/confirm_password.dart';
import 'model/name.dart';
import 'sign_up_state.dart';

class SignUpViewModel extends StateNotifier<SignUpState> {
  SignUpViewModel({
    required this.reader,
    required this.userRepository,
  }) : super(SignUpState.initial());

  final Ref reader;

  final UserRepository userRepository;

  void changeName(String value) {
    final name = Name.dirty(value);
    state = state.copyWith(
      name: name,
      formStatus: Formz.validate([
        name,
        state.userName,
        state.password,
        state.confirmPassword,
      ]),
    );
  }

  void changeUsername(String value) {
    final userName = UserName.dirty(value);
    state = state.copyWith(
      userName: userName,
      formStatus: Formz.validate([
        userName,
        state.name,
        state.password,
        state.confirmPassword,
      ]),
    );
  }

  void changePassword(String value) {
    final password = Password.dirty(value);
    state = state.copyWith(
      password: password,
      confirmPassword: state.confirmPassword != const ConfirmPassword.pure()
          ? ConfirmPassword.dirty(
              password: value,
              value: state.confirmPassword.value,
            )
          : state.confirmPassword,
      formStatus: Formz.validate([
        password,
        state.name,
        state.userName,
        if (state.confirmPassword != const ConfirmPassword.pure())
          ConfirmPassword.dirty(
            password: value,
            value: state.confirmPassword.value,
          )
        else
          state.confirmPassword,
      ]),
    );
  }

  void changeConfirmPassword(String value) {
    final confirmPassword = ConfirmPassword.dirty(
      password: state.password.value ?? '',
      value: value,
    );
    state = state.copyWith(
      confirmPassword: confirmPassword,
      formStatus: Formz.validate([
        confirmPassword,
        state.name,
        state.userName,
        state.password,
      ]),
    );
  }

  Future<void> submitSignUp() async {
    reader.read(loadingStateProvider).toLoading();
    await Future.delayed(const Duration(seconds: 2));
    try {
      final result = await userRepository.createUser(
        userInfo: DbUserInfo(
          name: state.name.value ?? '',
          username: state.userName.value ?? '',
          password: state.password.value ?? '',
        ),
      );
      state = state.copyWith(
        formStatus: FormzStatus.submissionSuccess,
      );
    } catch (e) {
      state = state.copyWith(
        formStatus: FormzStatus.submissionFailure,
      );
      Logger().d('');
    }

    reader.read(loadingStateProvider).toIdle();
  }
}
