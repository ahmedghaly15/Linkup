import 'package:flutter/material.dart';
import 'package:social_app/core/usecases/regular_usecase.dart';
import 'package:social_app/features/onboarding/domain/repositories/onboarding_repo.dart';

class PreviousPageUseCase implements RegularUseCases<void, PageController> {
  final OnboardingRepo onboardingRepo;

  const PreviousPageUseCase({required this.onboardingRepo});

  @override
  void call(PageController params) {
    onboardingRepo.previousPage(pageController: params);
  }
}
