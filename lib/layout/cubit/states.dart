import '../../models/user_model.dart';

abstract class SocialAppStates {}

class SocialAppInitialState extends SocialAppStates {}

class GetUserLoadingState extends SocialAppStates {}

class GetUserSuccessState extends SocialAppStates {}

class GetUserErrorState extends SocialAppStates {
  final String error;
  GetUserErrorState(this.error);
}

// class GetAllUserLoadingState extends SocialAppStates {}

class GetAllUserSuccessState extends SocialAppStates {}

class GetAllUserErrorState extends SocialAppStates {
  final String error;
  GetAllUserErrorState(this.error);
}

class GetPostsLoadingState extends SocialAppStates {}

class GetPostsSuccessState extends SocialAppStates {}

class GetPostsErrorState extends SocialAppStates {
  final String error;
  GetPostsErrorState(this.error);
}

class ChangeBottomNavState extends SocialAppStates {}

class ProfileImagePickedSuccessState extends SocialAppStates {}

class ProfileImagePickedErrorState extends SocialAppStates {}

class CoverImagePickedSuccessState extends SocialAppStates {}

class CoverImagePickedErrorState extends SocialAppStates {}

class UploadProfileImageSuccessState extends SocialAppStates {}

class UploadProfileImageErrorState extends SocialAppStates {}

class UploadCoverImageSuccessState extends SocialAppStates {}

class UploadCoverImageErrorState extends SocialAppStates {}

class UploadPostImageSuccessState extends SocialAppStates {}

class UploadPostImageErrorState extends SocialAppStates {}

class UserUpdateLoadingState extends SocialAppStates {}

class UserUpdateErrorState extends SocialAppStates {}

class CreatePostLoadingState extends SocialAppStates {}

class CreatePostSuccessState extends SocialAppStates {}

class CreatePostErrorState extends SocialAppStates {
  final String error;
  CreatePostErrorState(this.error);
}

class DeletePostLoadingState extends SocialAppStates {}

class DeletePostSuccessState extends SocialAppStates {}

class DeletePostErrorState extends SocialAppStates {
  final String error;
  DeletePostErrorState(this.error);
}

class PostImagePickedSuccessState extends SocialAppStates {}

class PostImagePickedErrorState extends SocialAppStates {}

class PostImageRemovedState extends SocialAppStates {}

class LikePostSuccessState extends SocialAppStates {}

class LikePostErrorState extends SocialAppStates {
  final String error;
  LikePostErrorState(this.error);
}

class CommentCreatedLoadingState extends SocialAppStates {}

class CommentCreatedSuccessState extends SocialAppStates {}

class CommentCreatedErrorState extends SocialAppStates {
  final String error;
  CommentCreatedErrorState(this.error);
}

class CommentImagePickedSuccessState extends SocialAppStates {}

class CommentImagePickedErrorState extends SocialAppStates {}

class UploadCommentImageLoadingState extends SocialAppStates {}

class UploadCommentImageSuccessState extends SocialAppStates {}

class UploadCommentImageErrorState extends SocialAppStates {}

class GetCommentsSuccessState extends SocialAppStates {}

class CommentImageRemovedSuccessState extends SocialAppStates {}

class OnChangeCommentTextSuccessState extends SocialAppStates {}

// class ResetCommentTextSuccessState extends SocialAppStates {}

// class ControllerClearedSuccessState extends SocialAppStates {}

class SendMessageSuccessState extends SocialAppStates {}

class SendMessageErrorState extends SocialAppStates {}

class GetMessagesSuccessState extends SocialAppStates {}

class MessageImagePickedSuccessState extends SocialAppStates {}

class MessageImagePickedErrorState extends SocialAppStates {}

class UploadMessageImageLoadingState extends SocialAppStates {}

class UploadMessageImageSuccessState extends SocialAppStates {}

class UploadMessageImageErrorState extends SocialAppStates {}

class RemovedMessageImageSuccessState extends SocialAppStates {}

class InvertIsSearchingSuccessState extends SocialAppStates {}

class SearchListUpdateSuccessState extends SocialAppStates {
  final List<UserModel> list;
  SearchListUpdateSuccessState(this.list);
}
