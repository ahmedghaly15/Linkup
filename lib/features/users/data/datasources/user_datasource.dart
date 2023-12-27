import 'package:cloud_firestore/cloud_firestore.dart';

abstract class UserDataSource {
  Future<QuerySnapshot<Map<String, dynamic>>> getAllUsers();

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserData();

  Future<QuerySnapshot<Map<String, dynamic>>> getUserPosts();
}
