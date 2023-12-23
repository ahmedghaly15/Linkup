import 'package:dartz/dartz.dart';
import 'package:social_app/core/errors/failure.dart';
import 'package:social_app/core/usecases/base_usecase.dart';
import 'package:social_app/features/feeds/domain/repositories/feeds_repo.dart';

class DeletePostUseCase implements BaseUseCases<void, String> {
  final FeedsRepo feedsRepo;

  const DeletePostUseCase({required this.feedsRepo});

  @override
  Future<Either<Failure, void>> call(String params) async {
    return await feedsRepo.deletePost(postId: params);
  }
}
