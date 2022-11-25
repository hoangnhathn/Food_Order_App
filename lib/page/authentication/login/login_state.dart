import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../model/password.dart';
import '../model/username.dart';

part 'login_state.freezed.dart';

@freezed
class LoginState with _$LoginState {
  factory LoginState({
    required UserName userName,
    required Password password,
    required FormzStatus formStatus,
  }) = _LoginState;

  factory LoginState.initial() => LoginState(
        userName: const UserName.pure(),
        password: const Password.pure(),
        formStatus: FormzStatus.pure,
      );
}
