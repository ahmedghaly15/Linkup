import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/core/models/user_model.dart';
import 'package:social_app/core/utils/app_strings.dart';
import 'package:social_app/features/following_and_followers/data/datasources/following_and_followers_datasource.dart';
import 'package:social_app/service_locator.dart';

class FollowingAndFollowersDataSourceImpl
    implements FollowingAndFollowersDataSource {
  @override
  Future<QuerySnapshot<Map<String, dynamic>>> getFollowers() async {
    return await getIt
        .get<FirebaseFirestore>()
        .collection(AppStrings.users)
        .doc(Helper.uId)
        .collection(AppStrings.followers)
        .get();
  }

  @override
  Future<QuerySnapshot<Map<String, dynamic>>> getFollowing() async {
    return await getIt
        .get<FirebaseFirestore>()
        .collection(AppStrings.users)
        .doc(Helper.uId)
        .collection(AppStrings.following)
        .get();
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
  Stream<bool> userIsInFollowing({required String uId}) {
    return getIt
        .get<FirebaseFirestore>()
        .collection(AppStrings.users)
        .doc(Helper.uId!)
        .collection(AppStrings.following)
        .snapshots()
        .map((querySnapshot) {
      for (var item in querySnapshot.docs) {
        if (item.data()['uId'] == uId) {
          return true;
        }
      }
      return false;
    });
  }

  @override
  Stream<bool> userIsInFollowers({required String uId}) {
    return getIt
        .get<FirebaseFirestore>()
        .collection(AppStrings.users)
        .doc(Helper.uId!)
        .collection(AppStrings.followers)
        .snapshots()
        .map((querySnapshot) {
      for (var item in querySnapshot.docs) {
        if (item.data()['uId'] == uId) {
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
