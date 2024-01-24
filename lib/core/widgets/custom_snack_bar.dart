import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/config/themes/app_text_styles.dart';

enum CustomSnackBarState { warning, success, error }

class CustomSnackBar {
  static void show({
    required BuildContext context,
    required String message,
    required CustomSnackBarState state,
    bool showCloseIcon = true,
    Duration duration = const Duration(seconds: 2),
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        content: Row(
          children: <Widget>[
            Icon(
              _chooseSnackBarIcon(state),
              color: Colors.white,
              size: 40.w,
            ),
            SizedBox(width: 10.w),
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    _chooseSnackBarTitle(state),
                    style: AppTextStyles.textStyle16Medium.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    message,
                    style: AppTextStyles.textStyle13.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        dismissDirection: DismissDirection.horizontal,
        showCloseIcon: showCloseIcon,
        closeIconColor: Colors.white,
        backgroundColor: _chooseSnackBarColor(state),
        duration: duration,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
      ),
    );
  }

  static Color _chooseSnackBarColor(CustomSnackBarState state) {
    Color color;
    switch (state) {
      case CustomSnackBarState.success:
        color = Colors.green;
        break;
      case CustomSnackBarState.error:
        color = Colors.red;
        break;
      case CustomSnackBarState.warning:
        color = Colors.amber;
        break;
    }
    return color;
  }

  static IconData _chooseSnackBarIcon(CustomSnackBarState state) {
    IconData icon;

    switch (state) {
      case CustomSnackBarState.warning:
        icon = Icons.warning_amber_outlined;
        break;

      case CustomSnackBarState.success:
        icon = Icons.check_circle;
        break;

      case CustomSnackBarState.error:
        icon = Icons.error;
        break;
    }

    return icon;
  }

  static String _chooseSnackBarTitle(
    CustomSnackBarState state,
  ) {
    String title;

    switch (state) {
      case CustomSnackBarState.error:
        title = 'Something went wrong';
        break;
      case CustomSnackBarState.warning:
        title = 'Warning';
        break;

      case CustomSnackBarState.success:
        title = 'Success';
        break;
    }

    return title;
  }
}
