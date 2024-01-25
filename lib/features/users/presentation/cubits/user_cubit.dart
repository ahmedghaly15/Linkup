import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/entities/no_params.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/core/models/user_model.dart';
import 'package:social_app/features/posts/data/models/post_model.dart';
import 'package:social_app/features/users/domain/usecases/get_posts.dart';
import 'package:social_app/features/users/domain/usecases/get_user_data.dart';
import 'package:social_app/features/users/domain/usecases/sign_out.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final GetUserDataUseCase getUserDataUseCase;
  final GetPostsUseCase getPostsUseCase;
  final SignOutUseCase signOutUseCase;

  UserCubit({
    required this.getUserDataUseCase,
    required this.getPostsUseCase,
    required this.signOutUseCase,
  }) : super(const UserInitial());

  Future<void> getUserData() async {
    emit(const GetUserDataLoading());

    getUserDataUseCase(const NoParams()).listen((event) {
      Helper.currentUser = UserModel.fromJson(event.data()!);
      emit(GetUserDataSuccess(user: Helper.currentUser!));
    }).onError((error) {
      emit(GetUserDataError(error: error.toString()));
    });
  }

  List<PostModel> posts = <PostModel>[];

  Future<void> getPosts() async {
    emit(const GetPostsLoading());

    getPostsUseCase(const NoParams()).listen((event) {
      posts.clear();

      for (var item in event.docs) {
        posts.add(PostModel.fromJson(item.data()));
      }

      emit(GetPostsSuccess(posts: posts));
    }).onError((error) {
      emit(GetPostsError(error: error.toString()));
    });
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
