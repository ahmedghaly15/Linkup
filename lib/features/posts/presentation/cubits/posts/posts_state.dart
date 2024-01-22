part of 'posts_cubit.dart';

abstract class PostsState extends Equatable {
  const PostsState();

  @override
  List<Object?> get props => [];
}

class PostsInitial extends PostsState {
  const PostsInitial();
}

class CreatePostLoading extends PostsState {
  const CreatePostLoading();
}

class CreatePostSuccess extends PostsState {
  const CreatePostSuccess();
}

class CreatePostError extends PostsState {
  final String error;

  const CreatePostError({required this.error});

  @override
  List<Object> get props => [error];
}

class DeletePostLoading extends PostsState {
  const DeletePostLoading();
}

class DeletePostSuccess extends PostsState {
  const DeletePostSuccess();
}

class DeletePostError extends PostsState {
  final String error;

  const DeletePostError({required this.error});

  @override
  List<Object> get props => [error];
}

class PostImagePickedSuccess extends PostsState {
  final File postImage;

  const PostImagePickedSuccess({required this.postImage});

  @override
  List<Object> get props => [postImage];
}

class PostImagePickedError extends PostsState {
  final String error;

  const PostImagePickedError({required this.error});

  @override
  List<Object> get props => [error];
}

class UploadPostImageLoading extends PostsState {
  const UploadPostImageLoading();
}

class UploadPostImageSuccess extends PostsState {
  final String imageUrl;

  const UploadPostImageSuccess({required this.imageUrl});

  @override
  List<Object> get props => [imageUrl];
}

class UploadPostImageError extends PostsState {
  final String error;

  const UploadPostImageError({required this.error});

  @override
  List<Object> get props => [error];
}

class PostImageRemoved extends PostsState {
  const PostImageRemoved();
}

class LikePostSuccess extends PostsState {
  const LikePostSuccess();
}

class LikePostError extends PostsState {
  final String error;

  const LikePostError({required this.error});

  @override
  List<Object> get props => [error];
}

class UnLikePostSuccess extends PostsState {
  const UnLikePostSuccess();
}

class UnLikePostError extends PostsState {
  final String error;

  const UnLikePostError({required this.error});

  @override
  List<Object> get props => [error];
}

class GetPeopleLikeThePostSuccess extends PostsState {
  final List<LikeModel> peopleLikeThePost;

  const GetPeopleLikeThePostSuccess({required this.peopleLikeThePost});

  @override
  List<Object> get props => [peopleLikeThePost];
}

class GetPeopleLikeThePostError extends PostsState {
  final String error;

  const GetPeopleLikeThePostError({required this.error});

  @override
  List<Object> get props => [error];
}
