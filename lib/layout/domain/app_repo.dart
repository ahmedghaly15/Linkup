import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/models/message_model.dart';
import '../../core/models/post_model.dart';
import '../../core/models/user_model.dart';
import '/core/models/comment_model.dart';
import '/core/models/like_model.dart';

abstract class AppRepo {
  // =============== Users Logic ===============
  Future<QuerySnapshot<Map<String, dynamic>>> getAllUsers();

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserData(String? uId);

  Future<void> updateUser({required UserModel userModel});

  // =============== ProfileImage Logic ===============
  Future<XFile?> getProfileImage({required ImageSource source});

  Future<TaskSnapshot> uploadProfileImage({
    File? profileImage,
  });

  // =============== CoverImage Logic ===============
  Future<XFile?> getCoverImage({required ImageSource source});

  Future<TaskSnapshot> uploadCoverImage({
    File? coverImage,
  });

  // =============== Posts Logic ===============
  Future<DocumentReference<Map<String, dynamic>>> createPost({
    required PostModel postModel,
  });

  Future<void> deletePost({required String postId});

  Future<XFile?> getPostImage({required ImageSource source});

  Future<TaskSnapshot> uploadPostImage({
    File? postImage,
  });

  Stream<QuerySnapshot<Map<String, dynamic>>> getPosts();

  Future<void> likePost({
    required LikesModel likesModel,
    required String postId,
  });

  Future<DocumentSnapshot<Map<String, dynamic>>> likeByMe({
    required String postId,
  });

  // =============== Comments Logic ===============
  Future<DocumentReference<Map<String, dynamic>>> typeNewComment({
    required CommentModel commentModel,
    required String postId,
  });

  Future<XFile?> getCommentImage({required ImageSource source});

  Future<TaskSnapshot> uploadCommentImage({
    File? commentImage,
  });

  Stream<QuerySnapshot<Map<String, dynamic>>> getComments({
    required String postId,
  });

  // =============== Chat & Messages Logic ===============
  Future<DocumentReference<Map<String, dynamic>>> settingUpSenderChat({
    required String receiverId,
    required MessageModel messageModel,
  });
  Future<DocumentReference<Map<String, dynamic>>> settingUpReceiverChat({
    required String receiverId,
    required MessageModel messageModel,
  });

  Future<XFile?> getMessageImage({required ImageSource source});

  Future<TaskSnapshot> uploadMessageImage({
    File? messageImage,
  });

  Stream<QuerySnapshot<Map<String, dynamic>>> getMessages({
    required String receiverId,
  });
}
