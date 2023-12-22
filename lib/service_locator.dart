import 'package:get_it/get_it.dart';
import 'package:social_app/config/locator/setup_for_external.dart';

import '/features/auth/data/auth_repo_impl.dart';
import '/features/auth/domain/auth_repo.dart';
import '/layout/data/app_repo_impl.dart';
import '/layout/domain/app_repo.dart';

final GetIt getIt = GetIt.instance;

class ServiceLocator {
  Future<void> setup() async {
    await SetupLocatorForExternal().setup();

    getIt.registerLazySingleton<AuthRepo>(() => AuthRepoImpl());
    getIt.registerLazySingleton<AppRepo>(() => AppRepoImpl());
  }
}
