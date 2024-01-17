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

  const ChangePageViewIndex({required this.index});

  @override
  List<Object> get props => [index];
}

class NavigateBetweenPages extends OnboardingState {
  const NavigateBetweenPages();
}

class SkipToSignIn extends OnboardingState {
  const SkipToSignIn();
}
