import 'package:social_app/core/usecases/regular_usecase.dart';
import 'package:social_app/features/following_and_followers/domain/repositories/following_and_followers_repo.dart';

class UserIsInFollowingUseCase
    implements RegularUseCases<Stream<bool>, String> {
  final FollowingAndFollowersRepo followingAndFollowersRepo;

  const UserIsInFollowingUseCase({required this.followingAndFollowersRepo});

  @override
  Stream<bool> call(String params) {
    return followingAndFollowersRepo.userIsInFollowing(uId: params);
  }
}
