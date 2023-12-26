import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/core/errors/failure.dart';
import 'package:social_app/features/posts/data/models/post_model.dart';
import 'package:social_app/features/posts/domain/entities/create_post_params.dart';

abstract class PostsRepo {
  Future<Either<Failure, QuerySnapshot<Map<String, dynamic>>>> getPosts();

  Future<Either<Failure, DocumentReference<Map<String, dynamic>>>> createPost({
    required CreatePostParams createPostParams,
  });

  Future<Either<Failure, void>> deletePost({required String postId});

  Future<Either<Failure, XFile?>> getPostImage({required ImageSource source});

  Future<Either<Failure, TaskSnapshot>> uploadPostImage({
    File? postImage,
  });

  Future<Either<Failure, void>> likePost({required String postId});

  Future<Either<Failure, void>> unLikePost({required String postId});

  Future<Either<Failure, List<PostModel>>> likedPostsByMe();

  Stream<QuerySnapshot<Map<String, dynamic>>> peopleLikeThePost({
    required String postId,
  });
}
