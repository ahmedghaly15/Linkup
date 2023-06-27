import 'package:flutter/material.dart';

import '../../../../core/utils/size_config.dart';

import '../../../../core/widgets/input_field.dart';
import '../view/manager/auth_view_cubit.dart';
import 'user_name_component.dart';

class SignInModeAndUsernameComponents extends StatelessWidget {
  const SignInModeAndUsernameComponents({
    super.key,
    required this.cubit,
    required this.emailController,
    required this.passwordController,
    required this.formKey,
    required this.authMode,
    required this.usernameController,
    required this.slideAnimation,
    required this.emailFocusNode,
    required this.passwordFocusNode,
    required this.usernameFocusNode,
    required this.confirmPassFocusNode,
  });

  final AuthViewCubit cubit;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController usernameController;
  final GlobalKey<FormState> formKey;
  final AuthMode authMode;
  final Animation<Offset> slideAnimation;

  final FocusNode emailFocusNode;
  final FocusNode passwordFocusNode;
  final FocusNode usernameFocusNode;
  final FocusNode confirmPassFocusNode;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        InputField(
          key: const ValueKey("email"),
          focusNode: emailFocusNode,
          hint: "Email",
          controller: emailController,
          obsecure: false,
          keyboardType: TextInputType.emailAddress,
          textCapitalization: TextCapitalization.none,
          validating: (val) {
            if (val!.isEmpty || !val.contains('@')) {
              return "Email can't be blank";
            }
            return null;
          },
          onEditingComplete: () {
            if (authMode == AuthMode.signIn) {
              FocusScope.of(context).requestFocus(passwordFocusNode);
            } else if (authMode == AuthMode.signUp) {
              FocusScope.of(context).requestFocus(usernameFocusNode);
            }
          },
        ),
        //======== For Adding Some Space ==========
        SizedBox(height: SizeConfig.screenHeight! * 0.02),

        if (authMode == AuthMode.signUp) ...[
          UsernameComponent(
            slideAnimation: slideAnimation,
            usernameController: usernameController,
            passwordFocusNode: passwordFocusNode,
            usernameFocusNode: usernameFocusNode,
          ),
          SizedBox(height: SizeConfig.screenHeight! * 0.02),
        ],

        //======== Password Input Field =========
        InputField(
          key: const ValueKey("password"),
          focusNode: passwordFocusNode,
          hint: "Password",
          controller: passwordController,
          obsecure: cubit.passVisibility,
          keyboardType: TextInputType.visiblePassword,
          textCapitalization: TextCapitalization.none,
          icon: IconButton(
            onPressed: () {
              cubit.switchPassVisibility();
            },
            icon: Icon(
              cubit.passVisibility
                  ? Icons.visibility_rounded
                  : Icons.visibility_off_rounded,
            ),
          ),
          validating: (val) {
            if (val!.isEmpty) {
              return "Enter a password";
            } else if (val.length < 8) {
              return "Too short pasword";
            }
            return null;
          },
          onSubmit: (String value) {
            if (authMode == AuthMode.signIn) {
              if (formKey.currentState!.validate()) {
                FocusScope.of(context).unfocus();
                AuthViewCubit.getObject(context).userSignIn(
                  context: context,
                  email: emailController.text,
                  password: passwordController.text,
                );
              }
            }
          },
          onEditingComplete: () {
            if (authMode == AuthMode.signUp) {
              FocusScope.of(context).requestFocus(confirmPassFocusNode);
            }
          },
        )
      ],
    );
  }
}
