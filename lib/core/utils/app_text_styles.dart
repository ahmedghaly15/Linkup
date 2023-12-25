import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/utils/app_colors.dart';

class AppTextStyles {
  static TextStyle textStyle50Bold = TextStyle(
    fontSize: 50.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryColor,
    letterSpacing: 0.5,
  );

  static TextStyle textStyle28Bold = TextStyle(
    fontSize: 28.sp,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.5,
  );

  static TextStyle textStyle23Bold = TextStyle(
    fontSize: 23.sp,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.7,
  );

  static TextStyle textStyle20Bold = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
  );

  static TextStyle textStyle18 = TextStyle(
    fontSize: 18.sp,
    letterSpacing: 0.5,
  );

  static TextStyle textStyle18Bold = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.5,
  );

  static TextStyle textStyle16 = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
  );

  static TextStyle textStyle16SemiBold = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
  );

  static TextStyle textStyle15 = TextStyle(
    fontSize: 15.sp,
  );

  static TextStyle textStyle13 = TextStyle(
    fontSize: 13.sp,
    height: 1.5.h,
  );
}
