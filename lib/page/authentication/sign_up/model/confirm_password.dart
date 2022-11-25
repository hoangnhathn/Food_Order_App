import 'package:flutter/cupertino.dart';
import 'package:formz/formz.dart';

enum ConfirmPasswordValidatorError {
  invalid,
  mismatch,
}

extension ConfirmPasswordValidatorExtension on ConfirmPasswordValidatorError {
  String? description({required BuildContext context}) {
    switch (this) {
      case ConfirmPasswordValidatorError.invalid:
        return null;
      case ConfirmPasswordValidatorError.mismatch:
        return 'Confirm Password not match!';
    }
  }
}

class ConfirmPassword
    extends FormzInput<String, ConfirmPasswordValidatorError> {
  const ConfirmPassword.pure({
    this.password = '',
  }) : super.pure('');

  const ConfirmPassword.dirty({
    required this.password,
    String value = '',
  }) : super.dirty(value);

  final String password;

  @override
  ConfirmPasswordValidatorError? validator(String value) {
    if (value.isEmpty) {
      return ConfirmPasswordValidatorError.invalid;
    }
    return password == value ? null : ConfirmPasswordValidatorError.mismatch;
  }
}
