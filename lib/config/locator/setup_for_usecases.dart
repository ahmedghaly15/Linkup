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

    getIt.registerLazySingleton<GetPostsUseCase>(
      () => GetPostsUseCase(userRepo: getIt.get<UserRepo>()),
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

    getIt.registerLazySingleton<PeopleWhoLikedUseCase>(
      () => PeopleWhoLikedUseCase(
        peopleWhoLikedRepo: getIt.get<PeopleWhoLikedRepo>(),
      ),
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

    getIt.registerLazySingleton<GetMessageImageUseCase>(
      () => GetMessageImageUseCase(chatRepo: getIt.get<ChatRepo>()),
    );

    getIt.registerLazySingleton<GetMessagesUseCase>(
      () => GetMessagesUseCase(chatRepo: getIt.get<ChatRepo>()),
    );

    getIt.registerLazySingleton<SendMessageUseCase>(
      () => SendMessageUseCase(chatRepo: getIt.get<ChatRepo>()),
    );

    getIt.registerLazySingleton<UploadMessageImageUseCase>(
      () => UploadMessageImageUseCase(chatRepo: getIt.get<ChatRepo>()),
    );

    getIt.registerLazySingleton<GetUserDataUseCase>(
      () => GetUserDataUseCase(userRepo: getIt.get<UserRepo>()),
    );

    getIt.registerLazySingleton<SignOutUseCase>(
      () => SignOutUseCase(userRepo: getIt.get<UserRepo>()),
    );

    getIt.registerLazySingleton<UpdateUserUseCase>(
      () => UpdateUserUseCase(editProfileRepo: getIt.get<EditProfileRepo>()),
    );

    getIt.registerLazySingleton<GetImageUseCase>(
      () => GetImageUseCase(editProfileRepo: getIt.get<EditProfileRepo>()),
    );

    getIt.registerLazySingleton<UploadImageUseCase>(
      () => UploadImageUseCase(editProfileRepo: getIt.get<EditProfileRepo>()),
    );

    getIt.registerLazySingleton<UpdateUserPostsUseCase>(
      () => UpdateUserPostsUseCase(
        editProfileRepo: getIt.get<EditProfileRepo>(),
      ),
    );

    getIt.registerLazySingleton<GetOnboardingPagesUseCase>(
      () => GetOnboardingPagesUseCase(
        onboardingRepo: getIt.get<OnboardingRepo>(),
      ),
    );

    getIt.registerLazySingleton<NavigateBetweenPagesUseCase>(
      () => NavigateBetweenPagesUseCase(
        onBoardingRepo: getIt.get<OnboardingRepo>(),
      ),
    );

    getIt.registerLazySingleton<PreviousPageUseCase>(
      () => PreviousPageUseCase(onboardingRepo: getIt.get<OnboardingRepo>()),
    );

    getIt.registerLazySingleton<FollowUseCase>(
      () => FollowUseCase(
        followingAndFollowersRepo: getIt.get<FollowingAndFollowersRepo>(),
      ),
    );

    getIt.registerLazySingleton<GetFollowersUseCase>(
      () => GetFollowersUseCase(
        followingAndFollowersRepo: getIt.get<FollowingAndFollowersRepo>(),
      ),
    );

    getIt.registerLazySingleton<UnfollowUseCase>(
      () => UnfollowUseCase(
        followingAndFollowersRepo: getIt.get<FollowingAndFollowersRepo>(),
      ),
    );

    getIt.registerLazySingleton<UserIsInFollowingUseCase>(
      () => UserIsInFollowingUseCase(
        followingAndFollowersRepo: getIt.get<FollowingAndFollowersRepo>(),
      ),
    );

    getIt.registerLazySingleton<UserIsInFollowersUseCase>(
      () => UserIsInFollowersUseCase(
        followingAndFollowersRepo: getIt.get<FollowingAndFollowersRepo>(),
      ),
    );

    getIt.registerLazySingleton<GetFollowingUseCase>(
      () => GetFollowingUseCase(
        followingAndFollowersDataRepo: getIt.get<FollowingAndFollowersRepo>(),
      ),
    );
  }
}
