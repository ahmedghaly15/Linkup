import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:social_app/core/errors/failure.dart';
import 'package:social_app/core/utils/functions/execute_and_handle_errors.dart';
import 'package:social_app/features/comments/data/datasources/comments_datasource.dart';
import 'package:social_app/features/comments/domain/entities/type_new_comment_params.dart';
import 'package:social_app/features/comments/domain/repositories/comments_repo.dart';

class CommentsRepoImpl implements CommentsRepo {
  final CommentsDataSource commentsDataSource;

  const CommentsRepoImpl({required this.commentsDataSource});

  @override
  Future<Either<Failure, DocumentReference<Map<String, dynamic>>>>
      typeNewComment({
    required TypeNewCommentParams typeCommentParams,
  }) {
    return executeAndHandleErrors<DocumentReference<Map<String, dynamic>>>(
      function: () => commentsDataSource.typeNewComment(
        typeCommentParams: typeCommentParams,
      ),
    );
  }
}
