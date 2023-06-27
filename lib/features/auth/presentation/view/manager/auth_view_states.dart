//==================== Auth View States ====================
abstract class AuthViewStates {}

class AuthViewInitialState extends AuthViewStates {}

//========== Sign in States ==========
class SignInLoadingState extends AuthViewStates {}

class SignInSuccessState extends AuthViewStates {
  final String uId;
  SignInSuccessState(this.uId);
}

class SignInErrorState extends AuthViewStates {
  final String error;
  SignInErrorState(this.error);
}

//========== Sign up States ==========
class SignUpLoadingState extends AuthViewStates {}

class SignUpSuccessState extends AuthViewStates {
  final String uId;
  SignUpSuccessState(this.uId);
}

class SignUpErrorState extends AuthViewStates {
  final String error;
  SignUpErrorState(this.error);
}

class CreateUserSuccessState extends AuthViewStates {}

class CreateUserErrorState extends AuthViewStates {
  final String error;
  CreateUserErrorState(this.error);
}

class SwitchPassVisibleState extends AuthViewStates {}

class SwitchConfirmPassVisibleState extends AuthViewStates {}
