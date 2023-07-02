import 'package:flutter/material.dart';
import 'package:social_app/core/global/app_colors.dart';

class AppStyles {
  static const TextStyle headingLarge = TextStyle(
    fontSize: 50,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryColor,
    letterSpacing: 0.5,
  );

  static const TextStyle customButtonTextStyle = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.5,
    color: Colors.white,
  );

  static TextStyle appBarTitleStyle = const TextStyle(
    fontSize: 23,
    fontWeight: FontWeight.bold,
    // color: ThemeCubit.isDark ? Colors.white : Colors.black,
    letterSpacing: 0.7,
  );

  static TextStyle inputFieldTextStyle = const TextStyle(
    fontSize: 20,
    // color: ThemeCubit.isDark ? Colors.white : Colors.black,
  );

  static const TextStyle hintStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    color: Colors.grey,
  );

  static TextStyle bodyLarge = const TextStyle(
    fontSize: 18,
    // color: ThemeCubit.isDark ? Colors.white : Colors.black,
    letterSpacing: 0.5,
  );

  static const TextStyle customTextButtonTextStyle = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryColor,
  );

  static TextStyle bodySmall = const TextStyle(
    fontSize: 16,
    // color: ThemeCubit.isDark ? Colors.white : Colors.black,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 13,
    color: Colors.grey,
    height: 1.5,
  );
}
