import '/models/user_model.dart';

abstract class SocialAppStates {}

class SocialAppInitialState extends SocialAppStates {}

//============ The Current User's States ============
class GetUserLoadingState extends SocialAppStates {}

class GetUserSuccessState extends SocialAppStates {}

class GetUserErrorState extends SocialAppStates {
  final String error;
  GetUserErrorState(this.error);
}

//============ Getting All Users States ============
class GetAllUserSuccessState extends SocialAppStates {}

class GetAllUserErrorState extends SocialAppStates {
  final String error;
  GetAllUserErrorState(this.error);
}

//============ Posts States ============
class GetPostsLoadingState extends SocialAppStates {}

class GetPostsSuccessState extends SocialAppStates {}

class GetPostsErrorState extends SocialAppStates {
  final String error;
  GetPostsErrorState(this.error);
}

//============ Change Bottom Nav State ============
class ChangeBottomNavState extends SocialAppStates {}

//============ Profile Image States ============
class ProfileImagePickedSuccessState extends SocialAppStates {}

class ProfileImagePickedErrorState extends SocialAppStates {}

class UploadProfileImageSuccessState extends SocialAppStates {}

class UploadProfileImageErrorState extends SocialAppStates {}

//============ Cover Image States ============
class CoverImagePickedSuccessState extends SocialAppStates {}

class CoverImagePickedErrorState extends SocialAppStates {}

class UploadCoverImageSuccessState extends SocialAppStates {}

class UploadCoverImageErrorState extends SocialAppStates {}

//============ Post States ============
class UploadPostImageSuccessState extends SocialAppStates {}

class UploadPostImageErrorState extends SocialAppStates {}

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

//============ Updating The Current User States ============
class UserUpdateLoadingState extends SocialAppStates {}

class UserUpdateErrorState extends SocialAppStates {}

//============ Like States ============
class LikePostSuccessState extends SocialAppStates {}

class LikePostErrorState extends SocialAppStates {
  final String error;
  LikePostErrorState(this.error);
}

//============ Comments States ============
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

//============ Messages States ============
class SendMessageSuccessState extends SocialAppStates {}

class SendMessageErrorState extends SocialAppStates {}

class GetMessagesSuccessState extends SocialAppStates {}

class MessageImagePickedSuccessState extends SocialAppStates {}

class MessageImagePickedErrorState extends SocialAppStates {}

class UploadMessageImageLoadingState extends SocialAppStates {}

class UploadMessageImageSuccessState extends SocialAppStates {}

class UploadMessageImageErrorState extends SocialAppStates {}

class RemovedMessageImageSuccessState extends SocialAppStates {}

//============ Search States ============
class InvertIsSearchingSuccessState extends SocialAppStates {}

class SearchListUpdateSuccessState extends SocialAppStates {
  final List<UserModel> list;
  SearchListUpdateSuccessState(this.list);
}
