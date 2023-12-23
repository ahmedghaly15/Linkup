import 'package:dartz/dartz.dart';
import 'package:social_app/core/errors/failure.dart';
import 'package:social_app/core/utils/functions/execute_and_handle_errors.dart';
import 'package:social_app/features/auth/data/datasources/forgot_password/forgot_password_datasource.dart';
import 'package:social_app/features/auth/domain/repositories/forgot_password_repo.dart';

class ForgotPasswordRepoImpl implements ForgotPasswordRepo {
  final ForgotPasswordDataSource forgotPasswordDataSource;

  const ForgotPasswordRepoImpl({required this.forgotPasswordDataSource});

  @override
  Future<Either<Failure, void>> forgotPassword({required String email}) {
    return executeAndHandleErrors<void>(
      function: () => forgotPasswordDataSource.forgotPassword(email: email),
    );
  }
}
