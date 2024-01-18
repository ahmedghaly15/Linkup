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
import 'package:social_app/features/auth/domain/entities/sign_up_params.dart';
import 'package:social_app/features/auth/presentation/cubits/sign_up/sign_up_cubit.dart';
import 'package:social_app/features/auth/presentation/widgets/custom_auth_loading.dart';
import 'package:social_app/features/auth/presentation/widgets/text_form_field_separator.dart';
import 'package:social_app/features/posts/presentation/cubits/posts_cubit.dart';
import 'package:social_app/features/users/presentation/cubits/user_cubit.dart';
import 'package:social_app/service_locator.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _usernameFocusNode = FocusNode();
  final FocusNode _confirmPassFocusNode = FocusNode();
  final FocusNode _phoneFocusNode = FocusNode();

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
    _usernameFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPassFocusNode.dispose();
    _phoneFocusNode.dispose();
  }

  void _disposeControllers() {
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPassController.dispose();
    _phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCubit, SignUpState>(
      listener: (context, state) => _controlSignUpState(state, context),
      builder: (context, state) {
        final SignUpCubit cubit = BlocProvider.of<SignUpCubit>(context);
        return Form(
          key: _formKey,
          autovalidateMode: autoValidateMode,
          child: Column(
            children: <Widget>[
              CustomTextFormField(
                hintText: 'Username',
                controller: _usernameController,
                focusNode: _usernameFocusNode,
                prefixIcon: Image.asset(AppAssets.iconsPerson),
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.words,
                validating: (String? val) => AuthHelper.validatingField(
                  value: val,
                  fieldName: 'Username',
                ),
                autofillHints: const <String>[AutofillHints.name],
                onEditingComplete: () => AuthHelper.requestFocus(
                  context,
                  _passwordFocusNode,
                ),
              ),
              const TextFormFieldSeparator(),
              CustomTextFormField(
                hintText: 'Email',
                controller: _emailController,
                focusNode: _emailFocusNode,
                prefixIcon: Image.asset(AppAssets.iconsEmail),
                keyboardType: TextInputType.emailAddress,
                autofillHints: const <String>[AutofillHints.email],
                validating: (String? val) =>
                    AuthHelper.validatingEmailField(value: val),
                onEditingComplete: () => AuthHelper.requestFocus(
                  context,
                  _usernameFocusNode,
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
                obscureText: cubit.signUpPassVisibility,
                suffixIcon: IconButton(
                  onPressed: () => cubit.switchSignUpPassVisibility(),
                  icon: cubit.signUpPassVisibility
                      ? Image.asset(AppAssets.iconsVisible)
                      : Image.asset(AppAssets.iconsInvisible),
                ),
                validating: (String? val) =>
                    AuthHelper.validatingPasswordField(value: val),
                onEditingComplete: () => AuthHelper.requestFocus(
                  context,
                  _confirmPassFocusNode,
                ),
              ),
              const TextFormFieldSeparator(),
              CustomTextFormField(
                hintText: 'Confirm Password',
                controller: _confirmPassController,
                focusNode: _confirmPassFocusNode,
                prefixIcon: Image.asset(AppAssets.iconsLock),
                keyboardType: TextInputType.visiblePassword,
                autofillHints: const <String>[AutofillHints.password],
                obscureText: cubit.confirmPassVisibility,
                suffixIcon: IconButton(
                  onPressed: () => cubit.switchConfirmPassVisibility(),
                  icon: cubit.confirmPassVisibility
                      ? Image.asset(AppAssets.iconsVisible)
                      : Image.asset(AppAssets.iconsInvisible),
                ),
                validating: (String? val) =>
                    AuthHelper.validateConfirmPassField(
                  value: val,
                  password: _passwordController.text,
                ),
                onEditingComplete: () => AuthHelper.requestFocus(
                  context,
                  _phoneFocusNode,
                ),
              ),
              const TextFormFieldSeparator(),
              CustomTextFormField(
                hintText: 'Phone Number',
                controller: _phoneController,
                focusNode: _phoneFocusNode,
                prefixIcon: Image.asset(AppAssets.iconsPhone),
                keyboardType: TextInputType.phone,
                autofillHints: const <String>[AutofillHints.telephoneNumber],
                validating: (String? val) =>
                    AuthHelper.validatePhoneField(value: val),
              ),
              SizedBox(height: 40.h),
              MainButton(
                onPressed: () => _signUp(context),
                text: 'Sign up',
              ),
            ],
          ),
        );
      },
    );
  }

  void _signUp(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      AuthHelper.keyboardUnfocus(context);

      BlocProvider.of<SignUpCubit>(context).signUp(
        params: SignUpParams(
          username: _usernameController.text.trim(),
          email: _emailController.text.trim(),
          password: _passwordController.text,
          phone: _phoneController.text,
        ),
      );
    } else {
      setState(() {
        autoValidateMode = AutovalidateMode.always;
      });
    }
  }

  void _controlSignUpState(SignUpState state, BuildContext context) {
    if (state is SignUpLoading) {
      CustomAuthLoading.show(context);
    }

    if (state is SignUpSuccess) {
      _handleSignUpSuccess(context, state);
    }

    if (state is SignUpError) {
      _handleSignUpError(context, state);
    }
  }

  void _handleSignUpError(BuildContext context, SignUpError state) {
    context.back();
    CustomToast.showToast(
      text: state.error,
      state: CustomToastState.error,
    );
  }

  void _handleSignUpSuccess(BuildContext context, SignUpSuccess state) {
    context.back();

    getIt
        .get<CacheHelper>()
        .saveData(key: AppStrings.cachedUserId, value: state.uId)
        .then((value) {
      if (value) {
        Helper.uId = state.uId;
        BlocProvider.of<UserCubit>(context).getUserData().then((value) {
          BlocProvider.of<PostsCubit>(context).getPosts();
          CustomToast.showToast(
            text: 'Account created successfully',
            state: CustomToastState.success,
          );
          context.navigateAndReplace(newRoute: Routes.linkupRoute);
        });
      }
    });
  }
}
