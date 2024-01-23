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
      ),
    );

    getIt.registerFactory<PostsCubit>(
      () => PostsCubit(
        createPostUseCase: getIt.get<CreatePostUseCase>(),
        deletePostUseCase: getIt.get<DeletePostUseCase>(),
        getPostImageUseCase: getIt.get<GetPostImageUseCase>(),
        uploadPostImageUseCase: getIt.get<UploadPostImageUseCase>(),
        likePostUseCase: getIt.get<LikePostUseCase>(),
        unLikePostUseCase: getIt.get<UnLikePostUseCase>(),
        likedPostsByMeUseCase: getIt.get<LikedPostsByMeUseCase>(),
        peopleLikeThePostUseCase: getIt.get<PeopleWhoLikedUseCase>(),
      ),
    );

    getIt.registerFactory<CommentsCubit>(
      () => CommentsCubit(
        typeNewCommentUseCase: getIt.get<TypeNewCommentUseCase>(),
        getCommentImageUseCase: getIt.get<GetCommentImageUseCase>(),
        getCommentsUseCase: getIt.get<GetCommentsUseCase>(),
        uploadCommentImageUseCase: getIt.get<UploadCommentImageUseCase>(),
      ),
    );

    getIt.registerFactory<ChatCubit>(
      () => ChatCubit(
        getMessagesUseCase: getIt.get<GetMessagesUseCase>(),
        sendMessageUseCase: getIt.get<SendMessageUseCase>(),
        getMessageImageUseCase: getIt.get<GetMessageImageUseCase>(),
        uploadMessageImageUseCase: getIt.get<UploadMessageImageUseCase>(),
      ),
    );

    getIt.registerFactory<UserCubit>(
      () => UserCubit(
        getUserDataUseCase: getIt.get<GetUserDataUseCase>(),
        getPostsUseCase: getIt.get<GetPostsUseCase>(),
        getAllUserPostsUseCase: getIt.get<GetUserPostsUseCase>(),
        signOutUseCase: getIt.get<SignOutUseCase>(),
      ),
    );

    getIt.registerFactory<EditProfileCubit>(
      () => EditProfileCubit(
        updateUserUseCase: getIt.get<UpdateUserUseCase>(),
        getImageUseCase: getIt.get<GetImageUseCase>(),
        uploadImageUseCase: getIt.get<UploadImageUseCase>(),
        updateUserPostsUseCase: getIt.get<UpdateUserPostsUseCase>(),
      ),
    );

    getIt.registerFactory<OnboardingCubit>(
      () => OnboardingCubit(
        getOnboardingPagesUseCase: getIt.get<GetOnboardingPagesUseCase>(),
        navigateBetweenPagesUseCase: getIt.get<NavigateBetweenPagesUseCase>(),
        previousPageUseCase: getIt.get<PreviousPageUseCase>(),
      ),
    );

    getIt.registerFactory<PeopleWhoLikedCubit>(
      () => PeopleWhoLikedCubit(
        peopleWhoLikedUseCase: getIt.get<PeopleWhoLikedUseCase>(),
      ),
    );

    getIt.registerFactory<FollowingAndFollowersCubit>(
      () => FollowingAndFollowersCubit(
        followUseCase: getIt.get<FollowUseCase>(),
        unfollowUseCase: getIt.get<UnfollowUseCase>(),
        userIsFollowedUseCase: getIt.get<UserIsFollowedUseCase>(),
      ),
    );

    getIt.registerFactory<GetFollowersCubit>(
      () => GetFollowersCubit(
        getFollowersUseCase: getIt.get<GetFollowersUseCase>(),
      ),
    );

    getIt.registerFactory<GetFollowingCubit>(
      () => GetFollowingCubit(
        getFollowingUseCase: getIt.get<GetFollowingUseCase>(),
      ),
    );
  }
}
