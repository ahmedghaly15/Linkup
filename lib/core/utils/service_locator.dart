import 'package:get_it/get_it.dart';
import 'package:social_app/features/auth/data/auth_repo_impl.dart';
import 'package:social_app/features/auth/domain/auth_repo.dart';

final GetIt serviceLocator = GetIt.instance;

class ServiceLocator {
  void setupServiceLocators() {
    serviceLocator.registerLazySingleton<AuthRepo>(() => AuthRepoImpl());
  }
}
