import 'package:social_app/features/auth/data/datasources/forgot_password/forgot_password_datasource.dart';
import 'package:social_app/features/auth/data/datasources/sign_in/sign_in_datasource.dart';
import 'package:social_app/features/auth/data/datasources/sign_up/sign_up_datasource.dart';
import 'package:social_app/features/auth/data/repositories/forgot_password_repo_impl.dart';
import 'package:social_app/features/auth/data/repositories/sign_in_repo_impl.dart';
import 'package:social_app/features/auth/data/repositories/sign_up_repo_impl.dart';
import 'package:social_app/features/auth/domain/repositories/forgot_password_repo.dart';
import 'package:social_app/features/auth/domain/repositories/sign_in_repo.dart';
import 'package:social_app/features/auth/domain/repositories/sign_up_repo.dart';
import 'package:social_app/service_locator.dart';

class SetupLocatorForRepos {
  void setup() {
    getIt.registerLazySingleton<SignInRepo>(
      () => SignInRepoImpl(signInDataSource: getIt.get<SignInDataSource>()),
    );

    getIt.registerLazySingleton<SignUpRepo>(
      () => SignUpRepoImpl(signUpDataSource: getIt.get<SignUpDataSource>()),
    );

    getIt.registerLazySingleton<ForgotPasswordRepo>(
      () => ForgotPasswordRepoImpl(
        forgotPasswordDataSource: getIt.get<ForgotPasswordDataSource>(),
      ),
    );
  }
}
