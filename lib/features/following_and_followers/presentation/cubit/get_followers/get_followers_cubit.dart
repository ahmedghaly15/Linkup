import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/entities/no_params.dart';
import 'package:social_app/core/models/user_model.dart';
import 'package:social_app/features/following_and_followers/domain/usecases/get_followers.dart';

part 'get_followers_state.dart';

class GetFollowersCubit extends Cubit<GetFollowersState> {
  final GetFollowersUseCase getFollowersUseCase;

  GetFollowersCubit({
    required this.getFollowersUseCase,
  }) : super(const GetFollowersInitial());

  List<UserModel> followers = <UserModel>[];

  void getFollowersList() {
    emit(const GetFollowersLoading());

    getFollowersUseCase(const NoParams()).then((value) {
      value.fold(
        (failure) =>
            emit(GetFollowersError(error: failure.failureMsg.toString())),
        (result) {
          followers = result;
          emit(GetFollowersSuccess(followers: followers));
        },
      );
    });
  }

  List<UserModel> searchList = <UserModel>[];
  bool isSearching = false;

  void invertIsSearching() {
    isSearching = !isSearching;
    emit(InvertIsSearchingSuccess(isSearching: isSearching));
    emit(GetFollowersSuccess(followers: followers));
  }

  void search({required String value}) {
    if (value.isEmpty) {
      isSearching = false;
      emit(GetFollowersSuccess(followers: followers));
      // return; => I can use return here, so when isSearching is false, the searching stops
    }

    isSearching = true;

    searchList = followers
        .where((user) => user.name!.toLowerCase().contains(value.toLowerCase()))
        .toList();

    emit(GetFollowersSuccess(followers: searchList));
  }
}
