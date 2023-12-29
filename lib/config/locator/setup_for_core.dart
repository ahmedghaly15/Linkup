part of '../../service_locator.dart';

class SetupLocatorForCore {
  void setup() {
    getIt.registerLazySingleton<InternetChecker>(
      () => InternetCheckerImpl(
        connectionChecker: getIt.get<InternetConnectionChecker>(),
      ),
    );

    getIt.registerLazySingleton<CacheHelper>(
      () => CacheHelper(getIt.get<SharedPreferences>()),
    );
  }
}
