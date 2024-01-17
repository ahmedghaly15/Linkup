import 'package:social_app/core/usecases/regular_usecase.dart';
import 'package:social_app/features/onboarding/domain/entities/navigate_between_pages_params.dart';
import 'package:social_app/features/onboarding/domain/repositories/onboarding_repo.dart';

class NavigateBetweenPagesUseCase
    implements RegularUseCases<void, NavigateBetweenPagesParams> {
  final OnboardingRepo onBoardingRepo;

  const NavigateBetweenPagesUseCase({required this.onBoardingRepo});

  @override
  void call(NavigateBetweenPagesParams params) {
    onBoardingRepo.navigateBetweenPages(params: params);
  }
}
