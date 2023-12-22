import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/utils/app_colors.dart';
import 'package:social_app/core/utils/app_text_styles.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    Key? key,
    this.text,
    this.borderRadius,
    this.textStyle,
    this.backgroundColor,
    this.textColor,
    required this.onPressed,
    this.boxShadow,
    this.child,
  }) : super(key: key);

  final String? text;
  final double? borderRadius;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final Color? textColor;
  final void Function() onPressed;
  final List<BoxShadow>? boxShadow;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50.0.h,
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.primaryColor,
        borderRadius:
            BorderRadiusDirectional.circular((borderRadius?.r) ?? 16.0.r),
        boxShadow: boxShadow,
      ),
      child: MaterialButton(
        onPressed: onPressed,
        child: child ??
            Text(
              text!,
              style: textStyle ??
                  AppTextStyles.textStyle23Bold.copyWith(
                    color: textColor ?? Colors.white,
                  ),
            ),
      ),
    );
  }
}
