import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '/core/global/app_colors.dart';

class AppTheme {
  static ThemeData lightTheme() => ThemeData.light().copyWith(
        brightness: Brightness.light,
        colorScheme: const ColorScheme.light(
          background: AppColors.scaffoldBackgroundClr,
        ),
        textTheme: GoogleFonts.interTextTheme(ThemeData.light().textTheme),
        bottomAppBarTheme: const BottomAppBarTheme(
          color: AppColors.scaffoldBackgroundClr,
        ),
        primaryColor: AppColors.primaryColor,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle(
            systemNavigationBarColor: AppColors.scaffoldBackgroundClr,
            statusBarColor: AppColors.scaffoldBackgroundClr,
            statusBarBrightness: Brightness.dark,
          ),
        ),
      );
  static ThemeData darkTheme() => ThemeData.dark().copyWith(
        brightness: Brightness.dark,
        colorScheme: const ColorScheme.dark(
          background: AppColors.darkGreyClr,
        ),
        textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
        bottomAppBarTheme:
            const BottomAppBarTheme(color: AppColors.darkGreyClr),
        primaryColor: AppColors.primaryColor,
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(
            color: AppColors.primaryColor,
            size: 25,
          ),
          elevation: 0,
          centerTitle: true,
          systemOverlayStyle: SystemUiOverlayStyle(
            systemNavigationBarColor: AppColors.darkGreyClr,
            statusBarColor: AppColors.darkGreyClr,
            statusBarBrightness: Brightness.light,
          ),
        ),
      );
}
