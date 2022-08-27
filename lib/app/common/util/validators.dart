import 'package:get/get.dart';

import '../values/strings.dart';

abstract class Validators {
  static String? validateEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return Strings.fieldCantBeEmpty.tr;
    }
    return null;
  }

  static String? validateEmail(String? value, bool isEmailDuplicated) {
    const pattern =
        r'^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$';
    if (value == null || value.isEmpty) {
      return Strings.emailCantBeEmpty.tr;
    } else if (!RegExp(pattern).hasMatch(value)) {
      return Strings.enterValidEmail.tr;
    } else if (isEmailDuplicated) {
      return Strings.duplicatedEmail.tr;
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return Strings.passCantBeEmpty.tr;
    } else if (value.length < 6) {
      return Strings.passLengthtMsg.tr;
    }
    return null;
  }

  static String? validateConfirmPassword(String? confirmPassword, String? password) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return Strings.confirmPassCantBeEmpty.tr;
    } else if (confirmPassword.length < 6) {
      return Strings.confirmPassLengthtMsg.tr;
    } else if (confirmPassword != (password ?? '')) {
      return Strings.confirmPassNotMatchMsg.tr;
    }
    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return Strings.fieldCantBeEmpty.tr;
    } else if (value.length != 10) {
      return Strings.enterValidPhone.tr;
    }
    return null;
  }
}
