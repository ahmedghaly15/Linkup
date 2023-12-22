import 'package:dartz/dartz.dart';
import 'package:social_app/core/errors/failure.dart';
import 'package:social_app/core/usecases/base_usecase.dart';
import 'package:social_app/features/auth/domain/entities/create_user_params.dart';
import 'package:social_app/features/auth/domain/repositories/sign_up_repo.dart';

class FirestoreCreateUserUseCase
    implements BaseUseCases<void, CreateUserParams> {
  final SignUpRepo signUpRepo;

  const FirestoreCreateUserUseCase({required this.signUpRepo});

  @override
  Future<Either<Failure, void>> call(CreateUserParams params) async {
    return await signUpRepo.firestoreCreateUSer(createUserParams: params);
  }
}
