import 'package:flutter/material.dart';
import 'package:social_app/features/onboarding/domain/entities/navigate_between_pages_params.dart';
import 'package:social_app/features/onboarding/domain/entities/onboarding_entity.dart';

abstract class OnboardingDataSource {
  List<OnboardingEntity> onboardingPages();

  void navigateBetweenPages({
    required NavigateBetweenPagesParams params,
  });

  void skipToSignIn({required BuildContext context});
}
