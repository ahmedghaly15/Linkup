import 'package:social_app/core/entities/no_params.dart';
import 'package:social_app/core/usecases/regular_usecase.dart';
import 'package:social_app/features/onboarding/domain/entities/onboarding_entity.dart';
import 'package:social_app/features/onboarding/domain/repositories/onboarding_repo.dart';

class GetOnboardingPagesUseCase
    implements RegularUseCases<List<OnboardingEntity>, NoParams> {
  final OnboardingRepo onboardingRepo;

  const GetOnboardingPagesUseCase({required this.onboardingRepo});

  @override
  List<OnboardingEntity> call(NoParams params) =>
      onboardingRepo.onboardingPages();
}
