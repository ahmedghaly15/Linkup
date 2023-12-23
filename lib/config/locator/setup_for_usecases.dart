part of '../../service_locator.dart';

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

    getIt.registerLazySingleton<ForgotPasswordUseCase>(
      () => ForgotPasswordUseCase(
        forgotPasswordRepo: getIt.get<ForgotPasswordRepo>(),
      ),
    );

    getIt.registerLazySingleton<ChangeBottomNavIndexUseCase>(
      () => ChangeBottomNavIndexUseCase(linkupRepo: getIt.get<LinkupRepo>()),
    );

    getIt.registerLazySingleton<ChangeNavToHomeUseCase>(
      () => ChangeNavToHomeUseCase(linkupRepo: getIt.get<LinkupRepo>()),
    );

    getIt.registerLazySingleton<GetBodyUseCse>(
      () => GetBodyUseCse(linkupRepo: getIt.get<LinkupRepo>()),
    );

    getIt.registerLazySingleton<GetBottomNavItemsUseCase>(
      () => GetBottomNavItemsUseCase(linkupRepo: getIt.get<LinkupRepo>()),
    );

    getIt.registerLazySingleton<GetUserDataUseCase>(
      () => GetUserDataUseCase(linkupRepo: getIt.get<LinkupRepo>()),
    );

    getIt.registerLazySingleton<GetAllUsersUseCase>(
      () => GetAllUsersUseCase(linkupRepo: getIt.get<LinkupRepo>()),
    );
  }
}
