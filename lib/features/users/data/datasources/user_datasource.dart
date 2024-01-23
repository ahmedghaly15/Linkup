import 'package:cloud_firestore/cloud_firestore.dart';

abstract class UserDataSource {
  Stream<QuerySnapshot<Map<String, dynamic>>> getPosts();

  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserData();

  Future<QuerySnapshot<Map<String, dynamic>>> getUserPosts();

  Future<void> signOut();
}
