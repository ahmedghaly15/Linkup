import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/helpers/auth_helper.dart';
import 'package:social_app/core/utils/app_colors.dart';
import 'package:social_app/core/widgets/custom_text_form_field.dart';
import 'package:social_app/core/widgets/main_button.dart';
import 'package:social_app/features/auth/presentation/cubits/sign_in/sign_in_cubit.dart';
import 'package:social_app/features/auth/presentation/widgets/text_form_field_separator.dart';

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
      listener: (BuildContext context, SignInState state) {},
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
                keyboardType: TextInputType.visiblePassword,
                autofillHints: const <String>[AutofillHints.password],
                obscureText: cubit.signInPassVisibility,
                suffix: IconButton(
                  onPressed: () => cubit.switchPassVisibility(),
                  icon: Icon(
                    cubit.signInPassVisibility
                        ? Icons.visibility_rounded
                        : Icons.visibility_off_rounded,
                    color: AppColors.primaryColor,
                  ),
                ),
                validating: (String? val) =>
                    AuthHelper.validatingPasswordField(value: val),
              ),
              SizedBox(height: 40.h),
              MainButton(
                onPressed: () {},
                text: 'Login',
              ),
              SizedBox(height: 10.h),
            ],
          ),
        );
      },
    );
  }
}
