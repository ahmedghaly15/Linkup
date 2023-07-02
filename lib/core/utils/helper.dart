import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../global/app_colors.dart';
import '../models/user_model.dart';
import '../widgets/custom_bottom_sheet.dart';
import '/core/global/app_navigator.dart';
import '/core/global/app_styles.dart';

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

  static UserModel? model;

// The User's Id
  static String? uId;

  static void buildSnackBar({
    required String message,
    required SnackBarStates state,
    required BuildContext context,
  }) {
    final SnackBar snackBar = SnackBar(
      content: Text(
        message,
        style: const TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
      dismissDirection: DismissDirection.down,
      clipBehavior: Clip.hardEdge,
      backgroundColor: chooseSnackBarClr(state),
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      padding: const EdgeInsets.all(15.0),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

//================== For Easy Choosing The Color Of The SnackBar ==================
  static Color chooseSnackBarClr(SnackBarStates state) {
    Color color;
    switch (state) {
      case SnackBarStates.success:
        color = Colors.green;
        break;
      case SnackBarStates.error:
        color = Colors.red;
        break;
      case SnackBarStates.warning:
        color = Colors.amber;
        break;
    }
    return color;
  }

  static AppBar appBarBuilder({
    required BuildContext context,
    bool centerTitle = true,
    String? title,
    List<Widget>? actions,
  }) =>
      AppBar(
        backgroundColor: context.theme.colorScheme.background,
        title: Text(title ?? "", style: AppStyles.appBarTitleStyle),
        centerTitle: centerTitle,
        leading: IconButton(
          onPressed: () => AppNavigator.getBack(),
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
      builder: (context) => CustomBottomSheet(
        context: context,
        type: type,
        onPressedCamera: onPressedCamera,
        onPressedGallery: onPressedGallery,
      ),
    );
  }

  static double intToDouble(int num) {
    double doubleNum = num.toDouble();
    return doubleNum;
  }

  static String getDate() {
    DateTime dateTime = DateTime.now();
    String date = DateFormat.yMMMd().format(dateTime);
    return date;
  }

/*

void navigateAndFinish(context, {required Widget screen}) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => screen),
    (Route<dynamic> route) => false, // remove all previous routes
  );
}

void printFullText(String text) {
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

 */
}
