import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/global/app_colors.dart';
import '../view/manager/auth_view_cubit.dart';
import '../view/manager/auth_view_states.dart';
import '/core/widgets/custom_button.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    super.key,
    required this.state,
    required this.authMode,
    required this.signInOrSignUp,
  });

  final AuthViewStates state;
  final AuthMode authMode;
  final void Function(BuildContext context) signInOrSignUp;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: ConditionalBuilder(
        condition: state is! SignInLoadingState && state is! SignUpLoadingState,
        builder: (context) => CustomButton(
          buttonText: authMode == AuthMode.signIn ? "Sign In" : "Sign Up",
          onPressed: () => signInOrSignUp(context),
        ),
        fallback: (context) => Center(
          child: CircularProgressIndicator(
            color: Get.isDarkMode
                ? AppColors.darkHeaderClr
                : AppColors.inputFieldColor,
            backgroundColor: AppColors.primaryColor,
          ),
        ),
      ),
    );
  }
}
