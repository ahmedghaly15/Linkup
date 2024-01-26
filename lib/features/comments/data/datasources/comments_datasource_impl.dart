import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
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
      user: Helper.currentUser,
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

  @override
  Future<XFile?> getCommentImage({required ImageSource source}) async {
    return await getIt.get<ImagePicker>().pickImage(source: source);
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getComments({
    required String postId,
  }) {
    return getIt
        .get<FirebaseFirestore>()
        .collection(AppStrings.posts)
        .doc(postId)
        .collection(AppStrings.comments)
        .orderBy(
          'dateTime',
          descending: false,
        )
        .snapshots();
  }

  @override
  Future<TaskSnapshot> uploadCommentImage({
    File? commentImage,
  }) async {
    return await firebase_storage.FirebaseStorage.instance
        .ref()
        .child(
          '${AppStrings.comments}/${Uri.file(commentImage!.path).pathSegments.last}',
        )
        .putFile(commentImage);
  }
}
