import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:social_app/config/themes/app_colors.dart';
import 'package:social_app/core/helpers/shimmer_helper.dart';

class ShimmerPostItem extends StatelessWidget {
  const ShimmerPostItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: ShimmerHelper.baseColor(context),
      highlightColor: ShimmerHelper.highlightColor(context),
      enabled: true,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 12.h),
        height: 150.h,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(40.r)),
          color: AppColors.shimmerContainerColor,
        ),
      ),
    );
  }
}
