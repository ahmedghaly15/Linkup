import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/core/errors/failure.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/core/models/user_model.dart';
import 'package:social_app/core/utils/app_strings.dart';
import 'package:social_app/core/utils/functions/execute_and_handle_errors.dart';
import 'package:social_app/features/edit_profile/data/datasources/edit_profile_datasource.dart';
import 'package:social_app/features/edit_profile/domain/entities/update_user_params.dart';
import 'package:social_app/features/edit_profile/domain/repositories/edit_profile_repo.dart';
import 'package:social_app/service_locator.dart';

class EditProfileRepoImpl implements EditProfileRepo {
  final EditProfileDataSource editProfileDataSource;

  const EditProfileRepoImpl({required this.editProfileDataSource});

  @override
  Future<Either<Failure, void>> updateUser({
    required UpdateUserParams updateUserParams,
  }) {
    final UserModel userModel = UserModel(
      name: updateUserParams.name,
      phone: updateUserParams.phone,
      bio: updateUserParams.bio,
      image: updateUserParams.image ?? Helper.currentUser!.image,
      cover: updateUserParams.cover ?? Helper.currentUser!.cover,
      email: updateUserParams.email,
      uId: Helper.currentUser!.uId,
      isEmailVerified: Helper.currentUser!.isEmailVerified,
      xUrl: updateUserParams.xUrl,
      facebookUrl: updateUserParams.facebookUrl,
      instagramUrl: updateUserParams.instagramUrl,
      githubUrl: updateUserParams.githubUrl,
    );

    Helper.currentUser = userModel;

    return executeAndHandleErrors<void>(
      function: () => editProfileDataSource.updateUser(userModel: userModel),
    );
  }

  @override
  Future<Either<Failure, XFile?>> getImage({required ImageSource source}) {
    return executeAndHandleErrors(
      function: () => editProfileDataSource.getImage(source: source),
    );
  }

  @override
  Future<Either<Failure, TaskSnapshot>> uploadImage({File? image}) {
    return executeAndHandleErrors<TaskSnapshot>(
      function: () => editProfileDataSource.uploadImage(image: image),
    );
  }

  @override
  Future<Either<Failure, void>> updateUserPosts() {
    return executeAndHandleErrors<void>(function: () async {
      final result = await editProfileDataSource.updateUserPosts();

      for (var element in result.docs) {
        if (element.data()['user']['uId'] == Helper.uId) {
          return await _accessPostsCollection()
              .doc(element.data()['postId'])
              .update(
            {
              'user': _currentUserToJson,
            },
          );
        }
      }
    });
  }

  @override
  Future<Either<Failure, void>> updateUserLikes() {
    return executeAndHandleErrors<void>(
      function: () async {
        final result = await editProfileDataSource.updateUserPosts();

        for (var post in result.docs) {
          final postLikes = await _accessPostLikesCollection(post).get();

          for (var like in postLikes.docs) {
            if (like.data()['user']['uId'] == Helper.uId) {
              return await _accessPostLikesCollection(post)
                  .doc(Helper.uId)
                  .update(
                {
                  'user': _currentUserToJson,
                },
              );
            }
          }
        }
      },
    );
  }

  @override
  Future<Either<Failure, void>> updateUserComments() {
    return executeAndHandleErrors<void>(
      function: () async {
        final posts = await editProfileDataSource.updateUserPosts();

        for (var post in posts.docs) {
          final comments = await _accessPostCommentsCollection(post).get();

          for (var comment in comments.docs) {
            if (comment.data()['user']['uId'] == Helper.uId) {
              await _accessPostCommentsCollection(post).doc(comment.id).update(
                {
                  'user': _currentUserToJson,
                },
              );
            }
          }
        }
      },
    );
  }

  @override
  Future<Either<Failure, void>> updateUserInOtherUsersFollowers() {
    return executeAndHandleErrors<void>(function: () async {
      final users =
          await editProfileDataSource.updateUserInOtherFollowingAndFollowers();

      for (var user in users.docs) {
        final followers = await _accessUserFollowersCollection(user).get();

        for (var follower in followers.docs) {
          if (follower.data()['uId'] == Helper.uId) {
            await _accessUserFollowersCollection(user)
                .doc(Helper.uId)
                .update(_currentUserToJson);
          }
        }
      }
    });
  }

  @override
  Future<Either<Failure, void>> updateUserInOtherUsersFollowing() {
    return executeAndHandleErrors<void>(function: () async {
      final users =
          await editProfileDataSource.updateUserInOtherFollowingAndFollowers();

      for (var user in users.docs) {
        final following = await _accessUserFollowingCollection(user).get();

        for (var followed in following.docs) {
          if (followed.data()['uId'] == Helper.uId) {
            await _accessUserFollowingCollection(user)
                .doc(Helper.uId)
                .update(_currentUserToJson);
          }
        }
      }
    });
  }

  Map<Object, Object?> get _currentUserToJson {
    return {
      'name': Helper.currentUser!.name,
      'image': Helper.currentUser!.image,
      'uId': Helper.uId,
      'isEmailVerified': Helper.currentUser!.isEmailVerified,
      'email': Helper.currentUser!.email,
      'phone': Helper.currentUser!.phone,
      'bio': Helper.currentUser!.bio,
      'githubUrl': Helper.currentUser!.githubUrl,
      'facebookUrl': Helper.currentUser!.facebookUrl,
      'instagramUrl': Helper.currentUser!.instagramUrl,
      'xUrl': Helper.currentUser!.xUrl,
    };
  }

  CollectionReference<Map<String, dynamic>> _accessUserFollowingCollection(
      QueryDocumentSnapshot<Map<String, dynamic>> user) {
    return getIt
        .get<FirebaseFirestore>()
        .collection(AppStrings.users)
        .doc(user.id)
        .collection(AppStrings.following);
  }

  CollectionReference<Map<String, dynamic>> _accessUserFollowersCollection(
      QueryDocumentSnapshot<Map<String, dynamic>> user) {
    return getIt
        .get<FirebaseFirestore>()
        .collection(AppStrings.users)
        .doc(user.id)
        .collection(AppStrings.followers);
  }

  CollectionReference<Map<String, dynamic>> _accessPostsCollection() {
    return getIt.get<FirebaseFirestore>().collection(AppStrings.posts);
  }

  CollectionReference<Map<String, dynamic>> _accessPostLikesCollection(
    QueryDocumentSnapshot<Map<String, dynamic>> post,
  ) {
    return _accessPostsCollection()
        .doc(post.data()['postId'])
        .collection(AppStrings.likes);
  }

  CollectionReference<Map<String, dynamic>> _accessPostCommentsCollection(
    QueryDocumentSnapshot<Map<String, dynamic>> post,
  ) {
    return _accessPostsCollection()
        .doc(post.data()['postId'])
        .collection(AppStrings.comments);
  }
}
