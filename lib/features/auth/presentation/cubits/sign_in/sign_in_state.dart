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

class SignInLoading extends SignInState {
  const SignInLoading();
}

class SignInSuccess extends SignInState {
  final String uId;

  const SignInSuccess({required this.uId});

  @override
  List<Object> get props => [uId];
}

class SignInError extends SignInState {
  final String error;
  const SignInError({required this.error});

  @override
  List<Object> get props => [error];
}
