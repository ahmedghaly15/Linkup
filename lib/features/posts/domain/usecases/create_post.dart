import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:social_app/core/errors/failure.dart';
import 'package:social_app/core/usecases/base_usecase.dart';
import 'package:social_app/features/posts/data/models/post_model.dart';
import 'package:social_app/features/posts/domain/repositories/posts_repo.dart';

class CreatePostUseCase
    implements
        BaseUseCases<DocumentReference<Map<String, dynamic>>, PostModel> {
  final PostsRepo postsRepo;

  const CreatePostUseCase({required this.postsRepo});

  @override
  Future<Either<Failure, DocumentReference<Map<String, dynamic>>>> call(
    PostModel params,
  ) async {
    return await postsRepo.createPost(post: params);
  }
}
