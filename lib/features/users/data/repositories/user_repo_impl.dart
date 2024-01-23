import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:social_app/core/errors/failure.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/core/models/user_model.dart';
import 'package:social_app/core/utils/functions/execute_and_handle_errors.dart';
import 'package:social_app/features/posts/data/models/post_model.dart';
import 'package:social_app/features/users/data/datasources/user_datasource.dart';
import 'package:social_app/features/users/domain/repositories/user_repo.dart';

class UserRepoImpl implements UserRepo {
  final UserDataSource userDataSource;

  const UserRepoImpl({required this.userDataSource});

  @override
  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserData() {
    return userDataSource.getUserData();
  }

  @override
  Future<Either<Failure, List<UserModel>>> getFollowingList() {
    return executeAndHandleErrors<List<UserModel>>(
      function: () async {
        final List<UserModel> users = <UserModel>[];
        final result = await userDataSource.getFollowingList();

        users.clear();

        for (var element in result.docs) {
          if (element.data()['uId'] != Helper.currentUser!.uId)
            users.add(UserModel.fromJson(element.data()));
        }

        return users;
      },
    );
  }

  @override
  Future<Either<Failure, List<PostModel>>> getUserPosts({
    required String uId,
  }) {
    return executeAndHandleErrors<List<PostModel>>(
      function: () async {
        final List<PostModel> allPosts = <PostModel>[];
        final List<PostModel> userPosts = <PostModel>[];
        final result = await userDataSource.getUserPosts();

        allPosts.clear();

        for (var item in result.docs) {
          allPosts.add(PostModel.fromJson(item.data()));
        }

        for (var post in allPosts) {
          if (post.user!.uId == uId) {
            userPosts.add(post);
          }
        }

        return userPosts;
      },
    );
  }

  @override
  Future<Either<Failure, void>> signOut() {
    return executeAndHandleErrors<void>(
      function: () => userDataSource.signOut(),
    );
  }

  @override
  Future<Either<Failure, void>> follow({required UserModel user}) {
    return executeAndHandleErrors<void>(
      function: () => userDataSource.follow(user: user),
    );
  }

  @override
  Future<Either<Failure, void>> unfollow({required UserModel user}) {
    return executeAndHandleErrors<void>(
      function: () => userDataSource.unfollow(user: user),
    );
  }

  @override
  Stream<bool> userIsFollowed({required UserModel user}) {
    return userDataSource.userIsFollowed(user: user);
  }
}
