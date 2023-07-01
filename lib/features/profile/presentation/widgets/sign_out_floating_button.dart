import 'package:flutter/material.dart';

import '../../../../core/global/app_styles.dart';
import '../../../../shared/constants.dart';

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
          style: AppStyles.bodyLarge.copyWith(
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
}
