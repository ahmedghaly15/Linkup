import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/helpers/auth_helper.dart';
import 'package:social_app/core/utils/app_colors.dart';
import 'package:social_app/core/widgets/custom_text_form_field.dart';
import 'package:social_app/core/widgets/main_button.dart';
import 'package:social_app/features/auth/presentation/cubits/sign_up/sign_up_cubit.dart';
import 'package:social_app/features/auth/presentation/widgets/text_form_field_separator.dart';

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
      listener: (context, state) {},
      builder: (context, state) {
        final SignUpCubit cubit = BlocProvider.of<SignUpCubit>(context);
        return Form(
          key: _formKey,
          autovalidateMode: autoValidateMode,
          child: Column(
            children: <Widget>[
              CustomTextFormField(
                hintText: 'Email',
                controller: _emailController,
                focusNode: _emailFocusNode,
                prefixIcon: Icons.email,
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
                hintText: 'Username',
                controller: _usernameController,
                focusNode: _usernameFocusNode,
                prefixIcon: Icons.person_2,
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.words,
                validating: (String? val) =>
                    AuthHelper.validatingNameField(value: val),
                autofillHints: const <String>[AutofillHints.name],
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
                prefixIcon: Icons.lock,
                keyboardType: TextInputType.visiblePassword,
                autofillHints: const <String>[AutofillHints.password],
                obscureText: cubit.signUpPassVisibility,
                suffix: IconButton(
                  onPressed: () => cubit.switchSignUpPassVisibility(),
                  icon: Icon(
                    cubit.signUpPassVisibility
                        ? Icons.visibility_rounded
                        : Icons.visibility_off_rounded,
                    color: AppColors.primaryColor,
                  ),
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
                prefixIcon: Icons.lock,
                keyboardType: TextInputType.visiblePassword,
                autofillHints: const <String>[AutofillHints.password],
                obscureText: cubit.confirmPassVisibility,
                suffix: IconButton(
                  onPressed: () => cubit.switchConfirmPassVisibility(),
                  icon: Icon(
                    cubit.confirmPassVisibility
                        ? Icons.visibility_rounded
                        : Icons.visibility_off_rounded,
                    color: AppColors.primaryColor,
                  ),
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
                prefixIcon: Icons.phone,
                keyboardType: TextInputType.phone,
                autofillHints: const <String>[AutofillHints.telephoneNumber],
                validating: (String? val) =>
                    AuthHelper.validatePhoneField(value: val),
              ),
              SizedBox(height: 40.h),
              MainButton(
                onPressed: () {},
                text: 'Sign up',
              ),
            ],
          ),
        );
      },
    );
  }
}
