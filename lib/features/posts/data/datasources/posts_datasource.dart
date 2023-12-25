import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/features/posts/data/models/post_model.dart';
import 'package:social_app/features/posts/domain/entities/create_post_params.dart';

abstract class PostsDataSource {
  Future<QuerySnapshot<Map<String, dynamic>>> getPosts();

  Future<DocumentReference<Map<String, dynamic>>> createPost({
    required CreatePostParams createPostParams,
  });

  Future<void> deletePost({required String postId});

  Future<XFile?> getPostImage({required ImageSource source});

  Future<TaskSnapshot> uploadPostImage({
    File? postImage,
  });

  Future<void> likePost({required String postId});

  Future<void> unLikePost({required String postId});

  Future<List<PostModel>> likedPostsByMe();
}
