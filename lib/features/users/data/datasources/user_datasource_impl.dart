import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_app/core/helpers/cache_helper.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/core/models/user_model.dart';
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
  Future<QuerySnapshot<Map<String, dynamic>>> getFollowingList() async {
    return await getIt
        .get<FirebaseFirestore>()
        .collection(AppStrings.users)
        .doc(Helper.uId)
        .collection(AppStrings.following)
        .get();
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

  @override
  Future<void> follow({required UserModel user}) async {
    _addUserToFollowers(user).then((value) {
      _addUserToFollowing(user);
    });
  }

  @override
  Future<void> unfollow({required UserModel user}) async {
    _removeUserFromFollowers(user).then((value) {
      _removeUserFromFollowing(user);
    });
  }

  @override
  Stream<bool> userIsFollowed({required UserModel user}) {
    return getIt
        .get<FirebaseFirestore>()
        .collection(AppStrings.users)
        .doc(user.uId)
        .collection(AppStrings.followers)
        .snapshots()
        .map((querySnapshot) {
      for (var item in querySnapshot.docs) {
        if (item.data()['uId'] == Helper.currentUser!.uId) {
          return true;
        }
      }
      return false;
    });
  }

  Future<void> _addUserToFollowers(
    UserModel user,
  ) async {
    return await getIt
        .get<FirebaseFirestore>()
        .collection(AppStrings.users)
        .doc(user.uId)
        .collection(AppStrings.followers)
        .doc(Helper.currentUser!.uId)
        .set(Helper.currentUser!.toJson());
  }

  Future<void> _addUserToFollowing(
    UserModel user,
  ) async {
    return await getIt
        .get<FirebaseFirestore>()
        .collection(AppStrings.users)
        .doc(Helper.currentUser!.uId)
        .collection(AppStrings.following)
        .doc(user.uId)
        .set(user.toJson());
  }

  Future<void> _removeUserFromFollowing(UserModel user) async {
    return await getIt
        .get<FirebaseFirestore>()
        .collection(AppStrings.users)
        .doc(Helper.currentUser!.uId!)
        .collection(AppStrings.following)
        .doc(user.uId)
        .delete();
  }

  Future<void> _removeUserFromFollowers(UserModel user) async {
    return await getIt
        .get<FirebaseFirestore>()
        .collection(AppStrings.users)
        .doc(user.uId)
        .collection(AppStrings.followers)
        .doc(Helper.currentUser!.uId!)
        .delete();
  }
}
