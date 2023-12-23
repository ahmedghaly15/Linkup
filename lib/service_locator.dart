import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_app/config/themes/cubit/themes_cubit.dart';
import 'package:social_app/core/helpers/cache_helper.dart';
import 'package:social_app/core/internet/internet_checker.dart';
import 'package:social_app/core/internet/internet_checker_impl.dart';
import 'package:social_app/features/auth/data/datasources/forgot_password/forgot_password_datasource.dart';
import 'package:social_app/features/auth/data/datasources/forgot_password/forgot_password_datasource_impl.dart';
import 'package:social_app/features/auth/data/datasources/sign_in/sign_in_datasource.dart';
import 'package:social_app/features/auth/data/datasources/sign_in/sign_in_datasource_impl.dart';
import 'package:social_app/features/auth/data/datasources/sign_up/sign_up_datasource.dart';
import 'package:social_app/features/auth/data/datasources/sign_up/sign_up_datasource_impl.dart';
import 'package:social_app/features/auth/data/repositories/forgot_password_repo_impl.dart';
import 'package:social_app/features/auth/data/repositories/sign_in_repo_impl.dart';
import 'package:social_app/features/auth/data/repositories/sign_up_repo_impl.dart';
import 'package:social_app/features/auth/domain/repositories/forgot_password_repo.dart';
import 'package:social_app/features/auth/domain/repositories/sign_in_repo.dart';
import 'package:social_app/features/auth/domain/repositories/sign_up_repo.dart';
import 'package:social_app/features/auth/domain/usecases/forgot_password/forgot_password_usecase.dart';
import 'package:social_app/features/auth/domain/usecases/sign_in/sign_in_usecase.dart';
import 'package:social_app/features/auth/domain/usecases/sign_up/firestore_create_user_usecase.dart';
import 'package:social_app/features/auth/domain/usecases/sign_up/sign_up_usecase.dart';
import 'package:social_app/features/auth/presentation/cubits/forgot_password/forgot_password_cubit.dart';
import 'package:social_app/features/auth/presentation/cubits/sign_in/sign_in_cubit.dart';
import 'package:social_app/features/auth/presentation/cubits/sign_up/sign_up_cubit.dart';
import 'package:social_app/linkup/data/datasources/linkup_datasource.dart';
import 'package:social_app/linkup/data/datasources/linkup_datasource_impl.dart';
import 'package:social_app/linkup/data/repositories/linkup_repo_impl.dart';
import 'package:social_app/linkup/domain/repositories/linkup_repo.dart';
import 'package:social_app/linkup/domain/usecases/change_bottom_nav_index.dart';
import 'package:social_app/linkup/domain/usecases/change_nav_to_home.dart';
import 'package:social_app/linkup/domain/usecases/get_all_users.dart';
import 'package:social_app/linkup/domain/usecases/get_body.dart';
import 'package:social_app/linkup/domain/usecases/get_bottom_nav_items.dart';
import 'package:social_app/linkup/domain/usecases/get_user_data.dart';
import 'package:social_app/linkup/presentation/cubits/linkup_cubit.dart';

import 'linkup/data/app_repo_impl.dart';
import 'linkup/domain/app_repo.dart';

part 'config/locator/setup_for_usecases.dart';
part 'config/locator/setup_for_core.dart';
part 'config/locator/setup_for_cubits.dart';
part 'config/locator/setup_for_datasources.dart';
part 'config/locator/setup_for_external.dart';
part 'config/locator/setup_for_repos.dart';

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
