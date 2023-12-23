import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:social_app/core/entities/no_params.dart';
import 'package:social_app/core/errors/failure.dart';
import 'package:social_app/core/usecases/base_usecase.dart';
import 'package:social_app/linkup/domain/repositories/linkup_repo.dart';

class GetAllUsersUseCase
    implements BaseUseCases<QuerySnapshot<Map<String, dynamic>>, NoParams> {
  final LinkupRepo linkupRepo;

  const GetAllUsersUseCase({required this.linkupRepo});

  @override
  Future<Either<Failure, QuerySnapshot<Map<String, dynamic>>>> call(
    NoParams params,
  ) async {
    return await linkupRepo.getAllUsers();
  }
}
