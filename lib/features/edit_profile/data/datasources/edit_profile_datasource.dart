import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/core/models/user_model.dart';

abstract class EditProfileDataSource {
  Future<void> updateUser({required UserModel userModel});

  Future<XFile?> getImage({required ImageSource source});

  Future<TaskSnapshot> uploadImage({File? image});

  Future<QuerySnapshot<Map<String, dynamic>>> updateUserPosts();

  Future<QuerySnapshot<Map<String, dynamic>>>
      updateUserInOtherFollowingAndFollowers();
}
