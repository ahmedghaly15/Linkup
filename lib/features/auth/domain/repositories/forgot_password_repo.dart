import 'package:dartz/dartz.dart';
import 'package:social_app/core/errors/failure.dart';

abstract class ForgotPasswordRepo {
  Future<Either<Failure, void>> forgotPassword({required String email});
}
