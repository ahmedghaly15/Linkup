part of '../../service_locator.dart';

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

    getIt.registerLazySingleton<LinkupRepo>(
      () => LinkupRepoImpl(linkupDataSource: getIt.get<LinkupDataSource>()),
    );

    getIt.registerLazySingleton<PostsRepo>(
      () => PostsRepoImpl(postsDataSource: getIt.get<PostsDataSource>()),
    );

    getIt.registerLazySingleton<CommentsRepo>(
      () => CommentsRepoImpl(
        commentsDataSource: getIt.get<CommentsDataSource>(),
      ),
    );

    getIt.registerLazySingleton<ChatRepo>(
      () => ChatRepoImpl(chatDataSource: getIt.get<ChatDataSource>()),
    );

    getIt.registerLazySingleton<UserRepo>(
      () => UserRepoImpl(userDataSource: getIt.get<UserDataSource>()),
    );
  }
}
