import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/core/errors/failure.dart';
import 'package:social_app/features/feeds/data/models/post_model.dart';

abstract class FeedsRepo {
  Stream<QuerySnapshot<Map<String, dynamic>>> getPosts();

  Future<Either<Failure, DocumentReference<Map<String, dynamic>>>> createPost({
    required PostModel post,
  });

  Future<Either<Failure, void>> deletePost({required String postId});

  Future<Either<Failure, XFile?>> getPostImage({required ImageSource source});

  Future<Either<Failure, TaskSnapshot>> uploadPostImage({
    File? postImage,
  });
}
