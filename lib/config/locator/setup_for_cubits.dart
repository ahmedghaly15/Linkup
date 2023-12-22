import 'package:social_app/config/themes/cubit/themes_cubit.dart';
import 'package:social_app/features/auth/domain/usecases/firestore_create_user_usecase.dart';
import 'package:social_app/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:social_app/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:social_app/features/auth/presentation/cubits/sign_in/sign_in_cubit.dart';
import 'package:social_app/features/auth/presentation/cubits/sign_up/sign_up_cubit.dart';
import 'package:social_app/service_locator.dart';

class SetupLocatorForCubits {
  void setup() {
    getIt.registerFactory<ThemesCubit>(() => ThemesCubit());

    getIt.registerFactory<SignInCubit>(
      () => SignInCubit(signInUseCase: getIt.get<SignInUseCase>()),
    );

    getIt.registerFactory<SignUpCubit>(
      () => SignUpCubit(
        firestoreCreateUserUseCase: getIt.get<FirestoreCreateUserUseCase>(),
        signUpUseCase: getIt.get<SignUpUseCase>(),
      ),
    );
  }
}
