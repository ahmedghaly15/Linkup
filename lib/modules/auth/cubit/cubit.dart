import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/user_model.dart';
// import '/models/sign_in_model.dart';
import '/modules/auth/cubit/states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import '/network/end_points.dart';
// import '/network/remote/dio_helper.dart';

// For Toggling Between Sign In Screen & Sign Up Screen
enum AuthMode { signIn, signUp }

//==================== Auth Screen Cubit ====================
class AuthScreenCubit extends Cubit<AuthScreenStates> {
  AuthScreenCubit() : super(AuthScreenInitialState());

  //============ Getting An Object Of The Cubit ============
  static AuthScreenCubit getObject(context) => BlocProvider.of(context);

  // SignInModel? signInModel;

  //============ For Signing In A User ============
  void userSignIn({
    required String email,
    required String password,
    // required BuildContext context,
  }) {
    emit(SignInLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      // SocialAppCubit.getObject(context).getUserData(value.user!.uid);
      print(value.user!.email);
      print(value.user!.uid);
      emit(SignInSuccessState(value.user!.uid));
    }).catchError((error) {
      emit(SignInErrorState(error.toString()));
    });
  }

  //============ For Signing Up A User ============
  void userSignUp({
    required String username,
    required String email,
    required String password,
    required String phone,
    // required BuildContext context,
  }) {
    emit(SignUpLoadingState());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      // SocialAppCubit.getObject(context).getUserData(value.user!.uid);

      // print(value.user);
      // print(value.user!.uid);
      firestoreCreateUSer(
        name: username,
        email: email,
        phone: phone,
        uId: value.user!.uid,
      );
      // emit(SignUpSuccessState(value.user!.uid));
    }).catchError((error) {
      print(error.toString());
      emit(SignUpErrorState(error.toString()));
    });
  }

  void firestoreCreateUSer({
    required String name,
    required String email,
    required String phone,
    required String uId,
  }) {
    UserModel userModel = UserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      isEmailVerified: false,
      image:
          'https://img.freepik.com/free-icon/user_318-159711.jpg?size=626&ext=jpg&ga=GA1.2.825316313.1674289475&semt=ais',
      bio: 'Write your bio...',
      cover: 'https://notepd.s3.amazonaws.com/default-cover.png',
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(userModel.toJson())
        .then((value) {
      emit(CreateUserSuccessState());
      emit(SignUpSuccessState(uId));
    }).catchError((error) {
      print(error.toString());
      CreateUserErrorState(error.toString());
    });
  }
}
