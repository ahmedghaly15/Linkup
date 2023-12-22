import 'package:social_app/features/auth/data/datasources/sign_in/sign_in_datasource.dart';
import 'package:social_app/features/auth/data/datasources/sign_up/sign_up_datasource.dart';
import 'package:social_app/features/auth/data/repositories/sign_in_repo_impl.dart';
import 'package:social_app/features/auth/data/repositories/sign_up_repo_impl.dart';
import 'package:social_app/features/auth/domain/repositories/sign_in_repo.dart';
import 'package:social_app/features/auth/domain/repositories/sign_up_repo.dart';
import 'package:social_app/service_locator.dart';

class SetupLocatorForRepos {
  void setup() {
    getIt.registerLazySingleton<SignInRepo>(
      () => SignInRepoImpl(signInDataSource: getIt.get<SignInDataSource>()),
    );

    getIt.registerLazySingleton<SignUpRepo>(
      () => SignUpRepoImpl(
        signUpDataSource: getIt.get<SignUpDataSource>(),
      ),
    );
  }
}
