import 'package:flutter/material.dart';

class AuthHelper {
  static String? validatingEmailField({String? value}) {
    if (value!.isEmpty) {
      return "Email can't be blank!";
    } else if (!value.contains('@')) {
      return "Incorrect Email!";
    }

    return null;
  }

  static String? validatingPasswordField({String? value}) {
    if (value!.isEmpty) {
      return "Password can't be blank!";
    } else if (value.length < 8) {
      return "Too short password!";
    }
    return null;
  }

  static String? validateConfirmPassField({
    String? value,
    required String password,
  }) {
    if (value!.isEmpty || value != password) {
      return "Passwords don't match";
    }

    return null;
  }

  static String? validatingField({
    String? value,
    required String fieldName,
  }) {
    if (value!.isEmpty) {
      return "$fieldName can't be blank";
    }
    return null;
  }

  static String? validatePhoneField({String? value}) {
    if (value!.isEmpty) {
      return "Phone number can't be blank";
    }
    return null;
  }

  static void keyboardUnfocus(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  static void requestFocus(BuildContext context, FocusNode focusNode) =>
      FocusScope.of(context).requestFocus(focusNode);
}
