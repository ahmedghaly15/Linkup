import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/features/auth/domain/entities/create_user_params.dart';
import 'package:social_app/features/auth/domain/entities/sign_up_params.dart';
import 'package:social_app/features/auth/domain/usecases/sign_up/firestore_create_user_usecase.dart';
import 'package:social_app/features/auth/domain/usecases/sign_up/sign_up_usecase.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final FirestoreCreateUserUseCase firestoreCreateUserUseCase;
  final SignUpUseCase signUpUseCase;

  SignUpCubit({
    required this.firestoreCreateUserUseCase,
    required this.signUpUseCase,
  }) : super(const SignUpInitial());

  void firestoreCreateUser({
    required String name,
    required String email,
    required String phone,
    required String uId,
  }) {
    firestoreCreateUserUseCase(CreateUserParams(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
    )).then((value) {
      value.fold(
        (failure) {
          print('ERROR HERE firestore');
          emit(CreateUserError(error: failure.failureMsg.toString()));
        },
        (success) {
          emit(CreateUserSuccess());
          emit(SignUpSuccess(uId: uId));
        },
      );
    });
  }

  void signUp({required SignUpParams params}) {
    emit(const SignUpLoading());

    signUpUseCase(params).then((value) {
      value.fold(
        (failure) {
          print('ERROR HERE');
          emit(SignUpError(error: failure.failureMsg.toString()));
        },
        (credential) {
          firestoreCreateUser(
            name: params.username,
            email: params.email,
            phone: params.phone,
            uId: credential.user!.uid,
          );
        },
      );
    });
  }

  bool signUpPassVisibility = true;

  void switchSignUpPassVisibility() {
    signUpPassVisibility = !signUpPassVisibility;

    emit(SwitchSignUpPassVisible(signUpPassVisibility: signUpPassVisibility));
  }

  bool confirmPassVisibility = true;

  void switchConfirmPassVisibility() {
    confirmPassVisibility = !confirmPassVisibility;

    emit(SwitchSignUpPassVisible(signUpPassVisibility: confirmPassVisibility));
  }
}
