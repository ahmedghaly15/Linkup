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
  }) {
    emit(SignInLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
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
  }) {
    emit(SignUpLoadingState());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      // print(value.user);
      // print(value.user!.uid);
      firestoreCreateUSer(
        name: username,
        email: email,
        phone: phone,
        uId: value.user!.uid,
      );
      // emit(SignUpSuccessState());
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
          'https://media.istockphoto.com/id/1131164548/vector/avatar-5.jpg?s=612x612&w=0&k=20&c=CK49ShLJwDxE4kiroCR42kimTuuhvuo2FH5y_6aSgEo=',
      bio: 'Write your bio...',
      cover:
          'https://img.freepik.com/premium-photo/woman-praying-free-bird-enjoying-nature-sunset-background-hope-concept_34200-192.jpg?size=626&ext=jpg&ga=GA1.2.825316313.1674289475&semt=ais',
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
