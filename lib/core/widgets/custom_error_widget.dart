import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/config/themes/app_colors.dart';
import 'package:social_app/core/utils/app_assets.dart';
import 'package:social_app/core/utils/app_strings.dart';
import 'package:social_app/config/themes/app_text_styles.dart';
import 'package:social_app/core/widgets/try_again_button.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({
    super.key,
    required this.onPressed,
    required this.error,
  });

  final VoidCallback onPressed;
  final String error;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Spacer(),
          error == AppStrings.noInternet
              ? Image.asset(
                  AppAssets.imagesNoInternet,
                  fit: BoxFit.fill,
                )
              : Icon(
                  Icons.refresh,
                  color: AppColors.primaryColor,
                  size: 150.h,
                ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 12.h),
            child: Text(
              error,
              style: AppTextStyles.textStyle18Bold,
              textAlign: TextAlign.center,
            ),
          ),
          if (error == AppStrings.noInternet)
            Text(
              'Connect to the internet and try again.',
              style: AppTextStyles.textStyle13,
              textAlign: TextAlign.center,
            ),
          const Spacer(),
          TryAgainButton(onPressed: onPressed),
          const Spacer(),
        ],
      ),
    );
  }
}
