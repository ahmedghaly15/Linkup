import 'package:flutter/material.dart';
import 'package:social_app/core/utils/app_colors.dart';
import 'package:social_app/core/utils/app_text_styles.dart';

class HaveAccountOrNotText extends StatelessWidget {
  const HaveAccountOrNotText({
    super.key,
    required this.question,
    required this.buttonText,
    this.onTap,
  });

  final String question;
  final String buttonText;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          question,
          style: AppTextStyles.textStyle16,
        ),
        TextButton(
          onPressed: onTap,
          child: Text(
            buttonText,
            style: AppTextStyles.textStyle16SemiBold.copyWith(
              color: AppColors.primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
