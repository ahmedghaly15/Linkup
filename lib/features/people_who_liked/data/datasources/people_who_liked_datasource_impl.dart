import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_app/core/utils/app_strings.dart';
import 'package:social_app/features/people_who_liked/data/datasources/people_who_liked_datasource.dart';
import 'package:social_app/service_locator.dart';

class PeopleWhoLikedDataSourceImpl implements PeopleWhoLikedDataSource {
  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> peopleWhoLiked({
    required String postId,
  }) {
    return getIt
        .get<FirebaseFirestore>()
        .collection(AppStrings.posts)
        .doc(postId)
        .collection(AppStrings.likes)
        .snapshots();
  }
}
