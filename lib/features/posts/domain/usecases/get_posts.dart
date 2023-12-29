import 'package:dartz/dartz.dart';
import 'package:social_app/core/entities/no_params.dart';
import 'package:social_app/core/errors/failure.dart';
import 'package:social_app/core/usecases/base_usecase.dart';
import 'package:social_app/features/posts/data/models/post_model.dart';
import 'package:social_app/features/posts/domain/repositories/posts_repo.dart';

class GetPostsUseCase implements BaseUseCases<List<PostModel>, NoParams> {
  final PostsRepo postsRepo;

  const GetPostsUseCase({required this.postsRepo});

  @override
  Future<Either<Failure, List<PostModel>>> call(
    NoParams params,
  ) async {
    return postsRepo.getPosts();
  }
}
