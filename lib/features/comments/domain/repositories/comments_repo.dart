import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:social_app/core/errors/failure.dart';
import 'package:social_app/features/comments/domain/entities/type_new_comment_params.dart';

abstract class CommentsRepo {
  Future<Either<Failure, DocumentReference<Map<String, dynamic>>>>
      typeNewComment({
    required TypeNewCommentParams typeCommentParams,
  });
}
