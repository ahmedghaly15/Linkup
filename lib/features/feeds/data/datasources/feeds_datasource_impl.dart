import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:social_app/features/feeds/data/models/post_model.dart';
import 'package:social_app/features/feeds/data/datasources/feeds_datasource.dart';

class FeedsDataSourceImpl implements FeedsDataSource {
  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getPosts() {
    return FirebaseFirestore.instance
        .collection('posts')
        .orderBy(
          'dateTime',
          descending: true,
        )
        .snapshots();
  }

  @override
  Future<DocumentReference<Map<String, dynamic>>> createPost({
    required PostModel post,
  }) async {
    return await FirebaseFirestore.instance
        .collection('posts')
        .add(post.toJson());
  }

  @override
  Future<void> deletePost({required String postId}) async {
    await FirebaseFirestore.instance.collection('posts').doc(postId).delete();
  }

  @override
  Future<XFile?> getPostImage({required ImageSource source}) async {
    return await ImagePicker().pickImage(source: source);
  }

  @override
  Future<TaskSnapshot> uploadPostImage({
    File? postImage,
  }) async {
    return await firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage);
  }
}
