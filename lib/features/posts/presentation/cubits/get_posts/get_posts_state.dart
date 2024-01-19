part of 'get_posts_cubit.dart';

abstract class GetPostsState extends Equatable {
  const GetPostsState();

  @override
  List<Object?> get props => [];
}

class GetPostsInitial extends GetPostsState {
  const GetPostsInitial();
}

class GetPostsLoading extends GetPostsState {
  const GetPostsLoading();
}

class GetPostsSuccess extends GetPostsState {
  final List<PostModel> posts;

  const GetPostsSuccess({required this.posts});

  @override
  List<Object> get props => [posts];
}

class GetPostsError extends GetPostsState {
  final String error;

  const GetPostsError({required this.error});

  @override
  List<Object> get props => [error];
}
