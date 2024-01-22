part of 'people_who_liked_cubit.dart';

abstract class PeopleWhoLikedState extends Equatable {
  const PeopleWhoLikedState();

  @override
  List<Object> get props => [];
}

class PeopleWhoLikedInitial extends PeopleWhoLikedState {
  const PeopleWhoLikedInitial();
}

class GetPeopleWhoLikedSuccess extends PeopleWhoLikedState {
  final List<UserModel> peopleWhoLiked;

  const GetPeopleWhoLikedSuccess({required this.peopleWhoLiked});

  @override
  List<Object> get props => [peopleWhoLiked];
}

class GetPeopleWhoLikedError extends PeopleWhoLikedState {
  final String error;

  const GetPeopleWhoLikedError({required this.error});

  @override
  List<Object> get props => [error];
}
