import 'package:firebase_auth/firebase_auth.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:social_app/service_locator.dart';

class SetupLocatorForExternal {
  Future<void> setup() async {
    getIt.registerLazySingleton<InternetConnectionChecker>(
      () => InternetConnectionChecker(),
    );

    getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  }
}
