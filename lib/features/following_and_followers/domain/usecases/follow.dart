import 'package:dartz/dartz.dart';
import 'package:social_app/core/errors/failure.dart';
import 'package:social_app/core/models/user_model.dart';
import 'package:social_app/core/usecases/base_usecase.dart';
import 'package:social_app/features/following_and_followers/domain/repositories/following_and_followers_repo.dart';

class FollowUseCase implements BaseUseCases<void, UserModel> {
  final FollowingAndFollowersRepo followingAndFollowersRepo;

  const FollowUseCase({required this.followingAndFollowersRepo});

  @override
  Future<Either<Failure, void>> call(UserModel params) {
    return followingAndFollowersRepo.follow(user: params);
  }
}
