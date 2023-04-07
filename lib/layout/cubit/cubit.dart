import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/chats/chats_screen.dart';
import 'package:social_app/modules/feeds/feeds_screen.dart';
import 'package:social_app/modules/profile/profile_screen.dart';
import 'package:social_app/modules/users/users_screen.dart';
import 'package:social_app/network/local/cache_helper.dart';
import 'package:social_app/shared/constants.dart';
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
      emit(ProfileImagePickedSuccessState());
    } else {
      print("No image has been selected");
      emit(ProfileImagePickedErrorState());
    }
  }

  File? coverImage;

  Future<void> getCoverImage({required ImageSource source}) async {
    final XFile? pickedImage = await picker.pickImage(source: source);
    if (pickedImage != null) {
      coverImage = File(pickedImage.path);
      emit(CoverImagePickedSuccessState());
    } else {
      print("No image has been selected");
      emit(CoverImagePickedErrorState());
    }
  }

  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
    required BuildContext context,
  }) {
    emit(UserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUser(
          name: name,
          phone: phone,
          bio: bio,
          image: value,
        );
        buildSnackBar(
          message: "Profile Image Updated Successfully",
          state: SnackBarStates.success,
          context: context,
        );
        emit(UploadProfileImageSuccessState());
      }).catchError((error) {
        emit(UploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(UploadProfileImageErrorState());
    });
  }

  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
    required BuildContext context,
  }) {
    emit(UserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUser(
          name: name,
          phone: phone,
          bio: bio,
          cover: value,
        );
        buildSnackBar(
          message: "Cover Image Updated Successfully",
          state: SnackBarStates.success,
          context: context,
        );
        emit(UploadCoverImageSuccessState());
      }).catchError((error) {
        emit(UploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(UploadCoverImageErrorState());
    });
  }

  // void updateUserProfileAndCover({
  //   required String name,
  //   required String phone,
  //   required String bio,
  // }) {
  //   emit(UserUpdateLoadingState());

  //   if (profileImage != null) {
  //     uploadProfileImage();
  //   } else if (coverImage != null) {
  //     uploadCoverImage();
  //   } else if (profileImage != null && coverImage != null) {
  //   } else {
  //     updateUser(name: name, phone: phone, bio: bio);
  //   }
  // }

  void updateUser({
    required String name,
    required String phone,
    required String bio,
    String? cover,
    String? image,
  }) {
    UserModel userModel = UserModel(
      name: name,
      phone: phone,
      bio: bio,
      image: image ?? model!.image,
      cover: cover ?? model!.cover,
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

  File? postImage;

  Future<void> getPostImage({required ImageSource source}) async {
    final XFile? pickedImage = await picker.pickImage(source: source);
    if (pickedImage != null) {
      postImage = File(pickedImage.path);
      emit(PostImagePickedSuccessState());
    } else {
      print("No image has been selected");
      emit(PostImagePickedErrorState());
    }
  }

  void removePostImage() {
    postImage = null;
    emit(PostImageRemovedState());
  }

  void createPost({
    required String dateTime,
    required String text,
    String? postImage,
  }) {
    emit(CreatePostLoadingState());

    PostModel postModel = PostModel(
      name: model!.name,
      image: model!.image,
      uId: model!.uId,
      dateTime: dateTime,
      text: text,
      postImage: postImage ?? "",
    );

    FirebaseFirestore.instance
        .collection('posts')
        .add(postModel.toJson())
        .then((value) {
      emit(CreatePostSuccessState());
      text = '';
      postImage = null;
    }).catchError((error) {
      print(error.toString());
      emit(CreatePostErrorState(error.toString()));
    });
  }

  void uploadPostImage({
    required String dateTime,
    required String text,
  }) {
    emit(CreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createPost(
          dateTime: dateTime,
          text: text,
          postImage: value,
        );
        emit(UploadPostImageSuccessState());
        text = '';
        postImage = null;
      }).catchError((error) {
        print(error.toString());
        emit(UploadPostImageErrorState());
      });
    }).catchError((error) {
      print(error.toString());
      emit(UploadPostImageErrorState());
    });
  }

  List<PostModel> posts = [];
  List<String> postsIds = [];
  List<int> likes = [];

  void getPosts() {
    emit(GetPostsLoadingState());
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      for (var doc in value.docs) {
        doc.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);
          postsIds.add(doc.id);
          posts.add(PostModel.fromJson(doc.data()));
        }).catchError((error) {
          emit(GetPostsErrorState(error.toString()));
        });
      }
      emit(GetPostsSuccessState());
    }).catchError((error) {
      emit(GetPostsErrorState(error.toString()));
    });
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(model!.uId)
        .set({
      'like': true,
    }).then((value) {
      emit(LikePostSuccessState());
    }).catchError((error) {
      emit(LikePostErrorState(error.toString()));
    });
  }
}
