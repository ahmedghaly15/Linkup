part of 'posts_cubit.dart';

abstract class PostsState extends Equatable {
  const PostsState();

  @override
  List<Object?> get props => [];
}

class PostsInitial extends PostsState {
  const PostsInitial();
}

class GetPostsLoading extends PostsState {
  const GetPostsLoading();
}

class GetPostsSuccess extends PostsState {
  final List<PostModel> posts;

  const GetPostsSuccess({required this.posts});

  @override
  List<Object> get props => [posts];
}

class GetPostsError extends PostsState {
  final String error;

  const GetPostsError({required this.error});

  @override
  List<Object> get props => [error];
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

class GetLikedPostsByMeSuccess extends PostsState {
  final List<PostModel> likedPosts;

  const GetLikedPostsByMeSuccess({required this.likedPosts});

  @override
  List<Object> get props => [likedPosts];
}

class GetLikedPostsByMeError extends PostsState {
  final String error;

  const GetLikedPostsByMeError({required this.error});

  @override
  List<Object> get props => [error];
}

class ClearPostsList extends PostsState {
  final List<PostModel> posts;

  const ClearPostsList({required this.posts});

  @override
  List<Object> get props => [posts];
}
