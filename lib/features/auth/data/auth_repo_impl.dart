import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../core/models/user_model.dart';
import '../domain/auth_repo.dart';

class AuthRepoImpl extends AuthRepo {
  @override
  Future<UserCredential> userSignIn({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    return await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<UserCredential> userSignUp({
    required String username,
    required String email,
    required String password,
    required String phone,
    required BuildContext context,
  }) async {
    return await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> firestoreCreateUSer({
    required String name,
    required String email,
    required String phone,
    required String uId,
  }) async {
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
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(userModel.toJson());
  }
}
