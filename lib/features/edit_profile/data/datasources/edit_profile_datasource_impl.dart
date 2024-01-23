import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/core/models/user_model.dart';
import 'package:social_app/core/utils/app_strings.dart';
import 'package:social_app/features/edit_profile/data/datasources/edit_profile_datasource.dart';
import 'package:social_app/service_locator.dart';

class EditProfileDataSourceImpl implements EditProfileDataSource {
  @override
  Future<void> updateUser({required UserModel userModel}) async {
    return await getIt
        .get<FirebaseFirestore>()
        .collection('users')
        .doc(Helper.currentUser!.uId)
        .update(userModel.toJson());
  }

  @override
  Future<XFile?> getImage({required ImageSource source}) async {
    return await getIt.get<ImagePicker>().pickImage(source: source);
  }

  @override
  Future<TaskSnapshot> uploadImage({File? image}) async {
    return await firebase_storage.FirebaseStorage.instance
        .ref()
        .child(
          '${AppStrings.users}/${Uri.file(image!.path).pathSegments.last}',
        )
        .putFile(image);
  }

  @override
  Future<QuerySnapshot<Map<String, dynamic>>> updateUserPosts() async {
    return await getIt
        .get<FirebaseFirestore>()
        .collection(AppStrings.posts)
        .get();
  }
}
