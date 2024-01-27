import 'package:cloud_firestore/cloud_firestore.dart';

abstract class UserDataSource {
  Stream<QuerySnapshot<Map<String, dynamic>>> getPosts();

  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserData();

  Future<void> deleteAccount();

  Future<void> signOut();
}
