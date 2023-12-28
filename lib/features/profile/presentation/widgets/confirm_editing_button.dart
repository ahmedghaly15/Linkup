import 'package:flutter/material.dart';
import 'package:social_app/core/utils/app_text_styles.dart';
import 'package:social_app/core/widgets/main_button.dart';

class ConfirmEditingButton extends StatelessWidget {
  const ConfirmEditingButton({
    Key? key,
    required this.buttonText,
    required this.onPressed,
  }) : super(key: key);

  final String buttonText;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return MainButton(
      width: screenWidth * 0.5,
      height: 40,
      text: buttonText,
      textStyle: AppTextStyles.textStyle16SemiBold.copyWith(
        color: Colors.white,
      ),
      onPressed: onPressed,
      borderRadius: 32,
    );
  }
}
