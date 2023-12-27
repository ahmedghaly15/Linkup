import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/utils/app_colors.dart';

class CachedImageErrorIcon extends StatelessWidget {
  const CachedImageErrorIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.error,
      size: 22.h,
      color: AppColors.primaryColor,
    );
  }
}
