part of 'user_profile_cubit.dart';

abstract class UserProfileState extends Equatable {
  const UserProfileState();

  @override
  List<Object?> get props => [];
}

class UserProfileInitial extends UserProfileState {
  const UserProfileInitial();
}

class GetUserPostsLoading extends UserProfileState {
  const GetUserPostsLoading();
}

class GetUserPostsSuccess extends UserProfileState {
  final List<PostModel> userPosts;

  const GetUserPostsSuccess({required this.userPosts});

  @override
  List<Object> get props => [userPosts];
}

class GetUserPostsError extends UserProfileState {
  final String error;

  const GetUserPostsError({required this.error});

  @override
  List<Object> get props => [error];
}
