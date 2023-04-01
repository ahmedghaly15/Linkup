import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final String buttonText;

  final double screenWidth;
  final double screenHeight;
  final double height;
  final double width;
  final double buttonRaduis;
  final void Function()? onPressed;

  const DefaultButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    required this.screenHeight,
    required this.screenWidth,
    required this.height,
    required this.width,
    required this.buttonRaduis,
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
        backgroundColor:
            MaterialStateProperty.all(Theme.of(context).primaryColor),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(screenWidth * buttonRaduis),
          ),
        ),
        textStyle: MaterialStateProperty.all(
          const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      child: Text(buttonText),
    );
  }
}
