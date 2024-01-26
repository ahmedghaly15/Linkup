import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/models/user_model.dart';
import 'package:social_app/features/search/domain/usecases/search.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchUseCase searchUseCase;

  SearchCubit({
    required this.searchUseCase,
  }) : super(const SearchInitial());

  List<UserModel> searchResult = <UserModel>[];

  void search({required String nameOrEmail}) {
    if (nameOrEmail.isEmpty) {
      emit(const SearchEmpty());
      return;
    }

    emit(const SearchLoading());

    searchUseCase(nameOrEmail).then((value) {
      value.fold(
        (failure) => emit(SearchError(error: failure.failureMsg.toString())),
        (result) {
          searchResult = result;
          emit(SearchSuccess(searchResult: searchResult));
        },
      );
    });
  }
}
