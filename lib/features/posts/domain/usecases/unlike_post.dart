import 'package:dartz/dartz.dart';
import 'package:social_app/core/errors/failure.dart';
import 'package:social_app/core/usecases/base_usecase.dart';
import 'package:social_app/features/posts/domain/repositories/posts_repo.dart';

class UnLikePostUseCase implements BaseUseCases<void, String> {
  final PostsRepo postsRepo;

  const UnLikePostUseCase({required this.postsRepo});

  @override
  Future<Either<Failure, void>> call(String params) async {
    return await postsRepo.unLikePost(postId: params);
  }
}
