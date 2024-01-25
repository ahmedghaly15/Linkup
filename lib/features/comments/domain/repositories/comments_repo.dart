import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/core/errors/failure.dart';
import 'package:social_app/features/comments/domain/entities/type_new_comment_params.dart';

abstract class CommentsRepo {
  Future<Either<Failure, void>> typeNewComment({
    required TypeNewCommentParams typeCommentParams,
  });

  Future<Either<Failure, XFile?>> getCommentImage({
    required ImageSource source,
  });

  Future<Either<Failure, TaskSnapshot>> uploadCommentImage({
    File? commentImage,
  });

  Stream<QuerySnapshot<Map<String, dynamic>>> getComments({
    required String postId,
  });
}
