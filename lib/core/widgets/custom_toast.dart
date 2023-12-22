import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum CustomToastState { success, error, warning }

class CustomToast {
  static void showToast({
    required String text,
    required CustomToastState state,
  }) {
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: _chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.sp,
    );
  }

  static Color _chooseToastColor(CustomToastState state) {
    Color color;
    switch (state) {
      case CustomToastState.success:
        color = Colors.green;
        break;
      case CustomToastState.error:
        color = Colors.red;
        break;
      case CustomToastState.warning:
        color = Colors.amber;
        break;
    }
    return color;
  }
}
