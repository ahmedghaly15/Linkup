import 'package:dartz/dartz.dart';
import 'package:social_app/core/errors/failure.dart';
import 'package:social_app/core/models/user_model.dart';
import 'package:social_app/core/utils/functions/execute_and_handle_errors.dart';
import 'package:social_app/features/search/data/datasources/search_datasource.dart';
import 'package:social_app/features/search/domain/repositories/search_repo.dart';

class SearchRepoImpl implements SearchRepo {
  final SearchDataSource searchDataSource;

  const SearchRepoImpl({required this.searchDataSource});

  @override
  Future<Either<Failure, List<UserModel>>> search({
    required String nameOrEmail,
  }) {
    return executeAndHandleErrors<List<UserModel>>(function: () async {
      final List<UserModel> searchResult = <UserModel>[];

      final users = await searchDataSource.search();

      searchResult.clear();

      for (var user in users.docs) {
        // Modify the condition for a case-insensitive partial match
        if (user
                .data()['name']
                .toString()
                .toLowerCase()
                .contains(nameOrEmail.toLowerCase()) ||
            user
                .data()['email']
                .toString()
                .toLowerCase()
                .contains(nameOrEmail.toLowerCase())) {
          searchResult.add(UserModel.fromJson(user.data()));
        }
      }
      print('SEARCH RESULT: ${searchResult.toString()}');

      return searchResult;
    });
  }
}
