import 'package:flutter/material.dart';

class AppColors {
  static const Color darkGrey = Color(0xFF898A83);
  static const Color lightGrey = Color(0xff6C7A9C);
  static const Color scaffoldBackgroundClr = Colors.white;
  static const Color primaryColor = Color(0xFF5790DF);
  static const Color darkPrimaryColor = Color(0xFF121212);
  static const Color darkHeaderClr = Color(0xFF424242);
  static const Color lightWhiteBlue = Color(0xffE6EEFA);
  static const Color iconsColor = Color(0xff130F26);
  static const List<Color> loadingColors = <Color>[
    primaryColor,
    Color(0xff4B6C9F),
    Color(0xff6C79DF),
    Color(0xff3C567F),
  ];

  static const Color shimmerContainerColor = Colors.grey;
  static Color shimmerBaseColor = Colors.grey.shade300;
  static Color darkShimmerBaseColor = Colors.grey.shade700.withOpacity(0.6);
  static Color shimmerHighlightColor = Colors.grey.shade100;
  static Color darkShimmerHighlightColor =
      Colors.grey.shade800.withOpacity(0.3);
}
