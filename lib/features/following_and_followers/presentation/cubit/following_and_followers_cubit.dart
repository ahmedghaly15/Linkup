import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/models/user_model.dart';
import 'package:social_app/features/following_and_followers/domain/usecases/follow.dart';
import 'package:social_app/features/following_and_followers/domain/usecases/unfollow.dart';
import 'package:social_app/features/following_and_followers/domain/usecases/user_is_followed.dart';

part 'following_and_followers_state.dart';

class FollowingAndFollowersCubit extends Cubit<FollowingAndFollowersState> {
  final FollowUseCase followUseCase;
  final UnfollowUseCase unfollowUseCase;
  final UserIsFollowedUseCase userIsFollowedUseCase;

  FollowingAndFollowersCubit({
    required this.followUseCase,
    required this.unfollowUseCase,
    required this.userIsFollowedUseCase,
  }) : super(const FollowingAndFollowersInitial());

  void follow({required UserModel user}) {
    followUseCase(user).then((value) {
      value.fold(
        (failure) => emit(FollowError(error: failure.failureMsg.toString())),
        (success) {
          // getFollowersList();
          emit(const FollowSuccess());
        },
      );
    });
  }

  void unfollow({required UserModel user}) {
    unfollowUseCase(user).then((value) {
      value.fold(
        (failure) => emit(UnfollowError(error: failure.failureMsg.toString())),
        (success) {
          // getFollowersList();
          emit(const UnfollowSuccess());
        },
      );
    });
  }

  Stream<bool> userIsFollowed({required UserModel user}) {
    return userIsFollowedUseCase(user);
  }
}
