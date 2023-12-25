import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_app/features/comments/domain/entities/type_new_comment_params.dart';

abstract class CommentsDataSource {
  Future<DocumentReference<Map<String, dynamic>>> typeNewComment({
    required TypeNewCommentParams typeCommentParams,
  });
}
