import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/features/comments/domain/entities/type_new_comment_params.dart';
import 'package:social_app/features/comments/domain/usecases/type_new_comment.dart';
import 'package:social_app/features/posts/presentation/cubits/posts_cubit.dart';

part 'comments_state.dart';

class CommentsCubit extends Cubit<CommentsState> {
  final TypeNewCommentUseCase typeNewCommentUseCase;

  CommentsCubit({
    required this.typeNewCommentUseCase,
  }) : super(const CommentsInitial());

  void typeNewComment({
    required TypeNewCommentParams params,
    required BuildContext context,
  }) {
    emit(const TypeNewCommentLoading());

    typeNewCommentUseCase(params).then((value) {
      value.fold(
        (failure) =>
            emit(TypeNewCommentError(error: failure.failureMsg.toString())),
        (success) {
          BlocProvider.of<PostsCubit>(context).getPosts();
          emit(const TypeNewCommentSuccess());
        },
      );
    });
  }
}
