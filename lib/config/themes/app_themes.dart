import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/utils/app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme => ThemeData.light().copyWith(
        brightness: Brightness.light,
        // colorScheme: const ColorScheme.light(
        //   background: AppColors.scaffoldBackgroundClr,
        // ),

        textTheme: GoogleFonts.interTextTheme(ThemeData.light().textTheme),
        bottomAppBarTheme: const BottomAppBarTheme(
          color: AppColors.scaffoldBackgroundClr,
        ),
        scaffoldBackgroundColor: AppColors.scaffoldBackgroundClr,

        primaryColor: AppColors.primaryColor,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
          backgroundColor: AppColors.scaffoldBackgroundClr,
          // systemOverlayStyle: SystemUiOverlayStyle(
          //   systemNavigationBarColor: AppColors.scaffoldBackgroundClr,
          //   statusBarColor: AppColors.scaffoldBackgroundClr,
          //   statusBarBrightness: Brightness.dark,
          // ),
        ),
      );
  static ThemeData get darkTheme => ThemeData.dark().copyWith(
        brightness: Brightness.dark,
        // colorScheme: const ColorScheme.dark(
        //   background: AppColors.darkGreyClr,
        // ),
        textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
        bottomAppBarTheme:
            const BottomAppBarTheme(color: AppColors.darkGreyClr),
        primaryColor: AppColors.primaryColor,
        scaffoldBackgroundColor: AppColors.darkGreyClr,
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(
            color: AppColors.primaryColor,
            size: 25,
          ),
          elevation: 0,
          centerTitle: true,
          backgroundColor: AppColors.darkGreyClr,
          // systemOverlayStyle: SystemUiOverlayStyle(
          //   systemNavigationBarColor: AppColors.darkGreyClr,
          //   statusBarColor: AppColors.darkGreyClr,
          //   statusBarBrightness: Brightness.light,
          // ),
        ),
      );
}
