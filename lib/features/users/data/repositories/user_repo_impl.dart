import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:social_app/core/errors/failure.dart';
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
  Stream<QuerySnapshot<Map<String, dynamic>>> getPosts() {
    return userDataSource.getPosts();
  }

  @override
  Future<Either<Failure, List<PostModel>>> getUserPosts({
    required String uId,
  }) {
    return executeAndHandleErrors<List<PostModel>>(
      function: () async {
        final List<PostModel> userPosts = <PostModel>[];
        final result = await userDataSource.getUserPosts();

        userPosts.clear();

        for (var item in result.docs) {
          if (item.data()['user']['uId'] == uId) {
            userPosts.add(PostModel.fromJson(item.data()));
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
}
