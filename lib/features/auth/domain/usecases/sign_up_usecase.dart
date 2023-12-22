import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_app/core/errors/failure.dart';
import 'package:social_app/core/usecases/base_usecase.dart';
import 'package:social_app/features/auth/domain/entities/sign_up_params.dart';
import 'package:social_app/features/auth/domain/repositories/sign_up_repo.dart';

class SignUpUseCase implements BaseUseCases<UserCredential, SignUpParams> {
  final SignUpRepo signUpRepo;

  const SignUpUseCase({required this.signUpRepo});

  @override
  Future<Either<Failure, UserCredential>> call(SignUpParams params) async {
    return await signUpRepo.signUp(signUpParams: params);
  }
}
