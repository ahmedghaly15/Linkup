import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:social_app/core/errors/failure.dart';
import 'package:social_app/core/errors/firebase_failure.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/core/internet/internet_checker.dart';
import 'package:social_app/core/models/user_model.dart';
import 'package:social_app/core/utils/app_strings.dart';
import 'package:social_app/core/utils/functions/execute_and_handle_errors.dart';
import 'package:social_app/features/posts/data/models/post_model.dart';
import 'package:social_app/features/users/data/datasources/user_datasource.dart';
import 'package:social_app/features/users/domain/repositories/user_repo.dart';
import 'package:social_app/service_locator.dart';

class UserRepoImpl implements UserRepo {
  final UserDataSource userDataSource;

  const UserRepoImpl({required this.userDataSource});

  @override
  Future<Either<Failure, DocumentSnapshot<Map<String, dynamic>>>>
      getUserData() {
    return executeAndHandleErrors<DocumentSnapshot<Map<String, dynamic>>>(
      function: () => userDataSource.getUserData(),
    );
  }

  @override
  Future<Either<Failure, List<UserModel>>> getAllUsers() async {
    if (await getIt.get<InternetChecker>().isConnected) {
      try {
        final List<UserModel> users = <UserModel>[];
        final result = await userDataSource.getAllUsers();

        users.clear();

        for (var element in result.docs) {
          if (element.data()['uId'] != Helper.currentUser!.uId)
            users.add(UserModel.fromJson(element.data()));
        }

        return Right(users);
      } catch (failure) {
        if (failure is FirebaseException) {
          return Left(FirebaseFailure.fromFirebaseException(failure.code));
        }
        return Left(FirebaseFailure(failureMsg: failure.toString()));
      }
    } else {
      return const Left(FirebaseFailure(failureMsg: AppStrings.noInternet));
    }
  }

  @override
  Future<Either<Failure, List<PostModel>>> getUserPosts({
    required String uId,
  }) async {
    if (await getIt.get<InternetChecker>().isConnected) {
      try {
        final List<PostModel> allPosts = <PostModel>[];
        final List<PostModel> userPosts = <PostModel>[];
        final result = await userDataSource.getUserPosts();

        allPosts.clear();

        for (var item in result.docs) {
          allPosts.add(PostModel.fromJson(item.data()));
        }

        for (var post in allPosts) {
          if (post.uId == uId) {
            userPosts.add(post);
          }
        }

        return Right(userPosts);
      } catch (failure) {
        if (failure is FirebaseException) {
          return Left(FirebaseFailure.fromFirebaseException(failure.code));
        }
        return Left(FirebaseFailure(failureMsg: failure.toString()));
      }
    } else {
      return const Left(FirebaseFailure(failureMsg: AppStrings.noInternet));
    }
  }
}
