import 'package:form_field_validator/form_field_validator.dart';

MultiValidator emailValidator() => MultiValidator([
      RequiredValidator(errorText: 'Please enter email'),
      EmailValidator(errorText: 'Please enter valid email'),
    ]);
MultiValidator currentPasswordValidator() => MultiValidator([
      RequiredValidator(errorText: 'Please enter current password'),
    ]);
MultiValidator passwordValidator() => MultiValidator([
      RequiredValidator(errorText: 'Please enter password'),
      MinLengthValidator(6, errorText: 'Password is too weak'),
    ]);
MultiValidator otpValidator() => MultiValidator([
      RequiredValidator(errorText: 'Please enter valid OTP'),
      MinLengthValidator(4, errorText: 'Please enter valid OTP'),
    ]);
MultiValidator userNameValidator() => MultiValidator([
      RequiredValidator(errorText: 'Please enter valid username'),
      MinLengthValidator(1, errorText: 'Please enter valid username'),
    ]);

MultiValidator firstNameValidator() => MultiValidator([
      RequiredValidator(errorText: 'Please enter first name'),
      MinLengthValidator(1, errorText: 'Please enter first name'),
    ]);
MultiValidator lastNameValidator() => MultiValidator([
      RequiredValidator(errorText: 'Please enter last name'),
      MinLengthValidator(1, errorText: 'Please enter last name'),
    ]);
MultiValidator nameValidator() => MultiValidator([
      RequiredValidator(errorText: 'Please enter name'),
      MinLengthValidator(1, errorText: 'Please enter name'),
    ]);
MultiValidator messageValidator() => MultiValidator([
      RequiredValidator(errorText: 'Please enter message'),
      MinLengthValidator(1, errorText: 'Please enter message'),
    ]);

String? textFieldValidator({String? inputValue, String? errorMessage}) {
  if (inputValue == null || inputValue.isEmpty) {
    return errorMessage;
  }
  return null;
}
