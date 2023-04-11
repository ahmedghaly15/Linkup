//==================== Auth Screen States ====================
abstract class AuthScreenStates {}

class AuthScreenInitialState extends AuthScreenStates {}

//========== Sign in States ==========
class SignInLoadingState extends AuthScreenStates {}

class SignInSuccessState extends AuthScreenStates {
  final String uId;
  SignInSuccessState(this.uId);
}

class SignInErrorState extends AuthScreenStates {
  final String error;
  SignInErrorState(this.error);
}

//========== Sign up States ==========
class SignUpLoadingState extends AuthScreenStates {}

class SignUpSuccessState extends AuthScreenStates {
  final String uId;
  SignUpSuccessState(this.uId);
}

class SignUpErrorState extends AuthScreenStates {
  final String error;
  SignUpErrorState(this.error);
}

class CreateUserSuccessState extends AuthScreenStates {}

class CreateUserErrorState extends AuthScreenStates {
  final String error;
  CreateUserErrorState(this.error);
}
