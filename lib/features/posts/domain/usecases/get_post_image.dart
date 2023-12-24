import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/core/errors/failure.dart';
import 'package:social_app/core/usecases/base_usecase.dart';
import 'package:social_app/features/posts/domain/repositories/posts_repo.dart';

class GetPostImageUseCase implements BaseUseCases<XFile?, ImageSource> {
  final PostsRepo postsRepo;

  const GetPostImageUseCase({required this.postsRepo});

  @override
  Future<Either<Failure, XFile?>> call(ImageSource params) async {
    return await postsRepo.getPostImage(source: params);
  }
}
