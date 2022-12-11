import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:formz/formz.dart';

enum NameValidatorError {
  pure,
  empty,
  invalid,
}

extension NameValidationErrorExtension on NameValidatorError {
  String? description({required BuildContext context}) {
    switch (this) {
      case NameValidatorError.pure:
        return null;
      case NameValidatorError.empty:
        return '';
      case NameValidatorError.invalid:
        return AppLocalizations.of(context)!.errorValidUsername;
    }
  }
}

class Name extends FormzInput<String?, NameValidatorError> {
  const Name.pure() : super.pure('');

  const Name.dirty([String value = '']) : super.dirty(value);

  @override
  NameValidatorError? validator(String? value) {
    if (value == null || value.isEmpty) {
      return NameValidatorError.pure;
    }
    return null;
  }
}
