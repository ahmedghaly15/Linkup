import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_app/core/models/user_model.dart';

abstract class FollowingAndFollowersDataSource {
  Future<QuerySnapshot<Map<String, dynamic>>> getFollowers();

  Future<QuerySnapshot<Map<String, dynamic>>> getFollowing();

  Future<void> follow({required UserModel user});

  Future<void> unfollow({required UserModel user});

  Stream<bool> userIsInFollowing({required String uId});

  Stream<bool> userIsInFollowers({required String uId});
}
