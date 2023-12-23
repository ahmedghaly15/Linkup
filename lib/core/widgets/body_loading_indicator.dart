import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:social_app/core/utils/app_colors.dart';

class BodyLoadingIndicator extends StatelessWidget {
  const BodyLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 40.h,
        width: 40.h,
        child: LoadingIndicator(
          indicatorType: Indicator.lineSpinFadeLoader,
          colors: AppColors.loadingColors,
          strokeWidth: 5.w,
        ),
      ),
    );
  }
}
