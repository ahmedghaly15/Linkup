import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/features/comments/data/models/comment_model.dart';
import 'package:social_app/features/comments/domain/entities/type_new_comment_params.dart';
import 'package:social_app/features/comments/domain/usecases/get_comment_image.dart';
import 'package:social_app/features/comments/domain/usecases/get_comments.dart';
import 'package:social_app/features/comments/domain/usecases/type_new_comment.dart';
import 'package:social_app/features/comments/domain/usecases/upload_comment_image.dart';
import 'package:social_app/features/posts/presentation/cubits/posts_cubit.dart';

part 'comments_state.dart';

class CommentsCubit extends Cubit<CommentsState> {
  final TypeNewCommentUseCase typeNewCommentUseCase;
  final GetCommentsUseCase getCommentsUseCase;
  final GetCommentImageUseCase getCommentImageUseCase;
  final UploadCommentImageUseCase uploadCommentImageUseCase;

  CommentsCubit({
    required this.typeNewCommentUseCase,
    required this.getCommentsUseCase,
    required this.getCommentImageUseCase,
    required this.uploadCommentImageUseCase,
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

  File? commentImage;

  void getCommentImage({required ImageSource source}) {
    getCommentImageUseCase(source).then((value) {
      value.fold(
        (failure) => emit(
          CommentImagePickedError(error: failure.failureMsg.toString()),
        ),
        (result) {
          if (result != null) {
            commentImage = File(result.path);
          }

          emit(CommentImagePickedSuccess(commentImage: commentImage!));
        },
      );
    });
  }

  void uploadCommentImage({
    required TypeNewCommentParams params,
    required BuildContext context,
  }) {
    emit(const UploadCommentImageLoading());

    uploadCommentImageUseCase(commentImage).then(
      (value) {
        value.fold(
          (failure) => emit(
            UploadCommentImageError(error: failure.failureMsg.toString()),
          ),
          (result) {
            result.ref.getDownloadURL().then((value) {
              typeNewComment(
                params: TypeNewCommentParams(
                  commentImage: {'image': value, 'height': 200},
                  postId: params.postId,
                  time: params.time,
                  date: params.date,
                  commentText: params.commentText,
                ),
                context: context,
              );

              emit(UploadCommentImageSuccess(imageUrl: value));
            }).catchError((error) {
              emit(UploadCommentImageError(error: error.toString()));
            });
          },
        );
      },
    );
  }

  void removeCommentImage() {
    commentImage = null;

    emit(const CommentImageRemovedSuccess());
  }

  List<CommentModel> comments = <CommentModel>[];

  void clearComments() {
    comments.clear();

    emit(ClearCommentsList(comments: comments));
  }

  void getComments({required String postId}) {
    getCommentsUseCase(postId).listen((event) {
      clearComments();

      for (var element in event.docs) {
        comments.add(CommentModel.fromJson(element.data()));
      }

      emit(GetCommentsSuccess(comments: comments));
    }).onError((error) {
      emit(GetCommentsError(error: error.toString()));
    });
  }
}
