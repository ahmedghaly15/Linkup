import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:social_app/core/global/app_navigator.dart';
import 'package:social_app/core/global/app_styles.dart';

import '../global/app_colors.dart';
import '../widgets/custom_bottom_sheet.dart';

SystemUiOverlayStyle setSystemOverlayStyle() {
  return SystemUiOverlayStyle(
    systemNavigationBarColor:
        Get.isDarkMode ? AppColors.darkGreyClr : Colors.white,
    statusBarColor: Get.isDarkMode ? AppColors.darkGreyClr : Colors.white,
    statusBarBrightness: Get.isDarkMode ? Brightness.light : Brightness.dark,
  );
}

enum SnackBarStates { success, error, warning }

// The User's Id
String? uId;

void buildSnackBar({
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
Color chooseSnackBarClr(SnackBarStates state) {
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

AppBar appBarBuilder({
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

void buildBottomSheet({
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
