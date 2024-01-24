import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:social_app/config/themes/app_colors.dart';
import 'package:social_app/core/helpers/shimmer_helper.dart';

class ShimmerChatItem extends StatelessWidget {
  const ShimmerChatItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: ShimmerHelper.baseColor(context),
      highlightColor: ShimmerHelper.highlightColor(context),
      enabled: true,
      child: Container(
        height: 85.h,
        width: double.infinity,
        margin: EdgeInsets.symmetric(vertical: 4.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.r),
          color: AppColors.shimmerContainerColor,
        ),
      ),
    );
  }
}
