import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/social_layout.dart';
import 'package:social_app/network/local/cache_helper.dart';
import 'package:social_app/shared/constants.dart';

// import '/layout/shop_layout.dart';
import '/modules/auth/cubit/cubit.dart';
import '/modules/auth/cubit/states.dart';
// import '/network/local/cache_helper.dart';
import '/shared/components/default_button.dart';
import '/shared/components/input_field.dart';
import '/styles/colors.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  // A Key For The Form
  final GlobalKey<FormState> formKey = GlobalKey();

  // Initializing The Auth Mode
  AuthMode authMode = AuthMode.signIn;

  //============ TextFormFields Controllers ============
  // Email TextFormField Controller
  final TextEditingController emailController = TextEditingController();
  // Password TextFormField Controller
  final TextEditingController passwordController = TextEditingController();
  // Username TextFormField Controller
  final TextEditingController nameController = TextEditingController();
  // User Phone Controller
  final TextEditingController phoneController = TextEditingController();
  // Confrim Password TextFormField Controller
  final TextEditingController confirmPassController = TextEditingController();

  // For Controlling Password Visibility
  bool passVisiblity = true;
  // For Controlling Confirmation Password Visibility
  bool confirmPassVisiblity = true;

  // Animations
  AnimationController? _controller;
  Animation<Offset>? _slideAnimation;

  @override
  void initState() {
    //============ Controlling Animations ============
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -0.15),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(parent: _controller!, curve: Curves.fastOutSlowIn),
    );

    super.initState();
  }

  @override
  void dispose() {
    // Destroying The Controller
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AuthScreenCubit(),
      child: BlocConsumer<AuthScreenCubit, AuthScreenStates>(
        listener: (context, state) {
          if (state is SignInErrorState) {
            buildSnackBar(
              message: state.error,
              state: SnackBarStates.error,
              context: context,
            );
          }

          if (state is SignUpErrorState) {
            buildSnackBar(
              message: state.error,
              state: SnackBarStates.error,
              context: context,
            );
          }

          if (state is SignInSuccessState) {
            CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
              navigateAndFinish(context, screen: const SocialAppLayout());
            });
          }

          if (state is SignUpSuccessState) {
            CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
              navigateAndFinish(context, screen: const SocialAppLayout());
            });
          }

          if (state is CreateUserSuccessState) {
            navigateAndFinish(context, screen: const SocialAppLayout());
          }
          // if (state is SignInSuccessState) {
          // if (state.signInModel.status!) {
          //======= In Case User Sign In Successfully =======
          //   CacheHelper.saveData(
          //           key: 'token', value: state.signInModel.data!.token)
          //       .then((value) {
          //     token = state.signInModel.data!.token;
          //     navigateAndFinish(context, screen: const ShopLayout());
          //   });
          //   buildSnackBar(
          //     context: context,
          //     message: state.signInModel.message!,
          //     state: SnackBarStates.success,
          //   );
          // }
          //======= In Case There's A Problem Signing The User In =======
          // else {
          //   buildSnackBar(
          //     context: context,
          //     message: state.signInModel.message!,
          //     state: SnackBarStates.error,
          //   );
          // }
          // }
          // if (state is SignUpSuccessState) {
          //======= In Case User Sign Up Successfully =======
          // if (state.signInModel.status!) {
          //   CacheHelper.saveData(
          //           key: 'token', value: state.signInModel.data!.token)
          //       .then((value) {
          //     token = state.signInModel.data!.token;
          //     navigateAndFinish(context, screen: const ShopLayout());
          //   });
          //   buildSnackBar(
          //     context: context,
          //     message: state.signInModel.message!,
          //     state: SnackBarStates.success,
          //   );
          // }
          //======= In Case There's A Problem Signing The User Up =======
          // else {
          //   buildSnackBar(
          //     context: context,
          //     message: state.signInModel.message!,
          //     state: SnackBarStates.error,
          //   );
          // }
          // }
        },
        builder: (context, state) {
          return LayoutBuilder(
            builder: (BuildContext context, _) {
              // For Getting The Screen Width
              double screenWidth = MediaQuery.of(context).size.width;
              // For Getting The Screen Height
              double screenHeight = MediaQuery.of(context).size.height;
              return GestureDetector(
                // For Closing The Keyboard When The Screen Is Tapped
                onTap: () => FocusScope.of(context).unfocus(),
                child: Scaffold(
                  appBar: AppBar(),
                  body: Center(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.05,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              authMode == AuthMode.signIn
                                  ? "SIGN IN"
                                  : "SIGN UP",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineLarge!
                                  .copyWith(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: defaultColor,
                                  ),
                            ),
                            // For Adding Some Space
                            SizedBox(height: screenHeight * 0.01),
                            Text(
                              authMode == AuthMode.signIn
                                  ? "Sign in now to communicate with friends"
                                  : "Let's make a new account",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                    fontSize: 18,
                                    color: Colors.black54,
                                  ),
                            ),
                            //======== For Adding Some Space ========
                            SizedBox(height: screenHeight * 0.03),
                            //======================= Auth Form =======================
                            Form(
                              key: formKey,
                              child: Column(
                                children: <Widget>[
                                  //======== Email Input Field ========
                                  InputField(
                                    key: const ValueKey("email"),
                                    hint: "Email",
                                    controller: emailController,
                                    obsecure: false,
                                    keyboardType: TextInputType.emailAddress,
                                    textCapitalization: TextCapitalization.none,
                                    validating: (val) {
                                      if (val!.isEmpty || !val.contains('@')) {
                                        return "Enter an email";
                                      }
                                      return null;
                                    },
                                  ),
                                  //======== User Name Input Field ========
                                  if (authMode == AuthMode.signUp)
                                    //======= For Adding Some Space =======
                                    SizedBox(height: screenHeight * 0.02),
                                  if (authMode == AuthMode.signUp)
                                    AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 400),
                                      curve: Curves.easeIn,
                                      child: SlideTransition(
                                        position: _slideAnimation!,
                                        child: InputField(
                                          key: const ValueKey("name"),
                                          hint: "User name",
                                          controller: nameController,
                                          obsecure: false,
                                          keyboardType: TextInputType.name,
                                          textCapitalization:
                                              TextCapitalization.words,
                                          validating: (val) {
                                            if (val!.isEmpty) {
                                              return "Enter a user name";
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ),
                                  //======== For Adding Some Space ==========
                                  SizedBox(height: screenHeight * 0.02),
                                  //======== Password Input Field =========
                                  InputField(
                                    key: const ValueKey("password"),
                                    hint: "Password",
                                    controller: passwordController,
                                    obsecure: passVisiblity,
                                    keyboardType: TextInputType.visiblePassword,
                                    textCapitalization: TextCapitalization.none,
                                    icon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          passVisiblity = !passVisiblity;
                                        });
                                      },
                                      icon: Icon(passVisiblity
                                          ? Icons.visibility_rounded
                                          : Icons.visibility_off_rounded),
                                    ),
                                    validating: (val) {
                                      if (val!.isEmpty) {
                                        return "Enter a password";
                                      } else if (val.length < 6) {
                                        return "Too short pasword";
                                      }
                                      return null;
                                    },
                                    onSubmit: (String value) {
                                      if (formKey.currentState!.validate()) {
                                        FocusScope.of(context).unfocus();
                                        AuthScreenCubit.getObject(context)
                                            .userSignIn(
                                          // context: context,
                                          email: emailController.text,
                                          password: passwordController.text,
                                        );
                                      }
                                    },
                                  ),
                                  //======== For Adding Some Space =========
                                  SizedBox(height: screenHeight * 0.02),
                                  //======== Confirm Password Input Field ========
                                  if (authMode == AuthMode.signUp)
                                    AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 400),
                                      curve: Curves.easeIn,
                                      child: SlideTransition(
                                        position: _slideAnimation!,
                                        child: InputField(
                                          key: const ValueKey(
                                              "confirm_password"),
                                          hint: "Confirm Password",
                                          controller: confirmPassController,
                                          obsecure: confirmPassVisiblity,
                                          keyboardType:
                                              TextInputType.visiblePassword,
                                          textCapitalization:
                                              TextCapitalization.none,
                                          icon: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                confirmPassVisiblity =
                                                    !confirmPassVisiblity;
                                              });
                                            },
                                            icon: Icon(confirmPassVisiblity
                                                ? Icons.visibility_rounded
                                                : Icons.visibility_off_rounded),
                                          ),
                                          validating: (val) {
                                            if (val! !=
                                                    passwordController.text ||
                                                val.isEmpty) {
                                              return "Password doesn't match";
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ),
                                  //======== Phone Input Field ========
                                  if (authMode == AuthMode.signUp)
                                    //======= For Adding Some Space =======
                                    SizedBox(height: screenHeight * 0.02),
                                  if (authMode == AuthMode.signUp)
                                    AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 400),
                                      curve: Curves.easeIn,
                                      child: SlideTransition(
                                        position: _slideAnimation!,
                                        child: InputField(
                                          key: const ValueKey("phone"),
                                          hint: "Phone number",
                                          controller: phoneController,
                                          obsecure: false,
                                          keyboardType: TextInputType.phone,
                                          textCapitalization:
                                              TextCapitalization.none,
                                          validating: (val) {
                                            if (val!.isEmpty) {
                                              return "Enter a phone number";
                                            }
                                            return null;
                                          },
                                          onSubmit: (String value) {
                                            if (formKey.currentState!
                                                .validate()) {
                                              FocusScope.of(context).unfocus();
                                              AuthScreenCubit.getObject(context)
                                                  .userSignUp(
                                                // context: context,
                                                username: nameController.text,
                                                email: emailController.text,
                                                password:
                                                    passwordController.text,
                                                phone: phoneController.text,
                                              );
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  //======= For Adding Some Space =======
                                  SizedBox(height: screenHeight * 0.02),
                                  //=========== Sign In & Up Button ===========
                                  Align(
                                    alignment: Alignment.center,
                                    child: ConditionalBuilder(
                                      condition: state is! SignInLoadingState &&
                                          state is! SignUpLoadingState,
                                      builder: (context) => DefaultButton(
                                        buttonText: authMode == AuthMode.signIn
                                            ? "Sign In"
                                            : "Sign Up",
                                        onPressed: () =>
                                            signInOrSignUp(context),
                                      ),
                                      fallback: (context) => const Center(
                                        child: CircularProgressIndicator(
                                          color: defaultColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  //========= For Adding Some Space =========
                                  SizedBox(height: screenHeight * 0.02),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        authMode == AuthMode.signIn
                                            ? "Don't have an account?"
                                            : "Already have an account?",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge,
                                      ),
                                      defaultTextButton(
                                        onPressed: switchAuthMode,
                                        title: authMode == AuthMode.signIn
                                            ? "Sign Up"
                                            : "Sign In",
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  //=========== For Switching Between Auth Modes ===========
  void switchAuthMode() {
    if (authMode == AuthMode.signIn) {
      setState(() {
        authMode = AuthMode.signUp;
      });

      _controller!.forward();
    } else {
      setState(() {
        authMode = AuthMode.signIn;
      });
      _controller!.reverse();
    }
  }

  //=========== For Signing The User In or Up ===========
  void signInOrSignUp(BuildContext ctx) {
    if (formKey.currentState!.validate()) {
      //======== Signing The User In ========
      if (authMode == AuthMode.signIn) {
        FocusScope.of(ctx).unfocus();
        AuthScreenCubit.getObject(ctx).userSignIn(
          // context: ctx,
          email: emailController.text.trim(),
          password: passwordController.text,
        );
      }
      //======== Signing The User Up ========
      else if (authMode == AuthMode.signUp) {
        FocusScope.of(ctx).unfocus();
        AuthScreenCubit.getObject(ctx).userSignUp(
          // context: ctx,
          username: nameController.text.trim(),
          email: emailController.text.trim(),
          password: passwordController.text,
          phone: phoneController.text,
        );
      }
    }
  }
}
