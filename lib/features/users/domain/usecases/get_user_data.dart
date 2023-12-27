import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:social_app/core/entities/no_params.dart';
import 'package:social_app/core/errors/failure.dart';
import 'package:social_app/core/usecases/base_usecase.dart';
import 'package:social_app/features/users/domain/repositories/user_repo.dart';

class GetUserDataUseCase
    implements BaseUseCases<DocumentSnapshot<Map<String, dynamic>>, NoParams> {
  final UserRepo userRepo;

  const GetUserDataUseCase({required this.userRepo});

  @override
  Future<Either<Failure, DocumentSnapshot<Map<String, dynamic>>>> call(
    NoParams params,
  ) async {
    return await userRepo.getUserData();
  }
}