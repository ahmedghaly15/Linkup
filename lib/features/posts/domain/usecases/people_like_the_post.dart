import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_app/core/usecases/regular_usecase.dart';
import 'package:social_app/features/posts/domain/repositories/posts_repo.dart';

class PeopleLikeThePostUseCase
    implements
        RegularUseCases<Stream<QuerySnapshot<Map<String, dynamic>>>, String> {
  final PostsRepo postsRepo;

  const PeopleLikeThePostUseCase({required this.postsRepo});

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> call(String params) {
    return postsRepo.peopleLikeThePost(postId: params);
  }
}
