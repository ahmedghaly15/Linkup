import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/config/themes/app_colors.dart';

class CustomCircleIconButton extends StatelessWidget {
  const CustomCircleIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.hasShadow = false,
    this.backgroundColor = AppColors.lightWhiteBlue,
  });

  final VoidCallback? onPressed;
  final Widget icon;
  final bool hasShadow;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44.h,
      width: 44.h,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
        boxShadow: hasShadow
            ? <BoxShadow>[
                BoxShadow(
                  offset: Offset(0, 6.h),
                  blurRadius: 12.r,
                  spreadRadius: 0,
                  color: Colors.black.withOpacity(0.25),
                ),
              ]
            : null,
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: icon,
      ),
    );
  }
}
