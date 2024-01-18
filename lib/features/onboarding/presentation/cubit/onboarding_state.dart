part of 'onboarding_cubit.dart';

abstract class OnboardingState extends Equatable {
  const OnboardingState();

  @override
  List<Object?> get props => [];
}

class OnboardingInitial extends OnboardingState {
  const OnboardingInitial();
}

class ChangePageViewIndex extends OnboardingState {
  final int index;
  final bool isLastBoarding;
  final bool isFirstBoarding;

  const ChangePageViewIndex({
    required this.index,
    required this.isLastBoarding,
    required this.isFirstBoarding,
  });

  @override
  List<Object> get props => [index, isFirstBoarding, isLastBoarding];
}

class NavigateBetweenPages extends OnboardingState {
  const NavigateBetweenPages();
}

class MoveToPreviousPage extends OnboardingState {
  const MoveToPreviousPage();
}
