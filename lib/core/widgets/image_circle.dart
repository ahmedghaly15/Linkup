import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/config/themes/cubit/themes_cubit.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/core/utils/app_colors.dart';

class ImageCircle extends StatelessWidget {
  const ImageCircle({
    super.key,
    required this.onPressed,
    required this.icon,
  });

  final String icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemesCubit, ThemeData>(
      builder: (context, state) {
        return ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            elevation: 16.h,
            backgroundColor: Helper.isDark(state)
                ? AppColors.darkGreyClr
                : AppColors.scaffoldBackgroundClr,
            shape: const CircleBorder(),
            fixedSize: Size(150.w, 130.h),
          ),
          child: Image.asset(
            icon,
            width: 180.w,
            height: 100.h,
          ),
        );
      },
    );
  }
}
