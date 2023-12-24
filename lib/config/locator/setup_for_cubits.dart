part of '../../service_locator.dart';

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

    getIt.registerFactory<ForgotPasswordCubit>(
      () => ForgotPasswordCubit(
        forgotPasswordUseCase: getIt.get<ForgotPasswordUseCase>(),
      ),
    );

    getIt.registerFactory<LinkupCubit>(
      () => LinkupCubit(
        getBodyUseCse: getIt.get<GetBodyUseCse>(),
        getBottomNavItemsUseCase: getIt.get<GetBottomNavItemsUseCase>(),
        changeBottomNavIndexUseCase: getIt.get<ChangeBottomNavIndexUseCase>(),
        changeNavToHomeUseCase: getIt.get<ChangeNavToHomeUseCase>(),
        getAllUsersUseCase: getIt.get<GetAllUsersUseCase>(),
        getUserDataUseCase: getIt.get<GetUserDataUseCase>(),
      ),
    );

    getIt.registerFactory<PostsCubit>(
      () => PostsCubit(
        getPostsUseCase: getIt.get<GetPostsUseCase>(),
        createPostUseCase: getIt.get<CreatePostUseCase>(),
        deletePostUseCase: getIt.get<DeletePostUseCase>(),
        getPostImageUseCase: getIt.get<GetPostImageUseCase>(),
        uploadPostImageUseCase: getIt.get<UploadPostImageUseCase>(),
        likePostUseCase: getIt.get<LikePostUseCase>(),
        unLikePostUseCase: getIt.get<UnLikePostUseCase>(),
        likedPostsByMeUseCase: getIt.get<LikedPostsByMeUseCase>(),
        
      ),
    );
  }
}
