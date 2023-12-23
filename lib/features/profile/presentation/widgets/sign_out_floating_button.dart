import 'package:flutter/material.dart';

import '../../../../core/utils/app_text_styles.dart';

class SignOutFloatingButton extends StatelessWidget {
  const SignOutFloatingButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 15.0,
        horizontal: 5.0,
      ),
      child: FloatingActionButton.extended(
        heroTag: "Floating Sign Out Button",
        backgroundColor: Colors.redAccent,
        onPressed: () => signOut(context),
        label: Text(
          "Sign out",
          style: AppTextStyles.textStyle18.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        icon: const Icon(
          Icons.logout_rounded,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }

  void signOut(context) async {
    // CacheHelper.removeData(key: 'uId').then((value) {
    //   if (value) {
    //     AppNavigator.navigateAndFinish(screen: const AuthView());
    //   }
    // });
  }
}
