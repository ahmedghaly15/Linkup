import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppConstants {
  static EdgeInsetsGeometry get horizontalPadding =>
      EdgeInsets.symmetric(horizontal: 16.w);

  static ScrollPhysics? get physics => const BouncingScrollPhysics();

  static Duration get onboardingScrollingDuration =>
      const Duration(milliseconds: 650);

  static double get expandedHeight => 100.h;

  static double get appBarElevation => 0;
}
