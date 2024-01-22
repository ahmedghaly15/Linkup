import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_app/features/people_who_liked/data/datasources/people_who_liked_datasource.dart';
import 'package:social_app/features/people_who_liked/domain/repositories/people_who_liked_repo.dart';

class PeopleWhoLikedRepoImpl implements PeopleWhoLikedRepo {
  final PeopleWhoLikedDataSource peopleWhoLikedDataSource;

  const PeopleWhoLikedRepoImpl({required this.peopleWhoLikedDataSource});

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> peopleWhoLiked({
    required String postId,
  }) {
    return peopleWhoLikedDataSource.peopleWhoLiked(postId: postId);
  }
}
