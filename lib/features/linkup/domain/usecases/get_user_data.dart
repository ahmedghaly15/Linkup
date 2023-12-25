import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:social_app/core/entities/no_params.dart';
import 'package:social_app/core/errors/failure.dart';
import 'package:social_app/core/usecases/base_usecase.dart';
import 'package:social_app/features/linkup/domain/repositories/linkup_repo.dart';

class GetUserDataUseCase
    implements BaseUseCases<DocumentSnapshot<Map<String, dynamic>>, NoParams> {
  final LinkupRepo linkupRepo;

  const GetUserDataUseCase({required this.linkupRepo});

  @override
  Future<Either<Failure, DocumentSnapshot<Map<String, dynamic>>>> call(
    NoParams params,
  ) async {
    return await linkupRepo.getUserData();
  }
}
