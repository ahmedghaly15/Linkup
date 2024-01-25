import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/core/errors/failure.dart';
import 'package:social_app/core/utils/functions/execute_and_handle_errors.dart';
import 'package:social_app/features/comments/data/datasources/comments_datasource.dart';
import 'package:social_app/features/comments/domain/entities/type_new_comment_params.dart';
import 'package:social_app/features/comments/domain/repositories/comments_repo.dart';

class CommentsRepoImpl implements CommentsRepo {
  final CommentsDataSource commentsDataSource;

  const CommentsRepoImpl({required this.commentsDataSource});

  @override
  Future<Either<Failure, void>> typeNewComment({
    required TypeNewCommentParams typeCommentParams,
  }) {
    return executeAndHandleErrors<void>(
      function: () => commentsDataSource.typeNewComment(
        typeCommentParams: typeCommentParams,
      ),
    );
  }

  @override
  Future<Either<Failure, XFile?>> getCommentImage({
    required ImageSource source,
  }) {
    return executeAndHandleErrors<XFile?>(
      function: () => commentsDataSource.getCommentImage(source: source),
    );
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getComments({
    required String postId,
  }) {
    return commentsDataSource.getComments(postId: postId);
  }

  @override
  Future<Either<Failure, TaskSnapshot>> uploadCommentImage({
    File? commentImage,
  }) {
    return executeAndHandleErrors<TaskSnapshot>(
      function: () => commentsDataSource.uploadCommentImage(
        commentImage: commentImage,
      ),
    );
  }
}
