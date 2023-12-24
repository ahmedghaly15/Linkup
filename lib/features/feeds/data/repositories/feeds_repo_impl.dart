import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/core/errors/failure.dart';
import 'package:social_app/features/feeds/data/models/post_model.dart';
import 'package:social_app/core/utils/functions/execute_and_handle_errors.dart';
import 'package:social_app/features/feeds/data/datasources/feeds_datasource.dart';
import 'package:social_app/features/feeds/domain/repositories/feeds_repo.dart';

class FeedsRepoImpl implements FeedsRepo {
  final FeedsDataSource feedsDataSource;

  const FeedsRepoImpl({required this.feedsDataSource});

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getPosts() {
    return feedsDataSource.getPosts();
  }

  @override
  Future<Either<Failure, DocumentReference<Map<String, dynamic>>>> createPost({
    required PostModel post,
  }) {
    return executeAndHandleErrors<DocumentReference<Map<String, dynamic>>>(
      function: () => feedsDataSource.createPost(post: post),
    );
  }

  @override
  Future<Either<Failure, void>> deletePost({required String postId}) {
    return executeAndHandleErrors<void>(
      function: () => feedsDataSource.deletePost(postId: postId),
    );
  }

  @override
  Future<Either<Failure, XFile?>> getPostImage({required ImageSource source}) {
    return executeAndHandleErrors<XFile?>(
      function: () => feedsDataSource.getPostImage(source: source),
    );
  }

  @override
  Future<Either<Failure, TaskSnapshot>> uploadPostImage({File? postImage}) {
    return executeAndHandleErrors<TaskSnapshot>(
      function: () => feedsDataSource.uploadPostImage(postImage: postImage),
    );
  }
}
