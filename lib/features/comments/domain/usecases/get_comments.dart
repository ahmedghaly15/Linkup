import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_app/core/usecases/regular_usecase.dart';
import 'package:social_app/features/comments/domain/repositories/comments_repo.dart';

class GetCommentsUseCase
    implements
        RegularUseCases<Stream<QuerySnapshot<Map<String, dynamic>>>, String> {
  final CommentsRepo commentsRepo;

  const GetCommentsUseCase({required this.commentsRepo});

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> call(String params) {
    return commentsRepo.getComments(postId: params);
  }
}
