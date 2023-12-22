import 'package:flutter/material.dart';
import 'package:social_app/core/utils/app_text_styles.dart';

class AuthViewSubTitle extends StatelessWidget {
  const AuthViewSubTitle({
    super.key,
    required this.subTitle,
  });

  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Text(
      subTitle,
      style: AppTextStyles.textStyle18,
    );
  }
}
