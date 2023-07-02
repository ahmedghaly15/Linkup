import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/global/app_navigator.dart';
import '../../../../core/utils/cache_helper.dart';
import '../../../../core/utils/helper.dart';
import '../../../../core/utils/size_config.dart';
import '../view/manager/auth_view_cubit.dart';
import '../view/manager/auth_view_states.dart';
import '/layout/presenetation/view/layout_view.dart';
import 'auth_button.dart';
import 'confirm_pass_and_phone.dart';
import 'sign_in_mode_and_username_components.dart';
import 'switch_auth_mode.dart';

class AuthForm extends StatelessWidget {
  const AuthForm({
    super.key,
    required this.slideAnimation,
    required this.switchAuthMode,
    required this.formKey,
    required this.authMode,
    required this.emailController,
    required this.usernameController,
    required this.passwordController,
    required this.confirmPassController,
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
    return BlocConsumer<AuthViewCubit, AuthViewStates>(
      listener: (context, state) {
        //=============== Controlling The States ===============
        controlAuthViewStates(state, context);
      },
      builder: (context, state) {
        final AuthViewCubit cubit = AuthViewCubit.getObject(context);
        return Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              SignInModeAndUsernameComponents(
                cubit: cubit,
                formKey: formKey,
                emailController: emailController,
                passwordController: passwordController,
                usernameController: usernameController,
                slideAnimation: slideAnimation,
                authMode: authMode,
                emailFocusNode: emailFocusNode,
                passwordFocusNode: passwordFocusNode,
                confirmPassFocusNode: confirmPassFocusNode,
                usernameFocusNode: usernameFocusNode,
              ),

              //======== For Adding Some Space =========
              SizedBox(height: SizeConfig.screenHeight! * 0.02),

              if (authMode == AuthMode.signUp)
                ConfirmPassAndPhone(
                  cubit: cubit,
                  signUpFormValidation: signUpFormValidation,
                  slideAnimation: slideAnimation,
                  authMode: authMode,
                  formKey: formKey,
                  passwordController: passwordController,
                  confirmPassController: confirmPassController,
                  confirmPassFocusNode: confirmPassFocusNode,
                  phoneController: phoneController,
                  phoneFocusNode: phoneFocusNode,
                ),

              SizedBox(height: SizeConfig.screenHeight! * 0.05),

              AuthButton(
                state: state,
                authMode: authMode,
                signInOrSignUp: signInOrSignUp,
              ),

              SizedBox(height: SizeConfig.screenHeight! * 0.02),

              SwitchAuthMode(
                authMode: authMode,
                switchAuthMode: switchAuthMode,
              ),

              SizedBox(height: SizeConfig.screenHeight! * 0.13),
            ],
          ),
        );
      },
    );
  }

  void controlAuthViewStates(AuthViewStates state, BuildContext context) {
    if (state is SignInErrorState) {
      if (state.error == 'user-not-found') {
        Helper.buildSnackBar(
          message: "No user found for that email",
          state: SnackBarStates.error,
          context: context,
        );
      } else if (state.error == 'wrong-password') {
        Helper.buildSnackBar(
          message: "Wrong Password",
          state: SnackBarStates.error,
          context: context,
        );
      }
    }

    if (state is SignUpErrorState) {
      if (state.error == 'weak-password') {
        Helper.buildSnackBar(
          message: "Password is too weak",
          state: SnackBarStates.error,
          context: context,
        );
      } else if (state.error == 'email-already-in-use') {
        Helper.buildSnackBar(
          message: "Account already exists",
          state: SnackBarStates.error,
          context: context,
        );
      }
    }

    if (state is SignInSuccessState) {
      CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
        AppNavigator.navigateAndFinish(screen: const LayoutView());
      });
    }

    if (state is SignUpSuccessState) {
      CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
        AppNavigator.navigateAndFinish(screen: const LayoutView());
      });
      Helper.buildSnackBar(
        message: "Account Created Successfully",
        state: SnackBarStates.success,
        context: context,
      );
    }

    if (state is CreateUserSuccessState) {
      AppNavigator.navigateAndFinish(screen: const LayoutView());
    }
  }

  void signUpFormValidation(BuildContext context) {
    FocusScope.of(context).unfocus();
    AuthViewCubit.getObject(context).userSignUp(
      context: context,
      email: emailController.text,
      username: usernameController.text,
      password: passwordController.text,
      phone: phoneController.text,
    );
  }

  void signInOrSignUp(BuildContext ctx) {
    if (formKey.currentState!.validate()) {
      //======== Signing The User In ========
      if (authMode == AuthMode.signIn) {
        FocusScope.of(ctx).unfocus();
        AuthViewCubit.getObject(ctx).userSignIn(
          context: ctx,
          email: emailController.text.trim(),
          password: passwordController.text,
        );
      }
      //======== Signing The User Up ========
      else if (authMode == AuthMode.signUp) {
        signUpFormValidation(ctx);
      }
    }
  }
}
