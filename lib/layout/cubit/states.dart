abstract class SocialAppStates {}

class SocialAppInitialState extends SocialAppStates {}

class GetUserLoadingState extends SocialAppStates {}

class GetUserSuccessState extends SocialAppStates {}

class GetUserErrorState extends SocialAppStates {
  final String error;
  GetUserErrorState(this.error);
}

class ChangeBottomNavState extends SocialAppStates {}

class GetProfileImageSuccessState extends SocialAppStates {}

class GetProfileImageErrorState extends SocialAppStates {}

class GetCoverImageSuccessState extends SocialAppStates {}

class GetCoverImageErrorState extends SocialAppStates {}

class UploadProfileImageSuccessState extends SocialAppStates {}

class UploadProfileImageErrorState extends SocialAppStates {}

class UploadCoverImageSuccessState extends SocialAppStates {}

class UploadCoverImageErrorState extends SocialAppStates {}

class UserUpdateLoadingState extends SocialAppStates {}

class UserUpdateErrorState extends SocialAppStates {}
