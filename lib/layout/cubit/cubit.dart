import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/chats/chats_screen.dart';
import 'package:social_app/modules/feeds/feeds_screen.dart';
import 'package:social_app/modules/settings/settings_screen.dart';
import 'package:social_app/modules/users/users_screen.dart';
import 'package:social_app/shared/constants.dart';
import 'package:social_app/styles/iconbroken.dart';

import '../../styles/colors.dart';

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
    const SettingsScreen(),
  ];

  //============ Bottom Nav Bar Content ============
  List<BottomNavigationBarItem> bottomNavItems = const [
    BottomNavigationBarItem(
      icon: Icon(IconBroken.home),
      label: "Home",
      backgroundColor: defaultColor,
    ),
    BottomNavigationBarItem(
      icon: Icon(IconBroken.chat),
      label: "Chats",
      backgroundColor: defaultColor,
    ),
    BottomNavigationBarItem(
      icon: Icon(IconBroken.location),
      label: "Users",
      backgroundColor: defaultColor,
    ),
    BottomNavigationBarItem(
      icon: Icon(IconBroken.setting),
      label: "Settings",
      backgroundColor: defaultColor,
    ),
  ];

  //============ App Bar Titles Of Bottom Nav Bar Screens ============
  List<String> titles = [
    'News Feed',
    'Chats',
    'Users',
    'Settings',
  ];

  //============ For Moving Between Bottom Nav Bar Screens ============
  void changeBottomNavIndex(int index) {
    currentIndex = index;

    emit(ChangeBottomNavState());
  }

  UserModel? model;

  void getUserData() {
    emit(GetUserLoadingState());

    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      // print(value.data());
      model = UserModel.fromJson(value.data()!);
      emit(GetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetUserErrorState(error.toString()));
    });
  }
}
