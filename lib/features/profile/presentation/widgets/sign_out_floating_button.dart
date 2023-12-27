import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_app/config/router/routes.dart';
import 'package:social_app/core/helpers/cache_helper.dart';
import 'package:social_app/core/utils/app_navigator.dart';
import 'package:social_app/core/utils/app_strings.dart';
import 'package:social_app/service_locator.dart';

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

  void signOut(BuildContext context) async {
    // CacheHelper.removeData(key: 'uId').then((value) {
    //   if (value) {
    //     AppNavigator.navigateAndFinish(screen: const AuthView());
    //   }
    // });

    await getIt
        .get<CacheHelper>()
        .removeData(key: AppStrings.uId)
        .then((value) async {
      await getIt.get<FirebaseAuth>().signOut();
      context.navigateAndReplacement(newRoute: Routes.signInRoute);
    });
  }
}
