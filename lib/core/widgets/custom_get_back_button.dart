import 'package:flutter/material.dart';
import 'package:social_app/core/utils/app_assets.dart';
import 'package:social_app/core/utils/app_navigator.dart';
import 'package:social_app/core/widgets/custom_circle_icon_button.dart';

class CustomGetBackButton extends StatelessWidget {
  const CustomGetBackButton({
    super.key,
    this.onPressed,
    this.hasShadow = false,
  });

  final VoidCallback? onPressed;
  final bool hasShadow;

  @override
  Widget build(BuildContext context) {
    return CustomCircleIconButton(
      hasShadow: hasShadow,
      onPressed: onPressed ?? () => context.back(),
      icon: Image.asset(AppAssets.iconsArrowLeft),
    );
  }
}
