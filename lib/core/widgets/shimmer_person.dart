import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:social_app/config/themes/app_colors.dart';
import 'package:social_app/core/helpers/shimmer_helper.dart';

class ShimmerPerson extends StatelessWidget {
  const ShimmerPerson({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Shimmer.fromColors(
      baseColor: ShimmerHelper.baseColor(context),
      highlightColor: ShimmerHelper.highlightColor(context),
      enabled: true,
      child: Padding(
        padding: EdgeInsets.all(10.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 60.h,
              width: 60.h,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.shimmerContainerColor,
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 24.h,
                    width: screenWidth * 0.4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(24.r)),
                      color: AppColors.shimmerContainerColor,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Container(
                    height: 16.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(24.r)),
                      color: AppColors.shimmerContainerColor,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Container(
                    height: 16.h,
                    width: screenWidth * 0.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(24.r)),
                      color: AppColors.shimmerContainerColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
