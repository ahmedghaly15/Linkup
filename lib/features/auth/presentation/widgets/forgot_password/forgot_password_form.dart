import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/helpers/auth_helper.dart';
import 'package:social_app/config/themes/app_text_styles.dart';
import 'package:social_app/core/utils/app_assets.dart';
import 'package:social_app/core/widgets/custom_text_form_field.dart';
import 'package:social_app/core/widgets/custom_toast.dart';
import 'package:social_app/core/widgets/main_button.dart';
import 'package:social_app/features/auth/presentation/cubits/forgot_password/forgot_password_cubit.dart';
import 'package:social_app/features/auth/presentation/widgets/text_form_field_separator.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({super.key});

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final TextEditingController _emailController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();

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
    _disposeEmailFieldAttributes();
    super.dispose();
  }

  void _disposeEmailFieldAttributes() {
    _emailController.dispose();
    _emailFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
      listener: (context, state) => _controlForgotPasswordState(state),
      builder: (context, state) {
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
              ),
              const TextFormFieldSeparator(),
              MainButton(
                onPressed: () => _resetPassword(context),
                child: state is ForgotPasswordLoading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : Text(
                        'Reset Password',
                        style: AppTextStyles.textStyle23Bold.copyWith(
                          color: Colors.white,
                        ),
                      ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _resetPassword(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      AuthHelper.keyboardUnfocus(context);
      BlocProvider.of<ForgotPasswordCubit>(context).forgotPassword(
        email: _emailController.text.trim(),
      );
    } else {
      setState(() {
        autoValidateMode = AutovalidateMode.always;
      });
    }
  }

  void _controlForgotPasswordState(ForgotPasswordState state) {
    if (state is ForgotPasswordSuccess) {
      CustomToast.showToast(
        text: 'Reset password mail is sent',
        state: CustomToastState.success,
      );
    }

    if (state is ForgotPasswordError) {
      CustomToast.showToast(
        text: state.error,
        state: CustomToastState.error,
      );
    }
  }
}
