part of '../../service_locator.dart';

class SetupLocatorForUseCases {
  void setup() {
    getIt.registerLazySingleton<SignInUseCase>(
      () => SignInUseCase(signInRepo: getIt.get<SignInRepo>()),
    );

    getIt.registerLazySingleton<FirestoreCreateUserUseCase>(
      () => FirestoreCreateUserUseCase(signUpRepo: getIt.get<SignUpRepo>()),
    );

    getIt.registerLazySingleton<SignUpUseCase>(
      () => SignUpUseCase(signUpRepo: getIt.get<SignUpRepo>()),
    );

    getIt.registerLazySingleton<ForgotPasswordUseCase>(
      () => ForgotPasswordUseCase(
        forgotPasswordRepo: getIt.get<ForgotPasswordRepo>(),
      ),
    );

    getIt.registerLazySingleton<ChangeBottomNavIndexUseCase>(
      () => ChangeBottomNavIndexUseCase(linkupRepo: getIt.get<LinkupRepo>()),
    );

    getIt.registerLazySingleton<ChangeNavToHomeUseCase>(
      () => ChangeNavToHomeUseCase(linkupRepo: getIt.get<LinkupRepo>()),
    );

    getIt.registerLazySingleton<GetBodyUseCse>(
      () => GetBodyUseCse(linkupRepo: getIt.get<LinkupRepo>()),
    );

    getIt.registerLazySingleton<GetBottomNavItemsUseCase>(
      () => GetBottomNavItemsUseCase(linkupRepo: getIt.get<LinkupRepo>()),
    );

    getIt.registerLazySingleton<GetUserDataUseCase>(
      () => GetUserDataUseCase(linkupRepo: getIt.get<LinkupRepo>()),
    );

    getIt.registerLazySingleton<GetAllUsersUseCase>(
      () => GetAllUsersUseCase(linkupRepo: getIt.get<LinkupRepo>()),
    );

    getIt.registerLazySingleton<GetPostsUseCase>(
      () => GetPostsUseCase(postsRepo: getIt.get<PostsRepo>()),
    );

    getIt.registerLazySingleton<CreatePostUseCase>(
      () => CreatePostUseCase(postsRepo: getIt.get<PostsRepo>()),
    );

    getIt.registerLazySingleton<DeletePostUseCase>(
      () => DeletePostUseCase(postsRepo: getIt.get<PostsRepo>()),
    );

    getIt.registerLazySingleton<GetPostImageUseCase>(
      () => GetPostImageUseCase(postsRepo: getIt.get<PostsRepo>()),
    );

    getIt.registerLazySingleton<UploadPostImageUseCase>(
      () => UploadPostImageUseCase(postsRepo: getIt.get<PostsRepo>()),
    );

    getIt.registerLazySingleton<LikePostUseCase>(
      () => LikePostUseCase(postsRepo: getIt.get<PostsRepo>()),
    );

    getIt.registerLazySingleton<UnLikePostUseCase>(
      () => UnLikePostUseCase(postsRepo: getIt.get<PostsRepo>()),
    );

    getIt.registerLazySingleton<LikedPostsByMeUseCase>(
      () => LikedPostsByMeUseCase(postsRepo: getIt.get<PostsRepo>()),
    );

    getIt.registerLazySingleton<PeopleLikeThePostUseCase>(
      () => PeopleLikeThePostUseCase(postsRepo: getIt.get<PostsRepo>()),
    );

    getIt.registerLazySingleton<TypeNewCommentUseCase>(
      () => TypeNewCommentUseCase(commentsRepo: getIt.get<CommentsRepo>()),
    );

    getIt.registerLazySingleton<GetCommentImageUseCase>(
      () => GetCommentImageUseCase(commentsRepo: getIt.get<CommentsRepo>()),
    );

    getIt.registerLazySingleton<GetCommentsUseCase>(
      () => GetCommentsUseCase(commentsRepo: getIt.get<CommentsRepo>()),
    );

    getIt.registerLazySingleton<UploadCommentImageUseCase>(
      () => UploadCommentImageUseCase(commentsRepo: getIt.get<CommentsRepo>()),
    );
  }
}
