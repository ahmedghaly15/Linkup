import 'package:dartz/dartz.dart';
import 'package:social_app/core/errors/failure.dart';
import 'package:social_app/features/profile/domain/entities/update_user_params.dart';

abstract class EditProfileRepo {
  Future<Either<Failure, void>> updateUser({
    required UpdateUserParams updateUserParams,
  });
}
