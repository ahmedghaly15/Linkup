import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final double radius;
  final double height;
  final double width;
  final void Function()? onPressed;
  final TextStyle? textStyle;

  const CustomButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    this.radius = 32.0,
    this.textStyle = AppTextStyles.customButtonTextStyle,
    this.height = 60,
    this.width = double.maxFinite,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(AppColors.primaryColor),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
            ),
          ),
        ),
        child: Text(
          buttonText,
          style: textStyle,
        ),
      ),
    );
  }
}
