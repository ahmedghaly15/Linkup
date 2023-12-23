import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/features/auth/domain/entities/sign_in_params.dart';
import 'package:social_app/features/auth/domain/usecases/sign_in/sign_in_usecase.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final SignInUseCase signInUseCase;

  SignInCubit({required this.signInUseCase}) : super(const SignInInitial());

  void signIn({required SignInParams params}) {
    emit(const SignInLoading());

    signInUseCase(params).then((value) {
      value.fold(
        (failure) => emit(SignInError(error: failure.failureMsg.toString())),
        (credential) {
          print('VERIFY: ${credential.user!.emailVerified}');
          emit(SignInSuccess(uId: credential.user!.uid));
        },
      );
    });
  }

  bool signInPassVisibility = true;

  void switchPassVisibility() {
    signInPassVisibility = !signInPassVisibility;
    emit(SwitchSignInPassVisible(passVisibility: signInPassVisibility));
  }
}
