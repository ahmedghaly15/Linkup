import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/config/themes/app_colors.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/core/utils/app_constants.dart';

class CustomContentContainer extends StatelessWidget {
  const CustomContentContainer({
    super.key,
    required this.child,
    this.height,
    this.width = double.infinity,
    this.horizontalPadding = 16,
    this.bottomPadding = 8,
    this.borderRadius,
    this.backgroundColor = AppColors.lightWhiteBlue,
  });

  final Widget child;
  final double? height;
  final double width;
  final double horizontalPadding;
  final BorderRadiusGeometry? borderRadius;
  final double bottomPadding;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.only(
        left: horizontalPadding.w,
        right: horizontalPadding.w,
        bottom: bottomPadding.h,
        top: 20.h,
      ),
      decoration: BoxDecoration(
        color: Helper.isDark(context)
            ? AppColors.darkPrimaryColor
            : backgroundColor,
        borderRadius: borderRadius ??
            BorderRadius.all(
              Radius.circular(AppConstants.contentContainerRadius.r),
            ),
      ),
      child: child,
    );
  }
}
