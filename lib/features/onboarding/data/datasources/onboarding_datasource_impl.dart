import 'package:flutter/material.dart';
import 'package:social_app/config/router/routes.dart';
import 'package:social_app/core/helpers/cache_helper.dart';
import 'package:social_app/core/utils/app_assets.dart';
import 'package:social_app/core/utils/app_navigator.dart';
import 'package:social_app/core/utils/app_strings.dart';
import 'package:social_app/features/onboarding/data/datasources/onboarding_datasource.dart';
import 'package:social_app/features/onboarding/data/models/onboarding_model.dart';
import 'package:social_app/features/onboarding/domain/entities/navigate_between_pages_params.dart';
import 'package:social_app/features/onboarding/domain/entities/onboarding_entity.dart';
import 'package:social_app/service_locator.dart';

class OnboardingDataSourceImpl implements OnboardingDataSource {
  @override
  void navigateBetweenPages({required NavigateBetweenPagesParams params}) {
    if (params.isLastBoarding) skipToSignIn(context: params.context);

    params.pageController.nextPage(
      duration: const Duration(seconds: 1),
      curve: Curves.fastEaseInToSlowEaseOut,
    );
  }

  @override
  List<OnboardingEntity> onboardingPages() => const <OnboardingModel>[
        OnboardingModel(
          image: AppAssets.imagesOnboarding1,
          heading: 'Welcome to Linkup! Connect with Others',
          subHeading:
              "Welcome to a world of friendship and possibilities. Start sharing experiences",
        ),
        OnboardingModel(
          image: AppAssets.imagesOnboarding2,
          heading: 'Best Social App to Make New Friends',
          subHeading:
              "Expand your social circle and embark on a journey of connection.",
        ),
        OnboardingModel(
          image: AppAssets.imagesOnboarding3,
          heading: 'Enjoy Your Life Every Time, Every Where',
          subHeading:
              "Seize the moments and savor life's joys, wherever you are. Your journey to happiness starts now!",
        ),
      ];

  @override
  void skipToSignIn({required BuildContext context}) {
    getIt
        .get<CacheHelper>()
        .saveData(key: AppStrings.cachedOnboarding, value: true)
        .then((value) {
      if (value) {
        context.navigateAndReplace(newRoute: Routes.signInRoute);
      }
    });
  }
}
