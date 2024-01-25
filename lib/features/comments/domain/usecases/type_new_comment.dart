import 'package:dartz/dartz.dart';
import 'package:social_app/core/errors/failure.dart';
import 'package:social_app/core/usecases/base_usecase.dart';
import 'package:social_app/features/comments/domain/entities/type_new_comment_params.dart';
import 'package:social_app/features/comments/domain/repositories/comments_repo.dart';

class TypeNewCommentUseCase
    implements BaseUseCases<void, TypeNewCommentParams> {
  final CommentsRepo commentsRepo;

  const TypeNewCommentUseCase({required this.commentsRepo});

  @override
  Future<Either<Failure, void>> call(
    TypeNewCommentParams params,
  ) async {
    return await commentsRepo.typeNewComment(typeCommentParams: params);
  }
}
