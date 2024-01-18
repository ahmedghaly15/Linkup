import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(
            color: AppColors.primaryColor,
            size: 25.w,
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: AppColors.scaffoldBackgroundClr,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: AppColors.primaryColor,
          backgroundColor: AppColors.scaffoldBackgroundClr,
          elevation: 20.h,
        ),
        cardColor: AppColors.scaffoldBackgroundClr,
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            textStyle: MaterialStatePropertyAll(
              AppTextStyles.textStyle16SemiBold,
            ),
            foregroundColor: const MaterialStatePropertyAll(
              AppColors.primaryColor,
            ),
            padding: MaterialStatePropertyAll(
              EdgeInsets.symmetric(
                horizontal: 8.w,
                vertical: 8.h,
              ),
            ),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            minimumSize: const MaterialStatePropertyAll(Size.zero),
          ),
        ),
        popupMenuTheme: const PopupMenuThemeData(
          color: Colors.white,
          iconColor: Colors.white,
          position: PopupMenuPosition.under,
        ),
        iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            padding: MaterialStateProperty.all(EdgeInsets.zero),
          ),
        ),
      );

  static ThemeData get darkTheme => ThemeData(
        brightness: Brightness.dark,
        fontFamily: AppStrings.fontFamily,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: AppColors.primaryColor,
          backgroundColor: AppColors.darkPrimaryColor,
          elevation: 20.h,
        ),
        primaryColor: AppColors.primaryColor,
        scaffoldBackgroundColor: AppColors.darkPrimaryColor,
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(
            color: AppColors.primaryColor,
            size: 25.w,
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
