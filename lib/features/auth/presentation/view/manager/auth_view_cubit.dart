import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/cache_helper.dart';
import '../../../../../layout/presenetation/view/manager/app_cubit.dart';
import '/features/auth/domain/auth_repo.dart';
import 'auth_view_states.dart';

enum AuthMode { signIn, signUp }

//==================== Auth View Cubit ====================
class AuthViewCubit extends Cubit<AuthViewStates> {
  AuthViewCubit(this.authRepo) : super(AuthViewInitialState());

  //============ Getting An Object Of The Cubit ============
  static AuthViewCubit getObject(context) => BlocProvider.of(context);

  AuthRepo authRepo;

  bool passVisibility = true;
  bool confirmPassVisiblity = true;

  //============ For Signing In A User ============
  void userSignIn({
    required String email,
    required String password,
    required BuildContext context,
  }) {
    emit(SignInLoadingState());

    authRepo
        .userSignIn(
      email: email,
      password: password,
      context: context,
    )
        .then((value) {
      emit(SignInSuccessState(value.user!.uid));
      CacheHelper.saveData(key: 'uId', value: value.user!.uid);
      AppCubit.getObject(context).getUserData(value.user!.uid);
    }).catchError((error) {
      if (error is FirebaseAuthException)
        emit(SignInErrorState(error.code.toString()));
    });
  }

  //============ For Signing Up A User ============
  void userSignUp({
    required String username,
    required String email,
    required String password,
    required String phone,
    required BuildContext context,
  }) {
    emit(SignUpLoadingState());

    authRepo
        .userSignUp(
      username: username,
      email: email,
      password: password,
      phone: phone,
      context: context,
    )
        .then((value) {
      firestoreCreateUSer(
        name: username,
        email: email,
        phone: phone,
        uId: value.user!.uid,
      );
      CacheHelper.saveData(key: 'uId', value: value.user!.uid);
      AppCubit.getObject(context).getUserData(value.user!.uid);
    }).catchError((error) {
      print(error.toString());
      if (error is FirebaseAuthException)
        emit(SignUpErrorState(error.code.toString()));
    });
  }

  void firestoreCreateUSer({
    required String name,
    required String email,
    required String phone,
    required String uId,
  }) {
    authRepo
        .firestoreCreateUSer(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
    )
        .then((value) {
      emit(CreateUserSuccessState());
      emit(SignUpSuccessState(uId));
    }).catchError((error) {
      print(error.toString());
      CreateUserErrorState(error.toString());
    });
  }

  void switchPassVisibility() {
    passVisibility = !passVisibility;
    emit(SwitchPassVisibleState());
  }

  void switchConfirmPassVisibility() {
    confirmPassVisiblity = !confirmPassVisiblity;
    emit(SwitchConfirmPassVisibleState());
  }
}
