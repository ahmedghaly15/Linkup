import 'package:get_it/get_it.dart';
import 'package:social_app/config/locator/setup_for_core.dart';
import 'package:social_app/config/locator/setup_for_cubits.dart';
import 'package:social_app/config/locator/setup_for_datasources.dart';
import 'package:social_app/config/locator/setup_for_external.dart';
import 'package:social_app/config/locator/setup_for_repos.dart';
import 'package:social_app/config/locator/setup_for_usecases.dart';

import '/layout/data/app_repo_impl.dart';
import '/layout/domain/app_repo.dart';

final GetIt getIt = GetIt.instance;

class ServiceLocator {
  Future<void> setup() async {
    await SetupLocatorForExternal().setup();

    SetupLocatorForCore().setup();

    SetupLocatorForDataSource().setup();

    SetupLocatorForRepos().setup();

    SetupLocatorForUseCases().setup();

    SetupLocatorForCubits().setup();

    getIt.registerLazySingleton<AppRepo>(() => AppRepoImpl());
  }
}
