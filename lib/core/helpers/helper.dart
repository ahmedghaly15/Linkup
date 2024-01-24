import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:social_app/config/themes/app_colors.dart';
import 'package:social_app/core/models/user_model.dart';
import 'package:social_app/core/utils/app_assets.dart';

class Helper {
  static UserModel? currentUser;

  // The User's Id
  static String? uId;

  static String getDate() {
    DateTime dateTime = DateTime.now();
    String date = DateFormat.yMMMd().format(dateTime);
    return date;
  }

  static bool isDark(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  static BoxShadow postShadow(BuildContext context) {
    return BoxShadow(
      offset: Offset(0, 1.73.h),
      blurRadius: 5.h,
      color: isDark(context) ? Colors.grey.shade700 : Colors.grey,
    );
  }

  static BoxDecoration backgroundImageDecoration(BuildContext context) {
    return const BoxDecoration(
      image: DecorationImage(
        image: AssetImage(
          AppAssets.imagesBackgroundImage,
        ),
        fit: BoxFit.cover,
      ),
    );
  }

  static BoxShadow buttonShadow(Color color) => BoxShadow(
        offset: Offset(0, 10.h),
        blurRadius: 20.h,
        spreadRadius: 0,
        color: color,
      );

  static BoxDecoration postDecoration(BuildContext context) {
    return BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(40.r)),
      color: isDark(context)
          ? AppColors.darkPrimaryColor
          : AppColors.lightWhiteBlue,
      boxShadow: isDark(context)
          ? <BoxShadow>[
              postShadow(context),
            ]
          : null,
    );
  }

/*
void printFullText(String text) {
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

 */
}
