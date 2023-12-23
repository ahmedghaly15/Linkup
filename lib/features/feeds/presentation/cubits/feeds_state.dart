part of 'feeds_cubit.dart';

abstract class FeedsState extends Equatable {
  const FeedsState();

  @override
  List<Object?> get props => [];
}

class FeedsInitial extends FeedsState {
  const FeedsInitial();
}

class GetPostsLoading extends FeedsState {
  const GetPostsLoading();
}

class GetPostsSuccess extends FeedsState {
  final List<PostModel> posts;

  const GetPostsSuccess({required this.posts});

  @override
  List<Object> get props => [posts];
}

class GetPostsError extends FeedsState {
  final String error;

  const GetPostsError({required this.error});

  @override
  List<Object> get props => [error];
}

class CreatePostLoading extends FeedsState {
  const CreatePostLoading();
}

class CreatePostSuccess extends FeedsState {
  final PostModel post;

  const CreatePostSuccess({required this.post});

  @override
  List<Object> get props => [post];
}

class CreatePostError extends FeedsState {
  final String error;

  const CreatePostError({required this.error});

  @override
  List<Object> get props => [error];
}

class DeletePostLoading extends FeedsState {
  const DeletePostLoading();
}

class DeletePostSuccess extends FeedsState {
  const DeletePostSuccess();
}

class DeletePostError extends FeedsState {
  final String error;

  const DeletePostError({required this.error});

  @override
  List<Object> get props => [error];
}

class PostImagePickedSuccess extends FeedsState {
  const PostImagePickedSuccess();
}

class PostImagePickedError extends FeedsState {
  final String error;

  const PostImagePickedError({required this.error});

  @override
  List<Object> get props => [error];
}

class UploadPostImageLoading extends FeedsState {
  const UploadPostImageLoading();
}

class UploadPostImageSuccess extends FeedsState {
  final String imageUrl;

  const UploadPostImageSuccess({required this.imageUrl});

  @override
  List<Object> get props => [imageUrl];
}

class UploadPostImageError extends FeedsState {
  final String error;

  const UploadPostImageError({required this.error});

  @override
  List<Object> get props => [error];
}

class PostImageRemoved extends FeedsState {
  const PostImageRemoved();
}
