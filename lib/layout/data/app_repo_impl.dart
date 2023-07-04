import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/models/message_model.dart';
import '../../core/utils/helper.dart';
import '../domain/app_repo.dart';
import '/core/models/comment_model.dart';
import '/core/models/like_model.dart';
import '/core/models/post_model.dart';
import '/core/models/user_model.dart';

class AppRepoImpl extends AppRepo {
  // =============== Users Logic ===============
  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserData(
    String? uId,
  ) async {
    return await FirebaseFirestore.instance.collection('users').doc(uId).get();
  }

  @override
  Future<QuerySnapshot<Map<String, dynamic>>> getAllUsers() async {
    return await FirebaseFirestore.instance.collection('users').get();
  }

  @override
  Future<void> updateUser({required UserModel userModel}) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(Helper.model!.uId)
        .update(userModel.toJson());
  }

  // =============== ProfileImage Logic ===============
  @override
  Future<XFile?> getProfileImage({required ImageSource source}) async {
    return await ImagePicker().pickImage(source: source);
  }

  @override
  Future<TaskSnapshot> uploadProfileImage({
    File? profileImage,
  }) async {
    return await firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage);
  }

  // =============== CoverImage Logic ===============
  @override
  Future<XFile?> getCoverImage({required ImageSource source}) async {
    return await ImagePicker().pickImage(source: source);
  }

  @override
  Future<firebase_storage.TaskSnapshot> uploadCoverImage(
      {File? coverImage}) async {
    return await firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage);
  }

  // =============== Posts Logic ===============
  @override
  Future<DocumentReference<Map<String, dynamic>>> createPost({
    required PostModel postModel,
  }) async {
    return await FirebaseFirestore.instance
        .collection('posts')
        .add(postModel.toJson());
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
  Future<void> likePost({
    required LikesModel likesModel,
    required String postId,
  }) async {
    return await FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(Helper.model!.uId)
        .set(likesModel.toJson());
  }

  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> likeByMe({
    required String postId,
  }) async {
    return await FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .get();
  }

  // =============== Comments Logic ===============
  @override
  Future<DocumentReference<Map<String, dynamic>>> typeNewComment({
    required CommentModel commentModel,
    required String postId,
  }) async {
    return await FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .add(commentModel.toJson());
  }

  @override
  Future<XFile?> getCommentImage({required ImageSource source}) async {
    return await ImagePicker().pickImage(source: source);
  }

  @override
  Future<TaskSnapshot> uploadCommentImage({
    File? commentImage,
  }) async {
    return await firebase_storage.FirebaseStorage.instance
        .ref()
        .child('comments/${Uri.file(commentImage!.path).pathSegments.last}')
        .putFile(commentImage);
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getComments({
    required String postId,
  }) {
    return FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .orderBy(
          'dateTime',
          descending: false,
        )
        .snapshots();
  }

  // =============== Chat & Messages Logic ===============
  @override
  Future<XFile?> getMessageImage({required ImageSource source}) async {
    return await ImagePicker().pickImage(source: source);
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getMessages({
    required String receiverId,
  }) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(Helper.model!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy(
          'dateTime',
          descending: true,
        )
        .snapshots();
  }

  @override
  Future<DocumentReference<Map<String, dynamic>>> settingUpSenderChat({
    required String receiverId,
    required MessageModel messageModel,
  }) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(Helper.model!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(messageModel.toJson());
  }

  @override
  Future<DocumentReference<Map<String, dynamic>>> settingUpReceiverChat({
    required String receiverId,
    required MessageModel messageModel,
  }) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(Helper.model!.uId)
        .collection('messages')
        .add(messageModel.toJson());
  }

  @override
  Future<TaskSnapshot> uploadMessageImage({
    File? messageImage,
  }) async {
    return await firebase_storage.FirebaseStorage.instance
        .ref()
        .child('messages/${Uri.file(messageImage!.path).pathSegments.last}')
        .putFile(messageImage);
  }
}
