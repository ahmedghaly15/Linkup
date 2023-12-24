import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/core/errors/failure.dart';
import 'package:social_app/core/utils/functions/execute_and_handle_errors.dart';
import 'package:social_app/features/posts/data/datasources/posts_datasource.dart';
import 'package:social_app/features/posts/data/models/post_model.dart';
import 'package:social_app/features/posts/domain/entities/like_post_params.dart';
import 'package:social_app/features/posts/domain/repositories/posts_repo.dart';

class PostsRepoImpl implements PostsRepo {
  final PostsDataSource postsDataSource;

  const PostsRepoImpl({required this.postsDataSource});

  @override
  Future<Either<Failure, QuerySnapshot<Map<String, dynamic>>>> getPosts() {
    return executeAndHandleErrors<QuerySnapshot<Map<String, dynamic>>>(
      function: () => postsDataSource.getPosts(),
    );
  }

  @override
  Future<Either<Failure, DocumentReference<Map<String, dynamic>>>> createPost({
    required PostModel post,
  }) {
    return executeAndHandleErrors<DocumentReference<Map<String, dynamic>>>(
      function: () => postsDataSource.createPost(post: post),
    );
  }

  @override
  Future<Either<Failure, void>> deletePost({required String postId}) {
    return executeAndHandleErrors<void>(
      function: () => postsDataSource.deletePost(postId: postId),
    );
  }

  @override
  Future<Either<Failure, XFile?>> getPostImage({required ImageSource source}) {
    return executeAndHandleErrors<XFile?>(
      function: () => postsDataSource.getPostImage(source: source),
    );
  }

  @override
  Future<Either<Failure, TaskSnapshot>> uploadPostImage({File? postImage}) {
    return executeAndHandleErrors<TaskSnapshot>(
      function: () => postsDataSource.uploadPostImage(postImage: postImage),
    );
  }

  @override
  Future<Either<Failure, void>> likePost({
    required LikePostParams likePostParams,
  }) {
    return executeAndHandleErrors<void>(
      function: () => postsDataSource.likePost(likePostParams: likePostParams),
    );
  }

  @override
  Future<Either<Failure, void>> unLikePost({required String postId}) {
    return executeAndHandleErrors<void>(
      function: () => postsDataSource.unLikePost(postId: postId),
    );
  }

  @override
  Future<Either<Failure, List<PostModel>>> likedPostsByMe() {
    return executeAndHandleErrors<List<PostModel>>(
      function: () => postsDataSource.likedPostsByMe(),
    );
  }
}
