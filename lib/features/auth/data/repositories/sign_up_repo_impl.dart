import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_app/core/errors/failure.dart';
import 'package:social_app/core/utils/functions/execute_and_handle_errors.dart';
import 'package:social_app/features/auth/data/datasources/sign_up/sign_up_datasource.dart';
import 'package:social_app/features/auth/domain/entities/create_user_params.dart';
import 'package:social_app/features/auth/domain/entities/sign_up_params.dart';
import 'package:social_app/features/auth/domain/repositories/sign_up_repo.dart';

class SignUpRepoImpl implements SignUpRepo {
  final SignUpDataSource signUpDataSource;

  const SignUpRepoImpl({required this.signUpDataSource});

  @override
  Future<Either<Failure, UserCredential>> signUp({
    required SignUpParams signUpParams,
  }) {
    return executeAndHandleErrors<UserCredential>(
      function: () => signUpDataSource.signUp(
        signUpParams: signUpParams,
      ),
    );
  }

  @override
  Future<Either<Failure, void>> firestoreCreateUSer({
    required CreateUserParams createUserParams,
  }) {
    return executeAndHandleErrors<void>(
      function: () => signUpDataSource.firestoreCreateUSer(
        createUserParams: createUserParams,
      ),
    );
  }
}
