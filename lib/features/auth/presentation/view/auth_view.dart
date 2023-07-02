import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../core/global/app_colors.dart';
import '../../../../core/services/theme_service.dart';
import '../../domain/auth_repo.dart';
import '../widgets/auth_view_body.dart';
import '/core/utils/helper.dart';
import '/core/utils/service_locator.dart';
import 'manager/auth_view_cubit.dart';

class AuthView extends StatefulWidget {
  const AuthView({Key? key}) : super(key: key);

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> with TickerProviderStateMixin {
  final GlobalKey<FormState> formKey = GlobalKey();
  AuthMode authMode = AuthMode.signIn;

  //============ TextFormFields Controllers ============
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode usernameFocusNode = FocusNode();
  final FocusNode confirmPassFocusNode = FocusNode();
  final FocusNode phoneFocusNode = FocusNode();

  // Animations
  late AnimationController _slidecontroller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    initSlidingAnimation();

    // setSystemUIOverlayStyle(
    //   systemNavigationBarColor: Get.isDarkMode
    //       ? AppColors.darkGreyClr
    //       : AppColors.scaffoldBackgroundClr,
    //   statusBarBrightness: Get.isDarkMode ? Brightness.light : Brightness.dark,
    //   statusBarColor: Get.isDarkMode
    //       ? AppColors.darkGreyClr
    //       : AppColors.scaffoldBackgroundClr,
    // );

    super.initState();
  }

  @override
  void dispose() {
    // Destroying The Controllers
    disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          AuthViewCubit(serviceLocator.get<AuthRepo>()),
      child: GestureDetector(
        // For Closing The Keyboard When The View Is Tapped
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: context.theme.colorScheme.background,
          appBar: buildAppBar(context),
          body: AuthViewBody(
            slideAnimation: _slideAnimation,
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
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: context.theme.colorScheme.background,
      leading: IconButton(
        onPressed: () {
          BlocProvider.of<ThemeService>(context).toggleTheme();
        },
        icon: Icon(
          Get.isDarkMode
              ? Icons.wb_sunny_outlined
              : Icons.nightlight_round_outlined,
          size: 28,
          color: Get.isDarkMode ? Colors.white : AppColors.darkGreyClr,
        ),
      ),
      systemOverlayStyle: Helper.setSystemOverlayStyle(),
    );
  }

  void initSlidingAnimation() {
    _slidecontroller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -0.15),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(parent: _slidecontroller, curve: Curves.fastOutSlowIn),
    );
  }

  //=========== For Switching Between Auth Modes ===========
  void switchAuthMode() {
    if (authMode == AuthMode.signIn) {
      setState(() {
        authMode = AuthMode.signUp;
      });

      _slidecontroller.forward();
    } else {
      setState(() {
        authMode = AuthMode.signIn;
      });
      _slidecontroller.reverse();
    }
  }

  void disposeControllers() {
    _slidecontroller.dispose();
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    confirmPassController.dispose();
    phoneController.dispose();
  }
}
