import 'package:dartz/dartz.dart';
import 'package:social_app/core/errors/failure.dart';
import 'package:social_app/core/usecases/base_usecase.dart';
import 'package:social_app/features/posts/data/models/post_model.dart';
import 'package:social_app/features/users/domain/repositories/user_repo.dart';

class GetUserPostsUseCase implements BaseUseCases<List<PostModel>, String> {
  final UserRepo userRepo;

  const GetUserPostsUseCase({required this.userRepo});

  @override
  Future<Either<Failure, List<PostModel>>> call(String params) async {
    return await userRepo.getUserPosts(uId: params);
  }
}
