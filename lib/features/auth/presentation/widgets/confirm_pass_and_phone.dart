import 'package:flutter/material.dart';

import '../../../../core/utils/size_config.dart';
import '../../../../core/widgets/input_field.dart';
import '../view/manager/auth_view_cubit.dart';

class ConfirmPassAndPhone extends StatelessWidget {
  const ConfirmPassAndPhone({
    super.key,
    required this.confirmPassController,
    required this.authMode,
    required this.cubit,
    required this.slideAnimation,
    required this.passwordController,
    required this.formKey,
    required this.signUpFormValidation,
    required this.confirmPassFocusNode,
    required this.phoneController,
    required this.phoneFocusNode,
  });

  final GlobalKey<FormState> formKey;
  final void Function(BuildContext context) signUpFormValidation;
  final TextEditingController passwordController;
  final TextEditingController confirmPassController;
  final TextEditingController phoneController;

  final AuthMode authMode;
  final AuthViewCubit cubit;
  final Animation<Offset> slideAnimation;
  final FocusNode confirmPassFocusNode;
  final FocusNode phoneFocusNode;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AnimatedContainer(
          duration: const Duration(seconds: 1),
          curve: Curves.easeIn,
          child: SlideTransition(
            position: slideAnimation,
            child: InputField(
              focusNode: confirmPassFocusNode,
              key: const ValueKey("confirm_password"),
              hint: "Confirm Password",
              controller: confirmPassController,
              obsecure: cubit.confirmPassVisiblity,
              keyboardType: TextInputType.visiblePassword,
              textCapitalization: TextCapitalization.none,
              icon: IconButton(
                onPressed: () {
                  cubit.switchConfirmPassVisibility();
                },
                icon: Icon(
                  cubit.confirmPassVisiblity
                      ? Icons.visibility_rounded
                      : Icons.visibility_off_rounded,
                ),
              ),
              validating: (val) {
                if (val! != passwordController.text || val.isEmpty) {
                  return "Password doesn't match";
                }
                return null;
              },
              onEditingComplete: () {
                FocusScope.of(context).requestFocus(phoneFocusNode);
              },
            ),
          ),
        ),
        SizedBox(height: SizeConfig.screenHeight! * 0.02),
        AnimatedContainer(
          duration: const Duration(seconds: 1),
          curve: Curves.easeIn,
          child: SlideTransition(
            position: slideAnimation,
            child: InputField(
              focusNode: phoneFocusNode,
              key: const ValueKey("phone"),
              hint: "Phone number",
              obsecure: false,
              controller: phoneController,
              keyboardType: TextInputType.phone,
              textCapitalization: TextCapitalization.none,
              validating: (val) {
                if (val!.isEmpty) {
                  return "Phone number can't be blank";
                }
                return null;
              },
              onSubmit: (String value) {
                if (formKey.currentState!.validate()) {
                  signUpFormValidation(context);
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
