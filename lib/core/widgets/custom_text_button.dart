import 'package:flutter/material.dart';

import '../global/app_styles.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.textStyle = AppStyles.customTextButtonTextStyle,
  });

  final void Function()? onPressed;
  final String title;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(title, style: textStyle),
    );
  }
}
