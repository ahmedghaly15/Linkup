part of 'search_cubit.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object?> get props => [];
}

class SearchInitial extends SearchState {
  const SearchInitial();
}

class SearchLoading extends SearchState {
  const SearchLoading();
}

class SearchSuccess extends SearchState {
  final List<UserModel> searchResult;

  const SearchSuccess({required this.searchResult});

  @override
  List<Object?> get props => [searchResult];
}

class SearchError extends SearchState {
  final String error;

  const SearchError({required this.error});

  @override
  List<Object?> get props => [error];
}

class SearchEmpty extends SearchState {
  const SearchEmpty();
}
