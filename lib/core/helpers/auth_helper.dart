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

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a phone number.';
    }

    final RegExp phoneRegex = RegExp(
      r'^\d{11}$',
      caseSensitive: false,
      multiLine: false,
    );

    if (!phoneRegex.hasMatch(value)) {
      return 'Please enter a valid phone number.';
    }

    return null;
  }

  static String? validateLink(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a link.';
    }

    // Use a regular expression to check if the link is valid
    final RegExp urlRegex = RegExp(
      r'^(https?|ftp):\/\/[^\s/$.?#].[^\s]*$',
      caseSensitive: false,
      multiLine: false,
    );

    if (!urlRegex.hasMatch(value)) {
      return 'Please enter a valid link.';
    }

    return null;
  }

  static void keyboardUnfocus(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  static void requestFocus(BuildContext context, FocusNode focusNode) =>
      FocusScope.of(context).requestFocus(focusNode);
}
