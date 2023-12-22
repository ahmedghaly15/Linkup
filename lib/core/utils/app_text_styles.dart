import 'package:flutter/material.dart';
import 'package:social_app/core/utils/app_colors.dart';

class AppTextStyles {
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
    letterSpacing: 0.7,
  );

  static TextStyle inputFieldTextStyle = const TextStyle(
    fontSize: 20,
  );

  static const TextStyle hintStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    color: Colors.grey,
  );

  static TextStyle bodyLarge = const TextStyle(
    fontSize: 18,
    letterSpacing: 0.5,
  );

  static const TextStyle customTextButtonTextStyle = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryColor,
  );

  static TextStyle bodySmall = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 13,
    color: Colors.grey,
    height: 1.5,
  );
}
