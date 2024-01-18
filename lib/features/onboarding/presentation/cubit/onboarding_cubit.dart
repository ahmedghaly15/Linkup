import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/entities/no_params.dart';
import 'package:social_app/features/onboarding/domain/entities/navigate_between_pages_params.dart';
import 'package:social_app/features/onboarding/domain/entities/onboarding_entity.dart';
import 'package:social_app/features/onboarding/domain/usecases/get_onboarding_pages.dart';
import 'package:social_app/features/onboarding/domain/usecases/navigate_between_pages.dart';
import 'package:social_app/features/onboarding/domain/usecases/previous_page_usecase.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  final PreviousPageUseCase previousPageUseCase;
  final GetOnboardingPagesUseCase getOnboardingPagesUseCase;
  final NavigateBetweenPagesUseCase navigateBetweenPagesUseCase;

  OnboardingCubit({
    required this.getOnboardingPagesUseCase,
    required this.navigateBetweenPagesUseCase,
    required this.previousPageUseCase,
  }) : super(const OnboardingInitial());

  bool isLastBoarding = false;
  bool isNotFirstBoarding = false;

  List<OnboardingEntity> getOnboardingPages() =>
      getOnboardingPagesUseCase(const NoParams());

  void onChangePageIndex(int index) {
    _checkFirstBoarding(index);

    _checkLastBoarding(index);

    emit(ChangePageViewIndex(
      index: index,
      isFirstBoarding: isNotFirstBoarding,
      isLastBoarding: isLastBoarding,
    ));
  }

  void _checkLastBoarding(int index) {
    if (index == getOnboardingPages().length - 1) {
      isLastBoarding = true;
    } else {
      isLastBoarding = false;
    }
  }

  void _checkFirstBoarding(int index) {
    if (index != 0) {
      isNotFirstBoarding = true;
    } else {
      isNotFirstBoarding = false;
    }
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

  void previousPage({required PageController pageController}) {
    previousPageUseCase(pageController);

    emit(const MoveToPreviousPage());
  }
}
