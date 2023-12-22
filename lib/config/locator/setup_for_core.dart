import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_app/core/helpers/cache_helper.dart';
import 'package:social_app/core/internet/internet_checker.dart';
import 'package:social_app/core/internet/internet_checker_impl.dart';
import 'package:social_app/service_locator.dart';

class SetupLocatorForCore {
  void setup() {
    getIt.registerLazySingleton<InternetChecker>(
      () => InternetCheckerImpl(
        connectionChecker: getIt.get<InternetConnectionChecker>(),
      ),
    );

    getIt.registerLazySingleton<CacheHelper>(
      () => CacheHelper(getIt<SharedPreferences>()),
    );
  }
}
