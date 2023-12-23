import 'package:dartz/dartz.dart';
import 'package:social_app/core/errors/failure.dart';
import 'package:social_app/core/usecases/base_usecase.dart';
import 'package:social_app/features/auth/domain/repositories/forgot_password_repo.dart';

class ForgotPasswordUseCase implements BaseUseCases<void, String> {
  final ForgotPasswordRepo forgotPasswordRepo;

  const ForgotPasswordUseCase({required this.forgotPasswordRepo});

  @override
  Future<Either<Failure, void>> call(String params) async {
    return await forgotPasswordRepo.forgotPassword(email: params);
  }
}
