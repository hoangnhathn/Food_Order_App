import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:formz/formz.dart';

enum UserNameValidatorError {
  pure,
  empty,
  invalid,
}

extension UserNameValidationErrorExtension on UserNameValidatorError {
  String? description({required BuildContext context}) {
    switch (this) {
      case UserNameValidatorError.pure:
        return null;
      case UserNameValidatorError.empty:
        return '';
      case UserNameValidatorError.invalid:
        return AppLocalizations.of(context)!.errorValidUsername;
    }
  }
}

class UserName extends FormzInput<String?, UserNameValidatorError> {
  const UserName.pure() : super.pure('');

  const UserName.dirty([String value = '']) : super.dirty(value);

  @override
  UserNameValidatorError? validator(String? value) {
    if (value == null || value.isEmpty) {
      return UserNameValidatorError.pure;
    }
    return null;
  }
}
