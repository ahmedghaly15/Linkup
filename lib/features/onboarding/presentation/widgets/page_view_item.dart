import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:social_app/config/themes/app_colors.dart';
import 'package:social_app/config/themes/app_text_styles.dart';
import 'package:social_app/features/onboarding/domain/entities/onboarding_entity.dart';
import 'package:social_app/features/onboarding/presentation/cubit/onboarding_cubit.dart';

class PageViewItem extends StatelessWidget {
  const PageViewItem({
    super.key,
    required this.pageInfo,
    required this.pageController,
  });

  final OnboardingEntity pageInfo;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Stack(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(40.r),
          ),
          child: Image.asset(
            pageInfo.image,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        ),
        Positioned(
          right: 0,
          left: 0,
          top: 50.h,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  pageInfo.heading,
                  style: AppTextStyles.textStyle28Bold.copyWith(
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  pageInfo.subHeading,
                  style: AppTextStyles.textStyle18.copyWith(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: 0,
          left: 0,
          bottom: 30.h,
          child: Padding(
            padding: EdgeInsets.only(left: 16.w),
            child: SmoothPageIndicator(
              controller: pageController,
              count: BlocProvider.of<OnboardingCubit>(context)
                  .getOnboardingPages()
                  .length,
              effect: ColorTransitionEffect(
                dotColor: Colors.grey,
                activeDotColor: AppColors.primaryColor,
                dotHeight: size.height * 0.008,
                dotWidth: size.width * 0.02,
                spacing: size.width * 0.015,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
