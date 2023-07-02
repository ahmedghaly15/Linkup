import 'package:get_it/get_it.dart';

import '/features/auth/data/auth_repo_impl.dart';
import '/features/auth/domain/auth_repo.dart';
import '/layout/data/app_repo_impl.dart';
import '/layout/domain/app_repo.dart';

final GetIt serviceLocator = GetIt.instance;

class ServiceLocator {
  void setupServiceLocators() {
    serviceLocator.registerLazySingleton<AuthRepo>(() => AuthRepoImpl());
    serviceLocator.registerLazySingleton<AppRepo>(() => AppRepoImpl());
  }
}
