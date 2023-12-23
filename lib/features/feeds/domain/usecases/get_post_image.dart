import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/core/errors/failure.dart';
import 'package:social_app/core/usecases/base_usecase.dart';
import 'package:social_app/features/feeds/domain/repositories/feeds_repo.dart';

class GetPostImageUseCase implements BaseUseCases<XFile?, ImageSource> {
  final FeedsRepo feedsRepo;

  const GetPostImageUseCase({required this.feedsRepo});

  @override
  Future<Either<Failure, XFile?>> call(ImageSource params) async {
    return await feedsRepo.getPostImage(source: params);
  }
}
