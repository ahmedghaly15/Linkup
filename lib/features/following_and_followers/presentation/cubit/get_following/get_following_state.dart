part of 'get_following_cubit.dart';

abstract class GetFollowingState extends Equatable {
  const GetFollowingState();

  @override
  List<Object?> get props => [];
}

class GetFollowingInitial extends GetFollowingState {
  const GetFollowingInitial();
}

class GetFollowingLoading extends GetFollowingState {
  const GetFollowingLoading();
}

class GetFollowingSuccess extends GetFollowingState {
  final List<UserModel> following;

  const GetFollowingSuccess({required this.following});

  @override
  List<Object> get props => [following];
}

class GetFollowingError extends GetFollowingState {
  final String error;

  const GetFollowingError({required this.error});

  @override
  List<Object> get props => [error];
}
