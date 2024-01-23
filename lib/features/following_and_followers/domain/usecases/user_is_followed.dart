import 'package:social_app/core/models/user_model.dart';
import 'package:social_app/core/usecases/regular_usecase.dart';
import 'package:social_app/features/following_and_followers/domain/repositories/following_and_followers_repo.dart';

class UserIsFollowedUseCase
    implements RegularUseCases<Stream<bool>, UserModel> {
  final FollowingAndFollowersRepo followingAndFollowersRepo;

  const UserIsFollowedUseCase({required this.followingAndFollowersRepo});

  @override
  Stream<bool> call(UserModel params) {
    return followingAndFollowersRepo.userIsFollowed(user: params);
  }
}
