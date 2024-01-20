import 'package:flutter/material.dart';
import 'package:social_app/config/themes/app_text_styles.dart';
import 'package:social_app/core/widgets/main_button.dart';

class ConfirmEditingButton extends StatelessWidget {
  const ConfirmEditingButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
  });

  final String buttonText;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return MainButton(
      width: screenWidth * 0.5,
      height: 40,
      text: buttonText,
      textStyle: AppTextStyles.textStyle13.copyWith(
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
      onPressed: onPressed,
      borderRadius: 32,
    );
  }
}
