import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/core/utils/app_strings.dart';
import 'package:social_app/features/comments/data/datasources/comments_datasource.dart';
import 'package:social_app/features/comments/data/models/comment_model.dart';
import 'package:social_app/features/comments/domain/entities/type_new_comment_params.dart';
import 'package:social_app/service_locator.dart';

class CommentsDataSourceImpl implements CommentsDataSource {
  @override
  Future<DocumentReference<Map<String, dynamic>>> typeNewComment({
    required TypeNewCommentParams typeCommentParams,
  }) async {
    CommentModel commentModel = CommentModel(
      name: Helper.currentUser!.name,
      image: Helper.currentUser!.image,
      uId: Helper.currentUser!.uId,
      commentImage: typeCommentParams.commentImage ?? {},
      commentText: typeCommentParams.commentText ?? '',
      time: typeCommentParams.time,
      date: typeCommentParams.date,
      dateTime: Timestamp.now(),
    );

    return await getIt
        .get<FirebaseFirestore>()
        .collection(AppStrings.posts)
        .doc(typeCommentParams.postId)
        .collection(AppStrings.comments)
        .add(commentModel.toJson());
  }
}
