import '../../../../core/models/user_model.dart';

abstract class AppStates {}

class AppInitialState extends AppStates {}

//============ The Current User's States ============
class GetUserLoadingState extends AppStates {}

class GetUserSuccessState extends AppStates {}

class GetUserErrorState extends AppStates {
  final String error;
  GetUserErrorState(this.error);
}

//============ Getting All Users States ============
class GetAllUsersLoadingState extends AppStates {}

class GetAllUserSuccessState extends AppStates {}

class GetAllUserErrorState extends AppStates {
  final String error;
  GetAllUserErrorState(this.error);
}

//============ Posts States ============
class GetPostsLoadingState extends AppStates {}

class GetPostsSuccessState extends AppStates {}

class GetPostsErrorState extends AppStates {
  final String error;
  GetPostsErrorState(this.error);
}

//============ Change Bottom Nav State ============
class ChangeBottomNavState extends AppStates {}

//============ Profile Image States ============
class ProfileImagePickedSuccessState extends AppStates {}

class ProfileImagePickedErrorState extends AppStates {}

class UploadingProfileImageLoadingState extends AppStates {}

class UploadProfileImageSuccessState extends AppStates {}

class UploadProfileImageErrorState extends AppStates {}

//============ Cover Image States ============
class CoverImagePickedSuccessState extends AppStates {}

class CoverImagePickedErrorState extends AppStates {}

class UploadingCoverImageLoadingState extends AppStates {}

class UploadCoverImageSuccessState extends AppStates {}

class UploadCoverImageErrorState extends AppStates {}

//============ Post States ============
class UploadPostImageSuccessState extends AppStates {}

class UploadPostImageErrorState extends AppStates {}

class CreatePostLoadingState extends AppStates {}

class CreatePostSuccessState extends AppStates {}

class CreatePostErrorState extends AppStates {
  final String error;
  CreatePostErrorState(this.error);
}

class DeletePostLoadingState extends AppStates {}

class DeletePostSuccessState extends AppStates {}

class DeletePostErrorState extends AppStates {
  final String error;
  DeletePostErrorState(this.error);
}

class PostImagePickedSuccessState extends AppStates {}

class PostImagePickedErrorState extends AppStates {}

class PostImageRemovedState extends AppStates {}

//============ Updating The Current User States ============
class UserUpdateErrorState extends AppStates {}

//============ Like States ============
class LikePostSuccessState extends AppStates {}

class LikePostErrorState extends AppStates {
  final String error;
  LikePostErrorState(this.error);
}

//============ Comments States ============
class CommentCreatedLoadingState extends AppStates {}

class CommentCreatedSuccessState extends AppStates {}

class CommentCreatedErrorState extends AppStates {
  final String error;
  CommentCreatedErrorState(this.error);
}

class CommentImagePickedSuccessState extends AppStates {}

class CommentImagePickedErrorState extends AppStates {}

class UploadCommentImageLoadingState extends AppStates {}

class UploadCommentImageSuccessState extends AppStates {}

class UploadCommentImageErrorState extends AppStates {}

class GetCommentsSuccessState extends AppStates {}

class CommentImageRemovedSuccessState extends AppStates {}

class OnChangeTextSuccessState extends AppStates {}

//============ Messages States ============
class SendMessageSuccessState extends AppStates {}

class SendMessageErrorState extends AppStates {}

class GetMessagesSuccessState extends AppStates {}

class MessageImagePickedSuccessState extends AppStates {}

class MessageImagePickedErrorState extends AppStates {}

class UploadMessageImageLoadingState extends AppStates {}

class UploadMessageImageSuccessState extends AppStates {}

class UploadMessageImageErrorState extends AppStates {}

class RemovedMessageImageSuccessState extends AppStates {}

//============ Search States ============
class InvertIsSearchingSuccessState extends AppStates {}

class SearchListUpdateSuccessState extends AppStates {
  final List<UserModel> list;
  SearchListUpdateSuccessState(this.list);
}
