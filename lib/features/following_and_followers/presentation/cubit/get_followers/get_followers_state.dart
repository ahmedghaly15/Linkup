part of 'get_followers_cubit.dart';

abstract class GetFollowersState extends Equatable {
  const GetFollowersState();

  @override
  List<Object?> get props => [];
}

class GetFollowersInitial extends GetFollowersState {
  const GetFollowersInitial();
}

class GetFollowersLoading extends GetFollowersState {
  const GetFollowersLoading();
}

class GetFollowersSuccess extends GetFollowersState {
  final List<UserModel> followers;

  const GetFollowersSuccess({required this.followers});

  @override
  List<Object> get props => [followers];
}

class GetFollowersError extends GetFollowersState {
  final String error;

  const GetFollowersError({required this.error});

  @override
  List<Object> get props => [error];
}

class InvertIsSearchingSuccess extends GetFollowersState {
  final bool isSearching;

  const InvertIsSearchingSuccess({required this.isSearching});

  @override
  List<Object> get props => [isSearching];
}
