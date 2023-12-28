import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:social_app/core/models/user_model.dart';

enum SnackBarStates { success, error, warning }

class Helper {
  static UserModel? currentUser;

// The User's Id
  static String? uId;

  static String getDate() {
    DateTime dateTime = DateTime.now();
    String date = DateFormat.yMMMd().format(dateTime);
    return date;
  }

  static bool isDark(ThemeData themeState) =>
      themeState.brightness == Brightness.dark;

  static BoxShadow postShadow(ThemeData state) {
    return BoxShadow(
      offset: Offset(0, 1.73.h),
      blurRadius: 5.h,
      color: isDark(state) ? Colors.grey.shade700 : Colors.grey,
    );
  }

/*
void printFullText(String text) {
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

 */
}
