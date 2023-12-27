import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/core/utils/app_strings.dart';
import 'package:social_app/features/users/data/datasources/user_datasource.dart';
import 'package:social_app/service_locator.dart';

class UserDataSourceImpl implements UserDataSource {
  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserData() async {
    return await getIt
        .get<FirebaseFirestore>()
        .collection(AppStrings.users)
        .doc(Helper.uId)
        .get();
  }

  @override
  Future<QuerySnapshot<Map<String, dynamic>>> getAllUsers() async {
    return await getIt
        .get<FirebaseFirestore>()
        .collection(AppStrings.users)
        .get();
  }
}
