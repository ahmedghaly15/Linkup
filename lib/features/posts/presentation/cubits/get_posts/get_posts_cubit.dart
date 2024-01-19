import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/entities/no_params.dart';
import 'package:social_app/features/posts/data/models/post_model.dart';
import 'package:social_app/features/posts/domain/usecases/get_posts.dart';

part 'get_posts_state.dart';

class GetPostsCubit extends Cubit<GetPostsState> {
  final GetPostsUseCase getPostsUseCase;

  GetPostsCubit({required this.getPostsUseCase})
      : super(const GetPostsInitial());

  List<PostModel> posts = <PostModel>[];

  Future<void> getPosts() async {
    emit(const GetPostsLoading());

    _executeGetPostsUseCase();
  }

  void getPostsWithoutLoading() {
    _executeGetPostsUseCase();
  }

  void _executeGetPostsUseCase() {
    getPostsUseCase(const NoParams()).then((value) {
      value.fold(
        (failure) => emit(GetPostsError(error: failure.failureMsg.toString())),
        (result) {
          posts = result;
          emit(GetPostsSuccess(posts: posts));
        },
      );
    });
  }
}
