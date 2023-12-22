import 'package:social_app/features/auth/data/datasources/sign_in/sign_in_datasource.dart';
import 'package:social_app/features/auth/data/datasources/sign_in/sign_in_datasource_impl.dart';
import 'package:social_app/features/auth/data/datasources/sign_up/sign_up_datasource.dart';
import 'package:social_app/features/auth/data/datasources/sign_up/sign_up_datasource_impl.dart';
import 'package:social_app/service_locator.dart';

class SetupLocatorForDataSource {
  void setup() {
    getIt.registerLazySingleton<SignInDataSource>(() => SignInDataSourceImpl());

    getIt.registerLazySingleton<SignUpDataSource>(() => SignUpDataSourceImpl());
  }
}
