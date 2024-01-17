import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:social_app/config/themes/app_colors.dart';
import 'package:social_app/config/themes/app_text_styles.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/core/widgets/main_button.dart';
import 'package:social_app/features/onboarding/domain/entities/onboarding_entity.dart';
import 'package:social_app/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:social_app/service_locator.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  PageController pageController = PageController(initialPage: 0);

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<OnboardingCubit>(),
      child: Scaffold(
        body: BlocBuilder<OnboardingCubit, OnboardingState>(
          builder: (context, state) {
            final OnboardingCubit cubit =
                BlocProvider.of<OnboardingCubit>(context);

            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.85,
                    child: PageView.builder(
                      controller: pageController,
                      itemCount: cubit.getOnboardingPages().length,
                      itemBuilder: (context, index) => PageViewItem(
                        pageInfo: cubit.getOnboardingPages()[index],
                        pageController: pageController,
                      ),
                      onPageChanged: (int index) {
                        cubit.onChangePageIndex(index);
                      },
                    ),
                  ),
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    children: <Widget>[
                      const Spacer(),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 16.h,
                        ),
                        child: MainButton(
                          onPressed: () {
                            cubit.isLastBoarding
                                ? cubit.skipToSignIn(context: context)
                                : cubit.navigateBetweenPages(
                                    context: context,
                                    pageController: pageController,
                                  );
                          },
                          boxShadow: <BoxShadow>[Helper.buttonShadow()],
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                cubit.isLastBoarding ? 'Get Started' : 'Next',
                                style: AppTextStyles.textStyle20Bold.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                              Icon(
                                Icons.arrow_right_alt_outlined,
                                color: Colors.white,
                                size: 32.w,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

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
