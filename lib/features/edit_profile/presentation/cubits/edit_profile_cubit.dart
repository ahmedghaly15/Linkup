import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/core/entities/no_params.dart';
import 'package:social_app/features/edit_profile/domain/entities/update_user_params.dart';
import 'package:social_app/features/edit_profile/domain/usecases/get_image.dart';
import 'package:social_app/features/edit_profile/domain/usecases/update_user.dart';
import 'package:social_app/features/edit_profile/domain/usecases/update_user_posts.dart';
import 'package:social_app/features/edit_profile/domain/usecases/upload_image.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  final UpdateUserUseCase updateUserUseCase;
  final GetImageUseCase getImageUseCase;
  final UploadImageUseCase uploadImageUseCase;
  final UpdateUserPostsUseCase updateUserPostsUseCase;

  EditProfileCubit({
    required this.updateUserUseCase,
    required this.getImageUseCase,
    required this.uploadImageUseCase,
    required this.updateUserPostsUseCase,
  }) : super(const EditProfileInitial());

  void updateUser({required UpdateUserParams params}) {
    emit(const UpdateUserLoading());

    updateUserUseCase(params).then((value) {
      value.fold(
        (failure) => emit(
          UpdateUserError(error: failure.failureMsg.toString()),
        ),
        (success) {
          updateUserPosts();
          emit(const UpdateUserSuccess());
        },
      );
    });
  }

  void updateUserPosts() {
    updateUserPostsUseCase(const NoParams()).then((value) {
      value.fold(
        (failure) => emit(
          UpdateUserPostsError(error: failure.failureMsg.toString()),
        ),
        (success) => emit(const UpdateUserPostsSuccess()),
      );
    });
  }

  File? profileImage;

  void getProfileImage({required ImageSource source}) {
    getImageUseCase(source).then((value) {
      value.fold(
        (failure) => emit(
          ImagePickedError(error: failure.failureMsg.toString()),
        ),
        (result) {
          if (result != null) {
            profileImage = File(result.path);
          }

          emit(ImagePickedSuccess(image: profileImage!));
        },
      );
    });
  }

  void uploadProfileImage({required UpdateUserParams params}) {
    emit(const UploadProfileImageLoading());

    uploadImageUseCase(profileImage).then((value) {
      value.fold(
        (failure) => emit(
          UploadImageError(error: failure.failureMsg.toString()),
        ),
        (result) {
          result.ref.getDownloadURL().then((value) {
            updateUser(
              params: UpdateUserParams(
                name: params.name,
                phone: params.phone,
                bio: params.bio,
                image: value,
              ),
            );

            emit(UploadImageSuccess(imageUrl: value));
          }).catchError((error) {
            emit(UploadImageError(error: error.toString()));
          });
        },
      );
    });
  }

  File? coverImage;

  void getCoverImage({required ImageSource source}) {
    getImageUseCase(source).then((value) {
      value.fold(
        (failure) => emit(
          ImagePickedError(error: failure.failureMsg.toString()),
        ),
        (result) {
          if (result != null) {
            coverImage = File(result.path);
          }

          emit(ImagePickedSuccess(image: coverImage!));
        },
      );
    });
  }

  void uploadCoverImage({required UpdateUserParams params}) {
    emit(const UploadCoverImageLoading());

    uploadImageUseCase(coverImage).then((value) {
      value.fold(
        (failure) => emit(
          UploadImageError(error: failure.failureMsg.toString()),
        ),
        (result) {
          result.ref.getDownloadURL().then((value) {
            updateUser(
              params: UpdateUserParams(
                name: params.name,
                phone: params.phone,
                bio: params.bio,
                cover: value,
              ),
            );

            emit(UploadImageSuccess(imageUrl: value));
          }).catchError((error) {
            emit(UploadImageError(error: error.toString()));
          });
        },
      );
    });
  }
}