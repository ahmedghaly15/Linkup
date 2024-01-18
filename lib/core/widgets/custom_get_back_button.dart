import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/utils/app_assets.dart';
import 'package:social_app/core/utils/app_navigator.dart';

class CustomGetBackButton extends StatelessWidget {
  const CustomGetBackButton({
    super.key,
    this.onPressed,
  });

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44.h,
      width: 44.h,
      decoration: const BoxDecoration(
        color: Color(0xffE6EEFA),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: onPressed ?? () => context.back(),
        icon: Image.asset(
          AppAssets.iconsArrowLeft,
        ),
      ),
    );
  }
}
