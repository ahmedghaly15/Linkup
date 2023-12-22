import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_app/core/errors/failure.dart';
import 'package:social_app/features/auth/domain/entities/sign_in_params.dart';

abstract class SignInRepo {
  Future<Either<Failure, UserCredential>> signIn({
    required SignInParams signInParams,
  });
}
