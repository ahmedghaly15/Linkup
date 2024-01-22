import 'package:cloud_firestore/cloud_firestore.dart';

abstract class PeopleWhoLikedRepo {
  Stream<QuerySnapshot<Map<String, dynamic>>> peopleWhoLiked({
    required String postId,
  });
}
