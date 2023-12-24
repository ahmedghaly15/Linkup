import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppConstants {
  static EdgeInsetsGeometry get horizontalPadding =>
      EdgeInsets.symmetric(horizontal: 16.w);

  static ScrollPhysics? get physics => const BouncingScrollPhysics();
}
