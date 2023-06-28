import 'package:flutter/material.dart';
import 'package:social_app/features/auth/presentation/view/auth_view.dart';

import '../core/utils/cache_helper.dart';
import '/styles/thems.dart';
import 'package:intl/intl.dart';

//=========== For Switching Between The State Of The Snack Bar ===========
enum SnackBarStates { success, error, warning }

// The User's Id
String? uId;

//================== For Building A Snack Bar ==================
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

//================== For Navigating To A Screen & Remove All The Previous Screens ==================
void navigateAndFinish(context, {required Widget screen}) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => screen),
    (Route<dynamic> route) => false, // remove all previous routes
  );
}

//================== For Navigating Back ==================
void navigateBack(context) {
  Navigator.pop(context);
}

//================== For Navigating To A Screen ==================
void navigateTo(context, Widget screen) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => screen));
}

//================== For Signing The Current User Out ==================
void signOut(context) async {
  CacheHelper.removeData(key: 'uId').then((value) {
    if (value) {
      navigateAndFinish(context, screen: const AuthView());
    }
  });
}

//================== For Print A Complete String ==================
void printFullText(String text) {
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

//================== For Building An AppBar ==================

//================== For Building A Default TextButton ==================
Widget defaultTextButton({
  required void Function()? onPressed,
  required String title,
  TextStyle? textStyle = const TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.bold,
    color: defaultColor,
  ),
}) =>
    TextButton(
      onPressed: onPressed,
      child: Text(title, style: textStyle),
    );

//================== For Building A Bottom Sheet ==================

double intToDouble(int num) {
  double doubleNum = num.toDouble();
  return doubleNum;
}

String getDate() {
  DateTime dateTime = DateTime.now();
  String date = DateFormat.yMMMd().format(dateTime);
  return date;
}
