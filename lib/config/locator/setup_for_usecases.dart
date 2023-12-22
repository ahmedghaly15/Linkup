import 'package:social_app/features/auth/domain/repositories/sign_in_repo.dart';
import 'package:social_app/features/auth/domain/repositories/sign_up_repo.dart';
import 'package:social_app/features/auth/domain/usecases/firestore_create_user_usecase.dart';
import 'package:social_app/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:social_app/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:social_app/service_locator.dart';

class SetupLocatorForUseCases {
  void setup() {
    getIt.registerLazySingleton<SignInUseCase>(
      () => SignInUseCase(signInRepo: getIt.get<SignInRepo>()),
    );

    getIt.registerLazySingleton<FirestoreCreateUserUseCase>(
      () => FirestoreCreateUserUseCase(signUpRepo: getIt.get<SignUpRepo>()),
    );

    getIt.registerLazySingleton<SignUpUseCase>(
      () => SignUpUseCase(signUpRepo: getIt.get<SignUpRepo>()),
    );
  }
}
