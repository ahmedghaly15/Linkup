import 'package:flutter/material.dart';
import 'package:social_app/config/themes/app_colors.dart';
import 'package:social_app/core/widgets/main_button.dart';

class TryAgainButton extends StatelessWidget {
  const TryAgainButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MainButton(
        backgroundColor: AppColors.primaryColor,
        onPressed: onPressed,
        text: 'Try again',
      ),
    );
  }
}
