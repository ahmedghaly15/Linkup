import 'package:dartz/dartz.dart';
import 'package:social_app/core/errors/failure.dart';
import 'package:social_app/core/models/user_model.dart';
import 'package:social_app/core/usecases/base_usecase.dart';
import 'package:social_app/features/users/domain/repositories/user_repo.dart';

class FollowUseCase implements BaseUseCases<void, UserModel> {
  final UserRepo userRepo;

  const FollowUseCase({required this.userRepo});

  @override
  Future<Either<Failure, void>> call(UserModel params) {
    return userRepo.follow(user: params);
  }
}
