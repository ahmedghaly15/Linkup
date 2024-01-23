part of 'user_cubit.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

class UserInitial extends UserState {
  const UserInitial();
}

class GetUserDataLoading extends UserState {
  const GetUserDataLoading();
}

class GetUserDataSuccess extends UserState {
  final UserModel user;

  const GetUserDataSuccess({required this.user});

  @override
  List<Object> get props => [user];
}

class GetUserDataError extends UserState {
  final String error;

  const GetUserDataError({required this.error});

  @override
  List<Object> get props => [error];
}

class GetUserPostsLoading extends UserState {
  const GetUserPostsLoading();
}

class GetUserPostsSuccess extends UserState {
  final List<PostModel> userPosts;

  const GetUserPostsSuccess({required this.userPosts});

  @override
  List<Object> get props => [userPosts];
}

class GetUserPostsError extends UserState {
  final String error;

  const GetUserPostsError({required this.error});

  @override
  List<Object> get props => [error];
}

class GetPostsLoading extends UserState {
  const GetPostsLoading();
}

class GetPostsSuccess extends UserState {
  final List<PostModel> posts;

  const GetPostsSuccess({required this.posts});

  @override
  List<Object> get props => [posts];
}

class GetPostsError extends UserState {
  final String error;

  const GetPostsError({required this.error});

  @override
  List<Object> get props => [error];
}

class UserSignOutSuccess extends UserState {
  const UserSignOutSuccess();
}

class UserSignOutError extends UserState {
  final String error;

  const UserSignOutError({required this.error});

  @override
  List<Object> get props => [error];
}
