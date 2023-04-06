import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/chats/chats_screen.dart';
import 'package:social_app/modules/feeds/feeds_screen.dart';
import 'package:social_app/modules/profile/profile_screen.dart';
import 'package:social_app/modules/users/users_screen.dart';
import 'package:social_app/network/local/cache_helper.dart';
import 'package:social_app/styles/iconbroken.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialAppCubit extends Cubit<SocialAppStates> {
  SocialAppCubit() : super(SocialAppInitialState());

  static SocialAppCubit getObject(context) => BlocProvider.of(context);

  //============ Current Index Of Bottom Nav Bar Item ============
  int currentIndex = 0;

  //============ Bottom Nav Bar Screens ============
  List<Widget> bottomNavScreens = [
    const FeedsScreen(),
    const ChatsScreen(),
    const UsersScreen(),
    const ProfileScreen(),
  ];

  //============ Bottom Nav Bar Content ============
  List<BottomNavigationBarItem> bottomNavItems = const [
    BottomNavigationBarItem(
      icon: Icon(IconBroken.home),
      label: "Home",
      // backgroundColor: defaultColor,
    ),
    BottomNavigationBarItem(
      icon: Icon(IconBroken.chat),
      label: "Chats",
      // backgroundColor: defaultColor,
    ),
    BottomNavigationBarItem(
      icon: Icon(IconBroken.location),
      label: "Users",
      // backgroundColor: defaultColor,
    ),
    BottomNavigationBarItem(
      icon: Icon(IconBroken.profile),
      label: "Profile",
      // backgroundColor: defaultColor,
    ),
  ];

  //============ App Bar Titles Of Bottom Nav Bar Screens ============
  // List<String> titles = [
  //   'News Feed',
  //   'Chats',
  //   'Users',
  //   'Profile',
  // ];

  //============ For Moving Between Bottom Nav Bar Screens ============
  void changeBottomNavIndex(int index) {
    currentIndex = index;

    emit(ChangeBottomNavState());
  }

  UserModel? model;

  void getUserData(String? uId) {
    emit(GetUserLoadingState());

    uId = CacheHelper.getStringData(key: 'uId');

    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      // print(value.data());
      model = UserModel.fromJson(value.data()!);
      emit(GetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetUserErrorState(error.toString()));
    });
  }

  File? profileImage;
  ImagePicker picker = ImagePicker();

  Future<void> getProfileImage({required ImageSource source}) async {
    final XFile? pickedImage = await picker.pickImage(source: source);
    if (pickedImage != null) {
      profileImage = File(pickedImage.path);
      emit(GetProfileImageSuccessState());
    } else {
      print("No image has been selected");
      emit(GetProfileImageErrorState());
    }
  }

  File? coverImage;

  Future<void> getCoverImage({required ImageSource source}) async {
    final XFile? pickedImage = await picker.pickImage(source: source);
    if (pickedImage != null) {
      coverImage = File(pickedImage.path);
      emit(GetCoverImageSuccessState());
    } else {
      print("No image has been selected");
      emit(GetCoverImageErrorState());
    }
  }

  String profileImageUrl = '';

  void uploadProfileImage() {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        profileImageUrl = value;
        print(value);
        emit(UploadProfileImageSuccessState());
      }).catchError((error) {
        emit(UploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(UploadProfileImageErrorState());
    });
  }

  String coverImageUrl = '';

  void uploadCoverImage() {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        coverImageUrl = value;
        print(value);
        emit(UploadCoverImageSuccessState());
      }).catchError((error) {
        emit(UploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(UploadCoverImageErrorState());
    });
  }

  void updateUserProfileAndCover({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(UserUpdateLoadingState());

    if (profileImage != null) {
      uploadProfileImage();
    } else if (coverImage != null) {
      uploadCoverImage();
    } else if (profileImage != null && coverImage != null) {
    } else {
      updateUser(name: name, phone: phone, bio: bio);
    }
  }

  void updateUser({
    required String name,
    required String phone,
    required String bio,
  }) {
    UserModel userModel = UserModel(
      name: name,
      phone: phone,
      bio: bio,
      image: model!.image,
      cover: model!.cover,
      email: model!.email,
      uId: model!.uId,
      isEmailVerified: false,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uId)
        .update(userModel.toJson())
        .then((value) {
      getUserData(userModel.uId);
    }).catchError((error) {
      emit(UserUpdateErrorState());
    });
  }
}
