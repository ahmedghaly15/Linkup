import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/entities/no_params.dart';
import 'package:social_app/core/models/user_model.dart';
import 'package:social_app/features/following_and_followers/domain/usecases/get_following.dart';

part 'get_following_state.dart';

class GetFollowingCubit extends Cubit<GetFollowingState> {
  final GetFollowingUseCase getFollowingUseCase;

  GetFollowingCubit({
    required this.getFollowingUseCase,
  }) : super(const GetFollowingInitial());

  List<UserModel> following = <UserModel>[];

  void getFollowingList() {
    emit(const GetFollowingLoading());

    getFollowingUseCase(const NoParams()).then((value) {
      value.fold(
        (failure) =>
            emit(GetFollowingError(error: failure.failureMsg.toString())),
        (result) {
          following = result;
          emit(GetFollowingSuccess(following: following));
        },
      );
    });
  }
}
