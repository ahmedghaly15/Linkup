import 'package:flutter/material.dart';
import 'package:social_app/features/onboarding/data/datasources/onboarding_datasource.dart';
import 'package:social_app/features/onboarding/domain/entities/navigate_between_pages_params.dart';
import 'package:social_app/features/onboarding/domain/entities/onboarding_entity.dart';
import 'package:social_app/features/onboarding/domain/repositories/onboarding_repo.dart';

class OnboardingRepoImpl implements OnboardingRepo {
  final OnboardingDataSource onboardingDataSource;

  const OnboardingRepoImpl({required this.onboardingDataSource});

  @override
  void navigateBetweenPages({required NavigateBetweenPagesParams params}) {
    onboardingDataSource.navigateBetweenPages(params: params);
  }

  @override
  List<OnboardingEntity> onboardingPages() =>
      onboardingDataSource.onboardingPages();

  @override
  void skipToSignIn({required BuildContext context}) {
    onboardingDataSource.skipToSignIn(context: context);
  }
}
