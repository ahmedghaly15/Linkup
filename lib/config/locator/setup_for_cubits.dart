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
        peopleLikeThePostUseCase: getIt.get<PeopleLikeThePostUseCase>(),
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
  }
}
