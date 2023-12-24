import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/features/feeds/data/models/post_model.dart';

abstract class FeedsDataSource {
  Stream<QuerySnapshot<Map<String, dynamic>>> getPosts();

  Future<DocumentReference<Map<String, dynamic>>> createPost({
    required PostModel post,
  });

  Future<void> deletePost({required String postId});

  Future<XFile?> getPostImage({required ImageSource source});

  Future<TaskSnapshot> uploadPostImage({
    File? postImage,
  });
}
