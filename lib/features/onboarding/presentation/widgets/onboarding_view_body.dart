import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/config/themes/app_text_styles.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/core/widgets/main_button.dart';
import 'package:social_app/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:social_app/features/onboarding/presentation/widgets/page_view_item.dart';

class OnboardingViewBody extends StatefulWidget {
  const OnboardingViewBody({super.key});

  @override
  State<OnboardingViewBody> createState() => _OnboardingViewBodyState();
}

class _OnboardingViewBodyState extends State<OnboardingViewBody> {
  late PageController pageController;

  @override
  void initState() {
    pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        final OnboardingCubit cubit = BlocProvider.of<OnboardingCubit>(context);

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
                  SafeArea(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 16.w,
                        right: 16.w,
                        top: 16.h,
                      ),
                      child: MainButton(
                        onPressed: () => cubit.navigateBetweenPages(
                          context: context,
                          pageController: pageController,
                        ),
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
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
