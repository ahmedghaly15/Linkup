import 'package:dartz/dartz.dart';
import 'package:social_app/core/errors/failure.dart';
import 'package:social_app/core/usecases/base_usecase.dart';
import 'package:social_app/features/posts/domain/entities/like_post_params.dart';
import 'package:social_app/features/posts/domain/repositories/posts_repo.dart';

class LikePostUseCase implements BaseUseCases<void, LikePostParams> {
  final PostsRepo postsRepo;

  const LikePostUseCase({required this.postsRepo});

  @override
  Future<Either<Failure, void>> call(LikePostParams params) async {
    return await postsRepo.likePost(likePostParams: params);
  }
}
