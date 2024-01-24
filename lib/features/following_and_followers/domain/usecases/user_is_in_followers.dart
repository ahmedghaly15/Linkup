import 'package:social_app/core/usecases/regular_usecase.dart';
import 'package:social_app/features/following_and_followers/domain/repositories/following_and_followers_repo.dart';

class UserIsInFollowersUseCase
    implements RegularUseCases<Stream<bool>, String> {
  final FollowingAndFollowersRepo followingAndFollowersRepo;

  const UserIsInFollowersUseCase({required this.followingAndFollowersRepo});

  @override
  Stream<bool> call(String params) {
    return followingAndFollowersRepo.userIsInFollowers(uId: params);
  }
}
