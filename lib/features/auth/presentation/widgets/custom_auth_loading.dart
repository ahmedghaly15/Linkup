import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:social_app/config/themes/cubit/themes_cubit.dart';
import 'package:social_app/core/utils/app_colors.dart';

class CustomAuthLoading {
  static void show(BuildContext context) {
    showAdaptiveDialog(
      context: context,
      builder: (context) => const LoadingWidget(),
    );
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemesCubit, ThemeData>(builder: (context, state) {
      return Center(
        child: Container(
          height: 80.h,
          width: 80.h,
          padding: EdgeInsets.all(8.h),
          decoration: BoxDecoration(
            color: state.brightness == Brightness.light
                ? Colors.white
                : AppColors.darkGreyClr,
            borderRadius: BorderRadius.all(Radius.circular(16.r)),
          ),
          child: LoadingIndicator(
            indicatorType: Indicator.ballRotateChase,
            colors: AppColors.loadingColors,
            strokeWidth: 5.w,
          ),
        ),
      );
    });
  }
}
