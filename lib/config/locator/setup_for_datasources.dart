part of '../../service_locator.dart';

class SetupLocatorForDataSource {
  void setup() {
    getIt.registerLazySingleton<SignInDataSource>(() => SignInDataSourceImpl());

    getIt.registerLazySingleton<SignUpDataSource>(() => SignUpDataSourceImpl());

    getIt.registerLazySingleton<ForgotPasswordDataSource>(
      () => ForgotPasswordDataSourceImpl(),
    );

    getIt.registerLazySingleton<LinkupDataSource>(() => LinkupDataSourceImpl());

    getIt.registerLazySingleton<PostsDataSource>(() => PostsDataSourceImpl());

    getIt.registerLazySingleton<CommentsDataSource>(
      () => CommentsDataSourceImpl(),
    );

    getIt.registerLazySingleton<ChatDataSource>(() => ChatDataSourceImpl());

    getIt.registerLazySingleton<UserDataSource>(() => UserDataSourceImpl());

    getIt.registerLazySingleton<EditProfileDataSource>(
      () => EditProfileDataSourceImpl(),
    );

    getIt.registerLazySingleton<OnboardingDataSource>(
      () => OnboardingDataSourceImpl(),
    );

    getIt.registerLazySingleton<PeopleWhoLikedDataSource>(
      () => PeopleWhoLikedDataSourceImpl(),
    );

    getIt.registerLazySingleton<FollowingAndFollowersDataSource>(
      () => FollowingAndFollowersDataSourceImpl(),
    );

    getIt.registerLazySingleton<SearchDataSource>(() => SearchDataSourceImpl());
  }
}
