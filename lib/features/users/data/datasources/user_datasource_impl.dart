import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_app/core/helpers/cache_helper.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/core/utils/app_strings.dart';
import 'package:social_app/features/users/data/datasources/user_datasource.dart';
import 'package:social_app/service_locator.dart';

class UserDataSourceImpl implements UserDataSource {
  @override
  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserData() {
    return getIt
        .get<FirebaseFirestore>()
        .collection(AppStrings.users)
        .doc(Helper.uId)
        .snapshots();
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getPosts() {
    return getIt
        .get<FirebaseFirestore>()
        .collection(AppStrings.posts)
        .orderBy(
          'dateTime',
          descending: true,
        )
        .snapshots();
  }

  @override
  Future<QuerySnapshot<Map<String, dynamic>>> getUserPosts() {
    return FirebaseFirestore.instance.collection(AppStrings.posts).get();
  }

  @override
  Future<void> signOut() async {
    await getIt
        .get<CacheHelper>()
        .removeData(key: AppStrings.cachedUserId)
        .then((value) {
      if (value) {
        getIt.get<FirebaseAuth>().signOut();
      }
    });
  }
}
