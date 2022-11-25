import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../model/password.dart';
import '../model/username.dart';
import 'model/confirm_password.dart';

part 'sign_up_state.freezed.dart';

@freezed
class SignUpState with _$SignUpState {
  factory SignUpState({
    required UserName userName,
    required Password password,
    required ConfirmPassword confirmPassword,
    required FormzStatus formStatus,
  }) = _SignUpState;

  factory SignUpState.initial() => SignUpState(
        userName: const UserName.pure(),
        password: const Password.pure(),
        confirmPassword: const ConfirmPassword.pure(),
        formStatus: FormzStatus.pure,
      );
}
