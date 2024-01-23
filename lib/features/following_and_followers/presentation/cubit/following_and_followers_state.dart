part of 'following_and_followers_cubit.dart';

abstract class FollowingAndFollowersState extends Equatable {
  const FollowingAndFollowersState();

  @override
  List<Object> get props => [];
}

class FollowingAndFollowersInitial extends FollowingAndFollowersState {
  const FollowingAndFollowersInitial();
}

class FollowSuccess extends FollowingAndFollowersState {
  const FollowSuccess();
}

class FollowError extends FollowingAndFollowersState {
  final String error;

  const FollowError({required this.error});

  @override
  List<Object> get props => [error];
}

class UnfollowSuccess extends FollowingAndFollowersState {
  const UnfollowSuccess();
}

class UnfollowError extends FollowingAndFollowersState {
  final String error;

  const UnfollowError({required this.error});

  @override
  List<Object> get props => [error];
}
