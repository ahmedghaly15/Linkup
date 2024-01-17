import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/entities/no_params.dart';
import 'package:social_app/features/onboarding/domain/entities/navigate_between_pages_params.dart';
import 'package:social_app/features/onboarding/domain/entities/onboarding_entity.dart';
import 'package:social_app/features/onboarding/domain/usecases/get_onboarding_pages.dart';
import 'package:social_app/features/onboarding/domain/usecases/navigate_between_pages.dart';
import 'package:social_app/features/onboarding/domain/usecases/skip_to_sign_in.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  final SkipToSignInUseCase navigateToSignInUseCase;
  final GetOnboardingPagesUseCase getOnboardingPagesUseCase;
  final NavigateBetweenPagesUseCase navigateBetweenPagesUseCase;

  OnboardingCubit({
    required this.getOnboardingPagesUseCase,
    required this.navigateBetweenPagesUseCase,
    required this.navigateToSignInUseCase,
  }) : super(const OnboardingInitial());

  bool isLastBoarding = false;

  List<OnboardingEntity> getOnboardingPages() =>
      getOnboardingPagesUseCase(const NoParams());

  void onChangePageIndex(int index) {
    if (index == getOnboardingPages().length - 1) {
      isLastBoarding = true;
    } else {
      isLastBoarding = false;
    }
    emit(ChangePageViewIndex(index: index));
  }

  void navigateBetweenPages({
    required BuildContext context,
    required PageController pageController,
  }) {
    navigateBetweenPagesUseCase(
      NavigateBetweenPagesParams(
        context: context,
        pageController: pageController,
        isLastBoarding: isLastBoarding,
      ),
    );

    emit(const NavigateBetweenPages());
  }

  void navigateToSignIn({required BuildContext context}) {
    navigateToSignInUseCase(context);

    emit(const SkipToSignIn());
  }
}
