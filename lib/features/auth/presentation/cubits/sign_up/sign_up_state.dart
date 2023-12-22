part of 'sign_up_cubit.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object?> get props => [];
}

class SignUpInitial extends SignUpState {
  const SignUpInitial();
}

class SignUpLoading extends SignUpState {
  const SignUpLoading();
}

class SignUpSuccess extends SignUpState {
  final String uId;

  const SignUpSuccess({required this.uId});

  @override
  List<Object> get props => [uId];
}

class SignUpError extends SignUpState {
  final String error;

  const SignUpError({required this.error});

  @override
  List<Object> get props => [error];
}

class CreateUserSuccess extends SignUpState {}

class CreateUserError extends SignUpState {
  final String error;

  const CreateUserError({required this.error});

  @override
  List<Object> get props => [error];
}

class SwitchSignUpPassVisible extends SignUpState {
  final bool signUpPassVisibility;

  const SwitchSignUpPassVisible({required this.signUpPassVisibility});

  @override
  List<Object> get props => [signUpPassVisibility];
}
