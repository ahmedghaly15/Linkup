import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/config/router/routes.dart';
import 'package:social_app/core/helpers/auth_helper.dart';
import 'package:social_app/core/helpers/cache_helper.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/core/utils/app_assets.dart';
import 'package:social_app/core/utils/app_navigator.dart';
import 'package:social_app/core/utils/app_strings.dart';
import 'package:social_app/core/widgets/custom_text_form_field.dart';
import 'package:social_app/core/widgets/custom_toast.dart';
import 'package:social_app/core/widgets/main_button.dart';
import 'package:social_app/features/auth/domain/entities/sign_in_params.dart';
import 'package:social_app/features/auth/presentation/cubits/sign_in/sign_in_cubit.dart';
import 'package:social_app/features/auth/presentation/widgets/custom_auth_loading.dart';
import 'package:social_app/features/auth/presentation/widgets/text_form_field_separator.dart';
import 'package:social_app/features/posts/presentation/cubits/posts_cubit.dart';
import 'package:social_app/features/users/presentation/cubits/user_cubit.dart';
import 'package:social_app/service_locator.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  late final GlobalKey<FormState> _formKey;
  late AutovalidateMode autoValidateMode;

  @override
  void initState() {
    _initFormAttributes();
    super.initState();
  }

  void _initFormAttributes() {
    _formKey = GlobalKey<FormState>();
    autoValidateMode = AutovalidateMode.disabled;
  }

  @override
  void dispose() {
    _disposeControllers();
    _disposeFocusNodes();
    super.dispose();
  }

  void _disposeFocusNodes() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
  }

  void _disposeControllers() {
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInCubit, SignInState>(
      listener: (context, state) => _controlSignInState(state, context),
      builder: (context, state) {
        final SignInCubit cubit = BlocProvider.of<SignInCubit>(context);
        return Form(
          key: _formKey,
          autovalidateMode: autoValidateMode,
          child: Column(
            children: <Widget>[
              CustomTextFormField(
                hintText: 'Email',
                controller: _emailController,
                focusNode: _emailFocusNode,
                prefixIcon: Image.asset(AppAssets.iconsEmail),
                autofillHints: const <String>[AutofillHints.email],
                keyboardType: TextInputType.emailAddress,
                validating: (String? val) =>
                    AuthHelper.validatingEmailField(value: val),
                onEditingComplete: () => AuthHelper.requestFocus(
                  context,
                  _passwordFocusNode,
                ),
              ),
              const TextFormFieldSeparator(),
              CustomTextFormField(
                hintText: 'Password',
                controller: _passwordController,
                focusNode: _passwordFocusNode,
                prefixIcon: Image.asset(AppAssets.iconsLock),
                keyboardType: TextInputType.visiblePassword,
                autofillHints: const <String>[AutofillHints.password],
                obscureText: cubit.signInPassVisibility,
                suffixIcon: IconButton(
                  onPressed: () => cubit.switchPassVisibility(),
                  icon: cubit.signInPassVisibility
                      ? Image.asset(AppAssets.iconsVisible)
                      : Image.asset(AppAssets.iconsInvisible),
                ),
                validating: (String? val) =>
                    AuthHelper.validatingPasswordField(value: val),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () =>
                      context.navigateTo(routeName: Routes.forgotPasswordRoute),
                  child: const Text('Forgot Password?'),
                ),
              ),
              SizedBox(height: 10.h),
              MainButton(
                onPressed: () => _signIn(context),
                text: 'Login',
              ),
            ],
          ),
        );
      },
    );
  }

  void _signIn(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      AuthHelper.keyboardUnfocus(context);
      BlocProvider.of<SignInCubit>(context).signIn(
        params: SignInParams(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        ),
      );
    } else {
      setState(() {
        autoValidateMode = AutovalidateMode.always;
      });
    }
  }

  void _controlSignInState(SignInState state, BuildContext context) {
    if (state is SignInLoading) {
      CustomAuthLoading.show(context);
    }

    if (state is SignInSuccess) {
      _handleSignInSuccess(context, state);
    }

    if (state is SignInError) {
      _handleSignInError(context, state);
    }
  }

  void _handleSignInError(BuildContext context, SignInError state) {
    context.back();
    CustomToast.showToast(
      text: state.error,
      state: CustomToastState.error,
    );
  }

  void _handleSignInSuccess(BuildContext context, SignInSuccess state) {
    context.back();
    getIt
        .get<CacheHelper>()
        .saveData(
          key: AppStrings.cachedUserId,
          value: state.uId,
        )
        .then((value) {
      if (value) {
        Helper.uId = state.uId;
        BlocProvider.of<UserCubit>(context).getUserData().then((value) {
          BlocProvider.of<PostsCubit>(context).getPosts();
          context.navigateAndReplace(newRoute: Routes.linkupRoute);
        });
      }
    });
  }
}
