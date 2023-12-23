import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_app/core/entities/no_params.dart';
import 'package:social_app/core/usecases/regular_usecase.dart';
import 'package:social_app/features/feeds/domain/repositories/feeds_repo.dart';

class GetPostsUseCase
    implements
        RegularUseCases<Stream<QuerySnapshot<Map<String, dynamic>>>, NoParams> {
  final FeedsRepo feedsRepo;

  const GetPostsUseCase({required this.feedsRepo});

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> call(NoParams params) {
    return feedsRepo.getPosts();
  }
}
