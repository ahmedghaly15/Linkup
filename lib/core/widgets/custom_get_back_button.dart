import 'package:flutter/material.dart';
import 'package:social_app/core/utils/app_assets.dart';
import 'package:social_app/core/utils/app_navigator.dart';
import 'package:social_app/core/widgets/custom_circle_icon_button.dart';

class CustomGetBackButton extends StatelessWidget {
  const CustomGetBackButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return CustomCircleIconButton(
      onPressed: onPressed ?? () => context.back(),
      icon: Image.asset(AppAssets.iconsArrowLeft),
    );
  }
}
