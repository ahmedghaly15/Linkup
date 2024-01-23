import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_app/core/entities/no_params.dart';
import 'package:social_app/core/usecases/regular_usecase.dart';
import 'package:social_app/features/users/domain/repositories/user_repo.dart';

class GetUserDataUseCase
    implements
        RegularUseCases<Stream<DocumentSnapshot<Map<String, dynamic>>>,
            NoParams> {
  final UserRepo userRepo;

  const GetUserDataUseCase({required this.userRepo});

  @override
  Stream<DocumentSnapshot<Map<String, dynamic>>> call(
    NoParams params,
  ) {
    return userRepo.getUserData();
  }
}
