part of '../../service_locator.dart';

class SetupLocatorForDataSource {
  void setup() {
    getIt.registerLazySingleton<SignInDataSource>(() => SignInDataSourceImpl());

    getIt.registerLazySingleton<SignUpDataSource>(() => SignUpDataSourceImpl());

    getIt.registerLazySingleton<ForgotPasswordDataSource>(
      () => ForgotPasswordDataSourceImpl(),
    );

    getIt.registerLazySingleton<LinkupDataSource>(() => LinkupDataSourceImpl());

    getIt.registerLazySingleton<PostsDataSource>(() => PostsDataSourceImpl());
  }
}
