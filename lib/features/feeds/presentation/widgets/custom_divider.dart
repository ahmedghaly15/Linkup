import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 15.0,
        horizontal: 5,
      ),
      child: Container(
        width: double.infinity,
        height: 1.5,
        color: Colors.grey[300],
      ),
    );
  }
}
