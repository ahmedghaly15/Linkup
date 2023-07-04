import 'package:flutter/material.dart';

import '/core/widgets/custom_button.dart';
import '/core/utils/size_config.dart';

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
    return CustomButton(
      buttonText: buttonText,
      onPressed: onPressed,
      width: SizeConfig.screenWidth! * 0.5,
      height: SizeConfig.screenHeight! * 0.048,
      textStyle: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }
}
