import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/entities/no_params.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/core/models/user_model.dart';
import 'package:social_app/features/posts/data/models/post_model.dart';
import 'package:social_app/features/users/domain/usecases/follow.dart';
import 'package:social_app/features/users/domain/usecases/get_following_list.dart';
import 'package:social_app/features/users/domain/usecases/get_user_data.dart';
import 'package:social_app/features/users/domain/usecases/get_user_posts.dart';
import 'package:social_app/features/users/domain/usecases/sign_out.dart';
import 'package:social_app/features/users/domain/usecases/unfollow.dart';
import 'package:social_app/features/users/domain/usecases/user_is_followed.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final GetUserDataUseCase getUserDataUseCase;
  final GetFollowingListUseCase getAllUsersUseCase;
  final GetUserPostsUseCase getAllUserPostsUseCase;
  final FollowUseCase followUseCase;
  final UnfollowUseCase unfollowUseCase;
  final UserIsFollowedUseCase userIsFollowedUseCase;
  final SignOutUseCase signOutUseCase;

  UserCubit({
    required this.getUserDataUseCase,
    required this.getAllUsersUseCase,
    required this.getAllUserPostsUseCase,
    required this.followUseCase,
    required this.unfollowUseCase,
    required this.userIsFollowedUseCase,
    required this.signOutUseCase,
  }) : super(const UserInitial());

  List<UserModel> followingList = <UserModel>[];

  void getAllUsers() {
    emit(const GetAllUsersLoading());

    getAllUsersUseCase(const NoParams()).then((value) {
      value.fold(
        (failure) =>
            emit(GetAllUserError(error: failure.failureMsg.toString())),
        (result) {
          followingList = result;
          emit(GetAllUserSuccess(followingList: followingList));
        },
      );
    });
  }

  Future<void> getUserData() async {
    emit(const GetUserDataLoading());

    getUserDataUseCase(const NoParams()).listen((event) {
      Helper.currentUser = UserModel.fromJson(event.data()!);
      emit(GetUserDataSuccess(user: Helper.currentUser!));
    }).onError((error) {
      emit(GetUserDataError(error: error.toString()));
    });
  }

  List<UserModel> searchList = <UserModel>[];
  bool isSearching = false;

  void invertIsSearching() {
    isSearching = !isSearching;
    emit(InvertIsSearchingSuccess(isSearching: isSearching));
    emit(GetAllUserSuccess(followingList: followingList));
  }

  void search({required String value}) {
    if (value.isEmpty) {
      isSearching = false;
      emit(GetAllUserSuccess(followingList: followingList));
      // return; => I can use return here, so when isSearching is false, the searching stops
    }

    isSearching = true;

    searchList = followingList
        .where((user) => user.name!.toLowerCase().contains(value.toLowerCase()))
        .toList();

    emit(GetAllUserSuccess(followingList: searchList));
  }

  List<PostModel> userPosts = <PostModel>[];

  Future<void> getUserPosts({required String uId}) async {
    getAllUserPostsUseCase(uId).then((value) {
      value.fold(
        (failure) =>
            emit(GetUserPostsError(error: failure.failureMsg.toString())),
        (posts) {
          userPosts = posts;
          emit(GetUserPostsSuccess(userPosts: userPosts));
        },
      );
    });
  }

  void follow({required UserModel user}) {
    followUseCase(user).then((value) {
      value.fold(
        (failure) => emit(FollowError(error: failure.failureMsg.toString())),
        (success) {
          getAllUsers();
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
          getAllUsers();
          emit(const UnfollowSuccess());
        },
      );
    });
  }

  Stream<bool> userIsFollowed({required UserModel user}) {
    return userIsFollowedUseCase(user);
  }

  void signOut() {
    signOutUseCase(const NoParams()).then((value) {
      value.fold(
        (failure) => emit(
          UserSignOutError(error: failure.failureMsg.toString()),
        ),
        (success) => emit(const UserSignOutSuccess()),
      );
    });
  }
}
