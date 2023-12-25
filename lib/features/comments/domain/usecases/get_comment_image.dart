import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/core/errors/failure.dart';
import 'package:social_app/core/usecases/base_usecase.dart';
import 'package:social_app/features/comments/domain/repositories/comments_repo.dart';

class GetCommentImageUseCase implements BaseUseCases<XFile?, ImageSource> {
  final CommentsRepo commentsRepo;

  const GetCommentImageUseCase({required this.commentsRepo});

  @override
  Future<Either<Failure, XFile?>> call(ImageSource params) async {
    return await commentsRepo.getCommentImage(source: params);
  }
}
