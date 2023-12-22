import 'package:flutter/material.dart';

import '../../../../core/utils/app_text_styles.dart';
import '../../../../core/utils/size_config.dart';
import '../views/manager/auth_view_cubit.dart';
import '../../../../core/utils/app_strings.dart';
import 'auth_form.dart';

class AuthViewBody extends StatelessWidget {
  const AuthViewBody({
    super.key,
    required this.slideAnimation,
    required this.formKey,
    required this.emailController,
    required this.usernameController,
    required this.passwordController,
    required this.confirmPassController,
    required this.switchAuthMode,
    required this.authMode,
    required this.emailFocusNode,
    required this.passwordFocusNode,
    required this.usernameFocusNode,
    required this.confirmPassFocusNode,
    required this.phoneController,
    required this.phoneFocusNode,
  });

  final Animation<Offset> slideAnimation;
  final void Function() switchAuthMode;
  final GlobalKey<FormState> formKey;
  final AuthMode authMode;

  //============ TextFormFields Controllers ============
  final TextEditingController emailController;
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final TextEditingController confirmPassController;
  final TextEditingController phoneController;

  final FocusNode emailFocusNode;
  final FocusNode passwordFocusNode;
  final FocusNode usernameFocusNode;
  final FocusNode confirmPassFocusNode;
  final FocusNode phoneFocusNode;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.screenWidth! * 0.05,
            vertical: SizeConfig.screenHeight! * 0.03,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                authMode == AuthMode.signIn ? "SIGN IN" : "SIGN UP",
                style: AppTextStyles.textStyle50Bold,
                textAlign: TextAlign.left,
              ),
              // For Adding Some Space
              SizedBox(height: SizeConfig.screenHeight! * 0.01),
              Text(
                authMode == AuthMode.signIn ? '' : '',
                style: AppTextStyles.textStyle18,
              ),
              SizedBox(height: SizeConfig.screenHeight! * 0.03),
              //======================= Auth Form =======================
              AuthForm(
                slideAnimation: slideAnimation,
                authMode: authMode,
                switchAuthMode: switchAuthMode,
                formKey: formKey,
                emailController: emailController,
                usernameController: usernameController,
                passwordController: passwordController,
                confirmPassController: confirmPassController,
                emailFocusNode: emailFocusNode,
                passwordFocusNode: passwordFocusNode,
                confirmPassFocusNode: confirmPassFocusNode,
                usernameFocusNode: usernameFocusNode,
                phoneController: phoneController,
                phoneFocusNode: phoneFocusNode,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
