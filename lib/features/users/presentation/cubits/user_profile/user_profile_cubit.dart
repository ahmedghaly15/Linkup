import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/entities/no_params.dart';
import 'package:social_app/features/posts/data/models/post_model.dart';
import 'package:social_app/features/users/domain/usecases/get_posts.dart';

part 'user_profile_state.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
  final GetPostsUseCase getPostsUseCase;

  UserProfileCubit({
    required this.getPostsUseCase,
  }) : super(const UserProfileInitial());

  List<PostModel> userPosts = <PostModel>[];

  Future<void> getUserPosts({required String uId}) async {
    emit(const GetUserPostsLoading());

    getPostsUseCase(const NoParams()).listen((result) {
      userPosts.clear();

      for (var item in result.docs) {
        if (item.data()['user']['uId'] == uId) {
          userPosts.add(PostModel.fromJson(item.data()));
        }
      }

      emit(GetUserPostsSuccess(userPosts: userPosts));
    }).onError((error) {
      emit(GetUserPostsError(error: error.toString()));
    });
  }
}
