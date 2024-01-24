import 'package:flutter/material.dart';
import 'package:social_app/config/themes/app_colors.dart';
import 'package:social_app/core/helpers/helper.dart';

class ShimmerHelper {
  static Color highlightColor(BuildContext context) {
    return Helper.isDark(context)
        ? AppColors.darkShimmerHighlightColor
        : AppColors.shimmerHighlightColor;
  }

  static Color baseColor(BuildContext context) {
    return Helper.isDark(context)
        ? AppColors.darkShimmerBaseColor
        : AppColors.shimmerBaseColor;
  }
}
