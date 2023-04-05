import 'package:flutter/material.dart';
import 'package:social_app/styles/colors.dart';

class DefaultButton extends StatelessWidget {
  final String buttonText;

  final double screenWidth;
  final double screenHeight;
  final double height;
  final double width;
  final double buttonRaduis;
  final void Function()? onPressed;
  final TextStyle? textStyle;

  const DefaultButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    required this.screenHeight,
    required this.screenWidth,
    required this.height,
    required this.width,
    required this.buttonRaduis,
    this.textStyle = const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.5,
    ),
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
          EdgeInsets.symmetric(
            horizontal: screenWidth * width,
            vertical: screenHeight * height,
          ),
        ),
        backgroundColor: MaterialStateProperty.all(defaultColor),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(screenWidth * buttonRaduis),
          ),
        ),
        textStyle: MaterialStateProperty.all(textStyle),
      ),
      child: Text(buttonText),
    );
  }
}
