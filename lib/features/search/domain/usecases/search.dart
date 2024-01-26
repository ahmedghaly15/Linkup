import 'package:dartz/dartz.dart';
import 'package:social_app/core/errors/failure.dart';
import 'package:social_app/core/models/user_model.dart';
import 'package:social_app/core/usecases/base_usecase.dart';
import 'package:social_app/features/search/domain/repositories/search_repo.dart';

class SearchUseCase implements BaseUseCases<List<UserModel>, String> {
  final SearchRepo searchRepo;

  const SearchUseCase({required this.searchRepo});

  @override
  Future<Either<Failure, List<UserModel>>> call(String params) async {
    return await searchRepo.search(nameOrEmail: params);
  }
}
