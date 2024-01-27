import 'package:dartz/dartz.dart';
import 'package:social_app/core/entities/no_params.dart';
import 'package:social_app/core/errors/failure.dart';
import 'package:social_app/core/usecases/base_usecase.dart';
import 'package:social_app/features/users/domain/repositories/user_repo.dart';

class DeleteAccountUseCase implements BaseUseCases<void, NoParams> {
  final UserRepo userRepo;

  const DeleteAccountUseCase({required this.userRepo});

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await userRepo.deleteAccount();
  }
}
