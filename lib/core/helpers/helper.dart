import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../utils/app_colors.dart';
import '../models/user_model.dart';
import '../widgets/custom_image_bottom_sheet.dart';
import '../utils/app_navigator.dart';
import '../utils/app_text_styles.dart';

enum SnackBarStates { success, error, warning }

class Helper {
  static SystemUiOverlayStyle setSystemOverlayStyle() {
    return SystemUiOverlayStyle(
      systemNavigationBarColor:
          Get.isDarkMode ? AppColors.darkGreyClr : Colors.white,
      statusBarColor: Get.isDarkMode ? AppColors.darkGreyClr : Colors.white,
      statusBarBrightness: Get.isDarkMode ? Brightness.light : Brightness.dark,
    );
  }

  static UserModel? currentUser;

// The User's Id
  static String? uId;

  static AppBar appBarBuilder({
    required BuildContext context,
    bool centerTitle = true,
    String? title,
    List<Widget>? actions,
  }) =>
      AppBar(
        backgroundColor: context.theme.colorScheme.background,
        title: Text(title ?? "", style: AppTextStyles.textStyle23Bold),
        centerTitle: centerTitle,
        leading: IconButton(
          onPressed: () => context.getBack(),
          icon: Icon(
            Icons.arrow_back_ios,
            color: Get.isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        actions: actions,
        systemOverlayStyle: setSystemOverlayStyle(),
      );

  static void buildBottomSheet({
    required BuildContext context,
    required void Function()? onPressedGallery,
    required void Function()? onPressedCamera,
    required String type,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (context) => CustomImageBottomSheet(
        type: type,
        onPressedCamera: onPressedCamera,
        onPressedGallery: onPressedGallery,
      ),
    );
  }

  static String getDate() {
    DateTime dateTime = DateTime.now();
    String date = DateFormat.yMMMd().format(dateTime);
    return date;
  }

  static bool isDark(ThemeData themeState) =>
      themeState.brightness == Brightness.dark;

/*
void printFullText(String text) {
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

 */
}
