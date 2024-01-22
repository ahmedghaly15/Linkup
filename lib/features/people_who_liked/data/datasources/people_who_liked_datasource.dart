import 'package:cloud_firestore/cloud_firestore.dart';

abstract class PeopleWhoLikedDataSource {
  Stream<QuerySnapshot<Map<String, dynamic>>> peopleWhoLiked({
    required String postId,
  });
}
