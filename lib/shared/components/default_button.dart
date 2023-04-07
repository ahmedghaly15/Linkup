import 'package:flutter/material.dart';
import 'package:social_app/styles/colors.dart';

class DefaultButton extends StatelessWidget {
  final String buttonText;

  final double height;
  final double width;
  final void Function()? onPressed;
  final TextStyle? textStyle;

  const DefaultButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    this.height = 15,
    this.width = 130,
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
            horizontal: width,
            vertical: height,
          ),
        ),
        backgroundColor: MaterialStateProperty.all(defaultColor),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        textStyle: MaterialStateProperty.all(textStyle),
      ),
      child: Text(buttonText),
    );
  }
}
