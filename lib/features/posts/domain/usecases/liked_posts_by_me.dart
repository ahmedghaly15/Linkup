import 'package:social_app/core/usecases/regular_usecase.dart';
import 'package:social_app/features/posts/domain/repositories/posts_repo.dart';

class LikedPostsByMeUseCase implements RegularUseCases<Stream<bool>, String> {
  final PostsRepo postsRepo;

  const LikedPostsByMeUseCase({required this.postsRepo});

  @override
  Stream<bool> call(
    String params,
  ) {
    return postsRepo.likedPostsByMe(postId: params);
  }
}
