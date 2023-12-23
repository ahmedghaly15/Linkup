part of 'linkup_cubit.dart';

abstract class LinkupState extends Equatable {
  const LinkupState();

  @override
  List<Object?> get props => [];
}

class LinkupInitial extends LinkupState {
  const LinkupInitial();
}

class ChangeBottomNavIndex extends LinkupState {
  final int index;

  const ChangeBottomNavIndex({required this.index});

  @override
  List<Object> get props => [index];
}

class ChangeBottomNavToHome extends LinkupState {
  const ChangeBottomNavToHome();
}

class GetUserDataLoading extends LinkupState {
  const GetUserDataLoading();
}

class GetUserDataSuccess extends LinkupState {
  const GetUserDataSuccess();
}

class GetUserDataError extends LinkupState {
  final String error;

  const GetUserDataError({required this.error});

  @override
  List<Object> get props => [error];
}

class GetAllUsersLoading extends LinkupState {
  const GetAllUsersLoading();
}

class GetAllUserSuccess extends LinkupState {
  final List<UserModel> users;

  const GetAllUserSuccess({required this.users});

  @override
  List<Object> get props => [users];
}

class GetAllUserError extends LinkupState {
  final String error;
  const GetAllUserError({required this.error});

  @override
  List<Object> get props => [error];
}

class InvertIsSearchingSuccess extends LinkupState {
  const InvertIsSearchingSuccess();
}

class SearchListUpdateSuccess extends LinkupState {
  final List<UserModel> list;

  const SearchListUpdateSuccess({required this.list});

  @override
  List<Object> get props => [list];
}
