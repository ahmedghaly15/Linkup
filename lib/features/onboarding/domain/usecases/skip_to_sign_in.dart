import 'package:flutter/material.dart';
import 'package:social_app/core/usecases/regular_usecase.dart';
import 'package:social_app/features/onboarding/domain/repositories/onboarding_repo.dart';

class SkipToSignInUseCase implements RegularUseCases<void, BuildContext> {
  final OnboardingRepo onboardingRepo;

  const SkipToSignInUseCase({required this.onboardingRepo});

  @override
  void call(BuildContext params) {
    onboardingRepo.skipToSignIn(context: params);
  }
}
