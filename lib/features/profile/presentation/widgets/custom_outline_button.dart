import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/config/themes/app_colors.dart';
import 'package:social_app/config/themes/app_text_styles.dart';
import 'package:social_app/core/helpers/helper.dart';

class CustomOutlineButton extends StatelessWidget {
  const CustomOutlineButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.borderColor,
  });

  final VoidCallback onPressed;
  final Color borderColor;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 50.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(
            16.0.r,
          ),
          color: Helper.isDark(context)
              ? AppColors.darkPrimaryColor
              : Colors.white,
          border: Border.all(
            color: borderColor,
            width: 1.w,
          ),
        ),
        child: MaterialButton(
          onPressed: onPressed,
          child: Text(
            text,
            style: AppTextStyles.textStyle18Bold,
          ),
        ),
      ),
    );
  }
}
