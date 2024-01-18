import 'package:flutter/material.dart';
import 'package:social_app/config/themes/app_colors.dart';
import 'package:social_app/config/themes/app_text_styles.dart';
import 'package:social_app/core/utils/app_strings.dart';

class AppThemes {
  static ThemeData get lightTheme => ThemeData(
        brightness: Brightness.light,
        fontFamily: AppStrings.fontFamily,
        bottomAppBarTheme: const BottomAppBarTheme(
          color: AppColors.scaffoldBackgroundClr,
        ),
        scaffoldBackgroundColor: AppColors.scaffoldBackgroundClr,
        primaryColor: AppColors.primaryColor,
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(
            color: AppColors.primaryColor,
            size: 25,
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: AppColors.scaffoldBackgroundClr,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: AppColors.primaryColor,
          backgroundColor: AppColors.scaffoldBackgroundClr,
          elevation: 20,
        ),
        cardColor: AppColors.scaffoldBackgroundClr,
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            textStyle: MaterialStateProperty.all(
              AppTextStyles.textStyle16SemiBold.copyWith(
                color: AppColors.primaryColor,
              ),
            ),
            padding: MaterialStateProperty.all(EdgeInsets.zero),
          ),
        ),
        popupMenuTheme: const PopupMenuThemeData(
          color: Colors.white,
          iconColor: Colors.white,
          position: PopupMenuPosition.under,
        ),
      );

  static ThemeData get darkTheme => ThemeData(
        brightness: Brightness.dark,
        fontFamily: AppStrings.fontFamily,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: AppColors.primaryColor,
          backgroundColor: AppColors.darkPrimaryColor,
          elevation: 20,
        ),
        primaryColor: AppColors.primaryColor,
        scaffoldBackgroundColor: AppColors.darkPrimaryColor,
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(
            color: AppColors.primaryColor,
            size: 25,
          ),
          elevation: 0,
          centerTitle: true,
          backgroundColor: AppColors.darkPrimaryColor,
        ),
        cardColor: AppColors.darkHeaderClr,
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            textStyle: MaterialStateProperty.all(
              AppTextStyles.textStyle16SemiBold.copyWith(
                color: AppColors.primaryColor,
              ),
            ),
          ),
        ),
        popupMenuTheme: const PopupMenuThemeData(
          color: AppColors.darkPrimaryColor,
          iconColor: Colors.white,
          position: PopupMenuPosition.under,
        ),
      );
}
