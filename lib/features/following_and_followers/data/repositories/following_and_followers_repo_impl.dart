import 'package:dartz/dartz.dart';
import 'package:social_app/core/errors/failure.dart';
import 'package:social_app/core/models/user_model.dart';
import 'package:social_app/core/utils/functions/execute_and_handle_errors.dart';
import 'package:social_app/features/following_and_followers/data/datasources/following_and_followers_datasource.dart';
import 'package:social_app/features/following_and_followers/domain/repositories/following_and_followers_repo.dart';

class FollowingAndFollowersRepoImpl implements FollowingAndFollowersRepo {
  final FollowingAndFollowersDataSource followingAndFollowersDataSource;

  const FollowingAndFollowersRepoImpl({
    required this.followingAndFollowersDataSource,
  });

  @override
  Future<Either<Failure, List<UserModel>>> getFollowersList() {
    return executeAndHandleErrors<List<UserModel>>(
      function: () async {
        final List<UserModel> users = <UserModel>[];
        final result = await followingAndFollowersDataSource.getFollowersList();

        users.clear();

        for (var element in result.docs) {
          users.add(UserModel.fromJson(element.data()));
        }

        return users;
      },
    );
  }

  @override
  Future<Either<Failure, List<UserModel>>> getFollowingList() {
    return executeAndHandleErrors<List<UserModel>>(
      function: () async {
        final List<UserModel> users = <UserModel>[];
        final result = await followingAndFollowersDataSource.getFollowingList();

        users.clear();

        for (var element in result.docs) {
          users.add(UserModel.fromJson(element.data()));
        }

        return users;
      },
    );
  }

  @override
  Future<Either<Failure, void>> follow({required UserModel user}) {
    return executeAndHandleErrors<void>(
      function: () => followingAndFollowersDataSource.follow(user: user),
    );
  }

  @override
  Future<Either<Failure, void>> unfollow({required UserModel user}) {
    return executeAndHandleErrors<void>(
      function: () => followingAndFollowersDataSource.unfollow(user: user),
    );
  }

  @override
  Stream<bool> userIsFollowed({required UserModel user}) {
    return followingAndFollowersDataSource.userIsFollowed(user: user);
  }
}
