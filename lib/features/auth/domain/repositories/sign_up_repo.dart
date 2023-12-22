import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_app/core/errors/failure.dart';
import 'package:social_app/features/auth/domain/entities/create_user_params.dart';
import 'package:social_app/features/auth/domain/entities/sign_up_params.dart';

abstract class SignUpRepo {
  Future<Either<Failure, UserCredential>> signUp({
    required SignUpParams signUpParams,
  });

  Future<Either<Failure, void>> firestoreCreateUSer({
    required CreateUserParams createUserParams,
  });
}
