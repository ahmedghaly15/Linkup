part of 'edit_profile_cubit.dart';

abstract class EditProfileState extends Equatable {
  const EditProfileState();

  @override
  List<Object?> get props => [];
}

class EditProfileInitial extends EditProfileState {
  const EditProfileInitial();
}

class UpdateUserLoading extends EditProfileState {
  const UpdateUserLoading();
}

class UpdateUserSuccess extends EditProfileState {
  const UpdateUserSuccess();
}

class UpdateUserError extends EditProfileState {
  final String error;

  const UpdateUserError({required this.error});

  @override
  List<Object?> get props => [error];
}

class UpdateUserPostsSuccess extends EditProfileState {
  const UpdateUserPostsSuccess();
}

class UpdateUserPostsError extends EditProfileState {
  final String error;

  const UpdateUserPostsError({required this.error});

  @override
  List<Object?> get props => [error];
}

class UpdateUserLikesSuccess extends EditProfileState {
  const UpdateUserLikesSuccess();
}

class UpdateUserLikesError extends EditProfileState {
  final String error;

  const UpdateUserLikesError({required this.error});

  @override
  List<Object?> get props => [error];
}

class ImagePickedSuccess extends EditProfileState {
  final File image;

  const ImagePickedSuccess({required this.image});

  @override
  List<Object> get props => [image];
}

class ImagePickedError extends EditProfileState {
  final String error;

  const ImagePickedError({required this.error});

  @override
  List<Object> get props => [error];
}

class UploadProfileImageLoading extends EditProfileState {
  const UploadProfileImageLoading();
}

class UploadImageSuccess extends EditProfileState {
  final String imageUrl;

  const UploadImageSuccess({required this.imageUrl});

  @override
  List<Object> get props => [imageUrl];
}

class UploadImageError extends EditProfileState {
  final String error;

  const UploadImageError({required this.error});

  @override
  List<Object> get props => [error];
}

class UploadCoverImageLoading extends EditProfileState {
  const UploadCoverImageLoading();
}
