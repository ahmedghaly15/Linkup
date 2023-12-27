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

class GetAllUsersLoading extends UserState {
  const GetAllUsersLoading();
}

class GetAllUserSuccess extends UserState {
  final List<UserModel> users;

  const GetAllUserSuccess({required this.users});

  @override
  List<Object> get props => [users];
}

class GetAllUserError extends UserState {
  final String error;

  const GetAllUserError({required this.error});

  @override
  List<Object> get props => [error];
}

class InvertIsSearchingSuccess extends UserState {
  final bool isSearching;

  const InvertIsSearchingSuccess({required this.isSearching});

  @override
  List<Object> get props => [isSearching];
}