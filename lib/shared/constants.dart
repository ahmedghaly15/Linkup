import 'package:flutter/material.dart';
// import 'package:social_app/styles/iconbroken.dart';

import '../modules/auth/auth_screen.dart';
import '../network/local/cache_helper.dart';
import '../styles/colors.dart';
import 'package:intl/intl.dart';
// import '/layout/cubit/cubit.dart';
// import '/network/local/cache_helper.dart';

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
    duration: const Duration(seconds: 5),
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
  // final prefs = await SharedPreferences.getInstance();

  // prefs.clear();

  // navigateAndFinish(context, screen: const AuthScreen());
  // FirebaseAuth.instance.signOut();
  CacheHelper.removeData(key: 'uId').then((value) {
    if (value) {
      navigateAndFinish(context, screen: const AuthScreen());
    }
  });
}

//================== For Print A Complete String ==================
void printFullText(String text) {
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

//================== For Building An AppBar ==================
AppBar appBarBuilder({
  required BuildContext context,
  bool centerTitle = true,
  String? title,
  List<Widget>? actions,
}) =>
    AppBar(
      title: Text(title ?? ""),
      centerTitle: centerTitle,
      leading: IconButton(
        onPressed: () => navigateBack(context),
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
      ),
      actions: actions,
    );

//================== For Building A Default TextButton ==================
Widget defaultTextButton({
  required void Function()? onPressed,
  required String title,
  TextStyle? textStyle = const TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.bold,
    color: defaultColor,
  ),
}) =>
    TextButton(
      onPressed: onPressed,
      child: Text(title, style: textStyle),
    );

void buildBottomSheet({
  required BuildContext context,
  required void Function()? onPressedGallery,
  required void Function()? onPressedCamera,
  required String type,
}) {
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: BottomSheet(
            enableDrag: true,
            onClosing: () => navigateBack(context),
            builder: (context) {
              return ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                children: <Widget>[
                  Text(
                    "Pick $type Picture",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      letterSpacing: 0.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: onPressedGallery,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: const CircleBorder(),
                          fixedSize: const Size(180, 130),
                        ),
                        child: Image.asset(
                          'assets/images/add_image.png',
                          width: 180,
                          height: 100,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: onPressedCamera,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: const CircleBorder(),
                          fixedSize: const Size(180, 130),
                        ),
                        child: Image.asset(
                          'assets/images/camera.png',
                          width: 180,
                          height: 100,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        );
      });
}

double intToDouble(int num) {
  double doubleNum = num.toDouble();
  return doubleNum;
}

String getDate() {
  DateTime dateTime = DateTime.now();
  String date = DateFormat.yMMMd().format(dateTime);
  return date;
}
