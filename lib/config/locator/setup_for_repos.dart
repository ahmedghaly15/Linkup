part of '../../service_locator.dart';

class SetupLocatorForRepos {
  void setup() {
    getIt.registerLazySingleton<SignInRepo>(
      () => SignInRepoImpl(signInDataSource: getIt.get<SignInDataSource>()),
    );

    getIt.registerLazySingleton<SignUpRepo>(
      () => SignUpRepoImpl(signUpDataSource: getIt.get<SignUpDataSource>()),
    );

    getIt.registerLazySingleton<ForgotPasswordRepo>(
      () => ForgotPasswordRepoImpl(
        forgotPasswordDataSource: getIt.get<ForgotPasswordDataSource>(),
      ),
    );

    getIt.registerLazySingleton<LinkupRepo>(
      () => LinkupRepoImpl(linkupDataSource: getIt.get<LinkupDataSource>()),
    );

    getIt.registerLazySingleton<FeedsRepo>(
      () => FeedsRepoImpl(feedsDataSource: getIt.get<FeedsDataSource>()),
    );
  }
}
