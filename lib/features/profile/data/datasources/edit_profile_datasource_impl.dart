import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/core/models/user_model.dart';
import 'package:social_app/features/profile/data/datasources/edit_profile_datasource.dart';
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
}
