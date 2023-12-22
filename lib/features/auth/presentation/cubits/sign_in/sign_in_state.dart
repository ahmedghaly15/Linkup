part of 'sign_in_cubit.dart';

abstract class SignInState extends Equatable {
  const SignInState();

  @override
  List<Object?> get props => [];
}

class SignInInitial extends SignInState {
  const SignInInitial();
}

class SwitchSignInPassVisible extends SignInState {
  final bool passVisibility;

  const SwitchSignInPassVisible({required this.passVisibility});

  @override
  List<Object> get props => [passVisibility];
}

class SignInLoadingState extends SignInState {
  const SignInLoadingState();
}

class SignInSuccessState extends SignInState {
  final String uId;

  const SignInSuccessState({required this.uId});

  @override
  List<Object> get props => [uId];
}

class SignInErrorState extends SignInState {
  final String error;
  const SignInErrorState({required this.error});

  @override
  List<Object> get props => [error];
}
