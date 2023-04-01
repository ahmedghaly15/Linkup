// import '/models/sign_in_model.dart';

//==================== Auth Screen States ====================
abstract class AuthScreenStates {}

class AuthScreenInitialState extends AuthScreenStates {}

class SignInLoadingState extends AuthScreenStates {}

class SignInSuccessState extends AuthScreenStates {
  // final SignInModel signInModel;
  // SignInSuccessState(this.signInModel);
}

class SignInErrorState extends AuthScreenStates {
  final String error;
  SignInErrorState(this.error);
}

class SignUpLoadingState extends AuthScreenStates {}

class SignUpSuccessState extends AuthScreenStates {
  // final SignInModel signInModel;
  // SignUpSuccessState(this.signInModel);
}

class SignUpErrorState extends AuthScreenStates {
  final String error;
  SignUpErrorState(this.error);
}
