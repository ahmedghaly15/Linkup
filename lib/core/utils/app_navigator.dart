import 'package:flutter/material.dart';

extension AppNavigator on BuildContext {
  void navigateTo({required String routeName, Object? arguments}) {
    Navigator.pushNamed(this, routeName, arguments: arguments);
  }

  void navigateAndReplacement({required String newRoute, Object? arguments}) {
    Navigator.pushReplacementNamed(this, newRoute, arguments: arguments);
  }

  Future<Object?> navigateAndRemoveUntil({
    required String newRoute,
    Object? arguments,
  }) {
    return Navigator.pushNamedAndRemoveUntil(
      this,
      newRoute,
      (Route<dynamic> route) => false, // remove all previous routes
      arguments: arguments,
    );
  }

  void getBack() {
    Navigator.pop(this);
  }
}
