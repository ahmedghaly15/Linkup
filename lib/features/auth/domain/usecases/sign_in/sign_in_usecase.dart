import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_app/core/errors/failure.dart';
import 'package:social_app/core/usecases/base_usecase.dart';
import 'package:social_app/features/auth/domain/entities/sign_in_params.dart';
import 'package:social_app/features/auth/domain/repositories/sign_in_repo.dart';

class SignInUseCase implements BaseUseCases<UserCredential, SignInParams> {
  final SignInRepo signInRepo;

  const SignInUseCase({required this.signInRepo});

  @override
  Future<Either<Failure, UserCredential>> call(SignInParams params) async {
    return await signInRepo.signIn(signInParams: params);
  }
}
