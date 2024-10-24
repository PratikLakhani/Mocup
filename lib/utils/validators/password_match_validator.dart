
import 'package:form_field_validator/form_field_validator.dart';
import 'package:plug2go/extensions/ext_string_null.dart';
import 'package:plug2go/utils/validators/global_text_validator.dart';

class ConfirmPasswrodValidator extends TextFieldValidator {
  ConfirmPasswrodValidator({
    required String errorText,
    required this.password,
  }) : super(errorText);

  String password;

  @override
  bool get ignoreEmptyValues => true;

  @override
  bool isValid(String? value) {
    if (value == null) return false;

    return true;
  }

  @override
  String? call(String? value) {
    if (value?.isEmptyOrNull ?? true) {
      return errorText;
    }
    final testMessage =
        passwordValidator().call(value);
    if (testMessage == null) {
      if (value != password) {
        return 'Password does not match';
      }
    } else {
      return testMessage;
    }
    return null;
  }
}
