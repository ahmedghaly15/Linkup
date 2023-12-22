import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_app/core/errors/failure.dart';
import 'package:social_app/core/utils/functions/execute_and_handle_errors.dart';
import 'package:social_app/features/auth/data/datasources/sign_in/sign_in_datasource.dart';
import 'package:social_app/features/auth/domain/entities/sign_in_params.dart';
import 'package:social_app/features/auth/domain/repositories/sign_in_repo.dart';

class SignInRepoImpl implements SignInRepo {
  final SignInDataSource signInDataSource;

  const SignInRepoImpl({required this.signInDataSource});

  @override
  Future<Either<Failure, UserCredential>> signIn({
    required SignInParams signInParams,
  }) {
    return executeAndHandleErrors<UserCredential>(
      function: () => signInDataSource.signIn(signInParams: signInParams),
    );
  }
}
