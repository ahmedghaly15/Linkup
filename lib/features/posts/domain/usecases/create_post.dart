import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:social_app/core/errors/failure.dart';
import 'package:social_app/core/usecases/base_usecase.dart';
import 'package:social_app/features/posts/domain/entities/create_post_params.dart';
import 'package:social_app/features/posts/domain/repositories/posts_repo.dart';

class CreatePostUseCase
    implements
        BaseUseCases<DocumentReference<Map<String, dynamic>>,
            CreatePostParams> {
  final PostsRepo postsRepo;

  const CreatePostUseCase({required this.postsRepo});

  @override
  Future<Either<Failure, DocumentReference<Map<String, dynamic>>>> call(
    CreatePostParams params,
  ) async {
    return await postsRepo.createPost(createPostParams: params);
  }
}
