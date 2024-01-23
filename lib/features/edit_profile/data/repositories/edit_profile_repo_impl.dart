import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/core/errors/failure.dart';
import 'package:social_app/core/errors/firebase_failure.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/core/internet/internet_checker.dart';
import 'package:social_app/core/models/user_model.dart';
import 'package:social_app/core/utils/app_strings.dart';
import 'package:social_app/core/utils/functions/execute_and_handle_errors.dart';
import 'package:social_app/features/posts/data/models/post_model.dart';
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
      email: Helper.currentUser!.email,
      uId: Helper.currentUser!.uId,
      isEmailVerified: false,
    );

    Helper.currentUser = userModel;

    return executeAndHandleErrors<void>(
      function: () => editProfileDataSource.updateUser(
        userModel: userModel,
      ),
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
  Future<Either<Failure, void>> updateUserPosts() async {
    if (await getIt.get<InternetChecker>().isConnected) {
      try {
        void method() {}
        final result = await editProfileDataSource.getPosts();

        for (var element in result.docs) {
          final post = PostModel.fromJson(element.data());

          if (post.user!.uId == Helper.currentUser!.uId) {
            return Right(await getIt
                .get<FirebaseFirestore>()
                .collection(AppStrings.posts)
                .doc(element.id)
                .update({
              'name': Helper.currentUser!.name,
              'image': Helper.currentUser!.image,
            }));
          }
        }
        return Right(method());
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