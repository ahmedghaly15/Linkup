import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_app/core/usecases/regular_usecase.dart';
import 'package:social_app/features/people_who_liked/domain/repositories/people_who_liked_repo.dart';

class PeopleWhoLikedUseCase
    implements
        RegularUseCases<Stream<QuerySnapshot<Map<String, dynamic>>>, String> {
  final PeopleWhoLikedRepo peopleWhoLikedRepo;

  const PeopleWhoLikedUseCase({required this.peopleWhoLikedRepo});

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> call(String params) {
    return peopleWhoLikedRepo.peopleWhoLiked(postId: params);
  }
}
