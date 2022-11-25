import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:formz/formz.dart';

enum PasswordValidatorError {
  pure,
  empty,
  notValidRegex,
  notEqual,
  invalid,
}

extension PasswordValidationErrorExtension on PasswordValidatorError {
  String? message({required BuildContext context}) {
    switch (this) {
      case PasswordValidatorError.pure:
        return null;
      case PasswordValidatorError.empty:
        return '';
      case PasswordValidatorError.notValidRegex:
        return AppLocalizations.of(context)!.errorValidPassword;
      case PasswordValidatorError.notEqual:
        return AppLocalizations.of(context)!.errorPasswordMatch;
      case PasswordValidatorError.invalid:
        return 'Error';
    }
  }
}

class Password extends FormzInput<String?, PasswordValidatorError> {
  const Password.pure() : super.pure('');

  const Password.dirty([String value = '']) : super.dirty(value);

  PasswordValidatorError? validate(String? value, String? passwordCheck) {
    if (passwordCheck != null && value != passwordCheck) {
      return PasswordValidatorError.notEqual;
    }
    return null;
  }

  @override
  PasswordValidatorError? validator(String? value) {
    if (value == null || value.isEmpty) {
      return PasswordValidatorError.pure;
    }
    return null;
  }
}
