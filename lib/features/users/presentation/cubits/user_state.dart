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

class GetFollowersListLoading extends UserState {
  const GetFollowersListLoading();
}

class GetFollowersListSuccess extends UserState {
  final List<UserModel> users;

  const GetFollowersListSuccess({required this.users});

  @override
  List<Object> get props => [users];
}

class GetFollowersListError extends UserState {
  final String error;

  const GetFollowersListError({required this.error});

  @override
  List<Object> get props => [error];
}

class GetFollowingListLoading extends UserState {
  const GetFollowingListLoading();
}

class GetFollowingListSuccess extends UserState {
  final List<UserModel> users;

  const GetFollowingListSuccess({required this.users});

  @override
  List<Object> get props => [users];
}

class GetFollowingListError extends UserState {
  final String error;

  const GetFollowingListError({required this.error});

  @override
  List<Object> get props => [error];
}

class InvertIsSearchingSuccess extends UserState {
  final bool isSearching;

  const InvertIsSearchingSuccess({required this.isSearching});

  @override
  List<Object> get props => [isSearching];
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

class UserSignOutSuccess extends UserState {
  const UserSignOutSuccess();
}

class UserSignOutError extends UserState {
  final String error;

  const UserSignOutError({required this.error});

  @override
  List<Object> get props => [error];
}

class FollowSuccess extends UserState {
  const FollowSuccess();
}

class FollowError extends UserState {
  final String error;

  const FollowError({required this.error});

  @override
  List<Object> get props => [error];
}

class UnfollowSuccess extends UserState {
  const UnfollowSuccess();
}

class UnfollowError extends UserState {
  final String error;

  const UnfollowError({required this.error});

  @override
  List<Object> get props => [error];
}
