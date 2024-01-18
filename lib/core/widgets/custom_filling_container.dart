import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/core/utils/app_assets.dart';

class CustomFillingContainer extends StatelessWidget {
  const CustomFillingContainer({
    super.key,
    required this.child,
    this.height = double.infinity,
    this.width = double.infinity,
  });

  final Widget child;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: Helper.backgroundImageDecoration(),
      child: Container(
        margin: EdgeInsets.only(top: 50.h),
        padding: EdgeInsets.only(
          left: 10.w,
          right: 10.w,
          bottom: 25.h,
          top: 10.h,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50.0.r),
            topRight: Radius.circular(50.0.r),
          ),
          image: const DecorationImage(
            image: AssetImage(
              AppAssets.imagesContentBackgroundImage,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: child,
      ),
    );
  }
}
