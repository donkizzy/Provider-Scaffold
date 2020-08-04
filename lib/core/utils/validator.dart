

import 'package:provider_base/core/constants/app_contstants.dart';

class EmailValidator {
  static String validateEmail(String value) {
    if (value != null) {
      if (value.isEmpty) {
        return emptyEmailField;
      }
      // Regex for email validation
      RegExp regExp = new RegExp(emailRegex);
      if (regExp.hasMatch(value)) {
        return null;
      }
      return invalidEmailField;
    } else
      return null;
  }
}

class PasswordValidator {
  static String validatePassword(String value) {
    if (value != null) {
      if (value.isEmpty) {
        return emptyPasswordField;
      }

      if (value.length < 6) {
        return passwordLengthError;
      }
    } else
      return null;
    return null;
  }
}

class UsernameValidator {
  static String validateUsername(String value) {
    if (value != null) {
      if (value.isEmpty) {
        return emptyUsernameField;
      }

      if (value.length < 6) {
        return usernameLengthError;
      }
    } else
      return null;

    return null;
  }
}

class FieldValidator {
  static String validate(String value) {
    if (value != null) {
      if (value.isEmpty) {
        return emptyTextField;
      }
    } else
      return null;

    return null;
  }
}
