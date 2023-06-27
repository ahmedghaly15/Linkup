import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/models/comment_model.dart';
import '../../core/models/like_model.dart';
import '../../core/models/message_model.dart';
import '../../core/models/post_model.dart';
import '../../core/models/user_model.dart';
import '/layout/cubit/states.dart';
import '/modules/chats/chats_screen.dart';
import '/modules/feeds/feeds_screen.dart';
import '/modules/profile/profile_screen.dart';
import '/modules/users/users_screen.dart';
import '../../core/utils/cache_helper.dart';
import '/shared/constants.dart';

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
      icon: Icon(Icons.home),
      label: "Home",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.chat),
      label: "Chats",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.group_rounded),
      label: "Users",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: "Profile",
    ),
  ];

  //============ For Moving Between Bottom Nav Bar Screens ============
  void changeBottomNavIndex(int index) {
    if (index == 1 || index == 2) getAllUsers();
    currentIndex = index;

    emit(ChangeBottomNavState());
  }

  UserModel? model;

  //============ Getting The Current User Data ============
  void getUserData(String? uId) {
    emit(GetUserLoadingState());

    // Storing The Current User Id
    uId = CacheHelper.getStringData(key: 'uId');

    // Getting Stored Data From Firebase
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      // Assign The Data
      model = UserModel.fromJson(value.data()!);
      emit(GetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetUserErrorState(error.toString()));
    });
  }

  File? profileImage;
  ImagePicker picker = ImagePicker();

  //============ Getting The User's Profile Image ============
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

  //============ Uploading The User's Profile Image To Firebase Storage ============
  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
    required BuildContext context,
  }) {
    emit(UploadingProfileImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(UploadProfileImageSuccessState());
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
      }).catchError((error) {
        emit(UploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(UploadProfileImageErrorState());
    });
  }

  File? coverImage;

  //============ Getting The User's Cover Image ============
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

  //============ Uploading The User's Cover Image To Firebase Storage ============
  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
    required BuildContext context,
  }) {
    emit(UploadingCoverImageLoadingState());
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
        emit(UploadCoverImageErrorState());
      });
    }).catchError((error) {
      emit(UploadCoverImageErrorState());
    });
  }

  //============ Update The Current User's Data ============
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
    // Update The Data Stored in Firebase
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uId)
        .update(userModel.toJson())
        .then((value) {
      getUserData(uId);
    }).catchError((error) {
      emit(UserUpdateErrorState());
    });
  }

  //============ Creating A New Post ============
  void createPost({
    required String date,
    required String time,
    required String text,
    String? postImage,
  }) {
    emit(CreatePostLoadingState());

    PostModel postModel = PostModel(
      name: model!.name,
      image: model!.image,
      uId: model!.uId,
      date: date,
      time: time,
      text: text,
      postImage: postImage ?? "",
      likes: 0,
      comments: 0,
      dateTime: Timestamp.now(),
    );

    // Storing The Post Info In Firebase
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

  //============ Deleting A Post ============
  void deletePost({
    required String postId,
    required BuildContext context,
  }) {
    emit(DeletePostLoadingState());

    // Delet The Post Info From Firebase
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .delete()
        .then((value) {
      emit(DeletePostSuccessState());
      buildSnackBar(
        message: "Post Deleted Successfully",
        state: SnackBarStates.success,
        context: context,
      );
    }).catchError((error) {
      print(error.toString());
      emit(DeletePostErrorState(error.toString()));
    });
  }

  File? postImage;

  //============ Getting The Post Image ============
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

  //============ Uploading The Post Image To Firebase Storage ============
  void uploadPostImage({
    required String date,
    required String time,
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
          date: date,
          time: time,
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

  //============ Removing Post Image While Creating A New Post ============
  void removePostImage() {
    postImage = null;
    emit(PostImageRemovedState());
  }

  List<PostModel> posts = [];

  //============ Getting All Posts ============
  void getPosts() {
    FirebaseFirestore.instance
        .collection('posts')
        .orderBy(
          'dateTime',
          descending: true,
        )
        .snapshots()
        .listen((event) async {
      posts = [];
      for (var element in event.docs) {
        posts.add(PostModel.fromJson(element.data()));
        var likes = await element.reference.collection('likes').get();
        var comments = await element.reference.collection('comments').get();
        await FirebaseFirestore.instance
            .collection('posts')
            .doc(element.id)
            .update({
          'likes': likes.docs.length,
          'comments': comments.docs.length,
          'postId': element.id,
        });
      }
      emit(GetPostsSuccessState());
    });
  }

  //============ Liking A Post ============
  void likePost({required String postId}) {
    LikesModel likesModel = LikesModel(
      uId: model!.uId,
      name: model!.name,
      dateTime: DateTime.now().toString(),
    );

    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(model!.uId)
        .set(likesModel.toJson())
        .then((value) {
      getPosts();
      emit(LikePostSuccessState());
    }).catchError((error) {
      emit(LikePostErrorState(error.toString()));
    });
  }

  //============ Check if The Post Is Liked By The Current User ============
  Future<bool> likedByMe({
    required String postId,
  }) async {
    bool isLikedByMe = false;
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .get()
        .then((post) async {
      var likes = await post.reference.collection('likes').get();
      for (var element in likes.docs) {
        if (element.id == model!.uId) {
          isLikedByMe = true;
        }
      }
      if (isLikedByMe == false) {
        likePost(postId: postId);
      }
      print(isLikedByMe);
      emit(LikePostSuccessState());
    });
    return isLikedByMe;
  }

  List<CommentModel> comments = [];

  //============ Creating A New Comment ============
  void typeNewComment({
    String? commentText,
    required String postId,
    required String time,
    required String date,
    Map<String, dynamic>? commentImage,
  }) {
    emit(CommentCreatedLoadingState());

    CommentModel commentModel = CommentModel(
      name: model!.name,
      image: model!.image,
      uId: model!.uId,
      commentImage: commentImage ?? {},
      commentText: commentText ?? '',
      time: time,
      date: date,
      dateTime: Timestamp.now(),
    );

    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .add(commentModel.toJson())
        .then((value) {
      getPosts();
      emit(CommentCreatedSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(CommentCreatedErrorState(error.toString()));
    });
  }

  File? commentImage;

  //============ Getting The Comment Image ============
  Future<void> getCommentImage({required ImageSource source}) async {
    final XFile? pickedImage = await picker.pickImage(source: source);
    if (pickedImage != null) {
      commentImage = File(pickedImage.path);
      emit(CommentImagePickedSuccessState());
    } else {
      print("No image selected");
      emit(CommentImagePickedErrorState());
    }
  }

  //============ Uploading The Comment Image To Firebase ============
  void uploadCommentImage({
    String? commentText,
    required String postId,
    required String time,
    required String date,
  }) {
    emit(UploadCommentImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('comments/${Uri.file(commentImage!.path).pathSegments.last}')
        .putFile(commentImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        typeNewComment(
          commentImage: {'image': value, 'height': 150},
          postId: postId,
          time: time,
          date: date,
          commentText: commentText,
        );
        emit(UploadCommentImageSuccessState());
      }).catchError((error) {
        emit(UploadCommentImageErrorState());
      });
    }).catchError((error) {
      emit(UploadCommentImageErrorState());
    });
  }

  //============ Removing The Comment Image While Creating A Comment ============
  void removeCommentImage() {
    commentImage = null;
    emit(CommentImageRemovedSuccessState());
  }

  //============ Getting All Comments ============
  void getComments({required String postId}) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .orderBy(
          'dateTime',
          descending: false,
        )
        .snapshots()
        .listen((event) {
      comments.clear();
      for (var element in event.docs) {
        comments.add(CommentModel.fromJson(element.data()));
        emit(GetCommentsSuccessState());
      }
    });
  }

  //============ When The Search Field Text Changes ============
  void onChangeText(value, text) {
    text = value;
    emit(OnChangeTextSuccessState());
  }

  List<UserModel> users = [];

  //============ Getting All Users ============
  void getAllUsers() {
    if (users.isEmpty)
      FirebaseFirestore.instance.collection('users').get().then((value) {
        for (var element in value.docs) {
          if (element.data()['uId'] != model!.uId)
            users.add(UserModel.fromJson(element.data()));
        }
        emit(GetAllUserSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(GetAllUserErrorState(error.toString()));
      });
  }

  //============ Sending A New Message ============
  void sendMessage({
    required String receiverId,
    required String receiverName,
    required String date,
    required String time,
    String? text,
    Map<String, dynamic>? messageImage,
  }) {
    MessageModel messageModel = MessageModel(
      senderId: model!.uId,
      senderName: model!.name,
      receiverId: receiverId,
      receiverName: receiverName,
      time: time,
      date: date,
      messageText: text ?? '',
      messageImage: messageImage ?? {},
      dateTime: Timestamp.now(),
    );

    // Setting up sender Chats
    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(messageModel.toJson())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
    });

    // Setting up receiver Chats
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(model!.uId)
        .collection('messages')
        .add(messageModel.toJson())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
    });
  }

  File? messageImage;

  //============ Getting A Message Image ============
  Future<void> getMessageImage({required ImageSource source}) async {
    final XFile? pickedImage = await picker.pickImage(source: source);
    if (pickedImage != null) {
      messageImage = File(pickedImage.path);
      emit(MessageImagePickedSuccessState());
    } else {
      print("No image selected");
      emit(MessageImagePickedErrorState());
    }
  }

  //============ Uploading A Message Image To Firebase ============
  void uploadMessageImage({
    String? text,
    required String receiverId,
    required String receiverName,
    required String date,
    required String time,
  }) {
    emit(UploadMessageImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('messages/${Uri.file(messageImage!.path).pathSegments.last}')
        .putFile(messageImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        sendMessage(
          receiverId: receiverId,
          receiverName: receiverName,
          date: date,
          time: time,
          messageImage: {
            'image': value,
            'height': 150,
          },
          text: text,
        );
        emit(UploadMessageImageSuccessState());
      }).catchError((error) {
        emit(UploadMessageImageErrorState());
      });
    }).catchError((error) {
      emit(UploadMessageImageErrorState());
    });
  }

  //============ Removing A Message Image While Sending A Message ============
  void removeMessageImage() {
    messageImage = null;
    emit(RemovedMessageImageSuccessState());
  }

  List<MessageModel> messages = [];

  //============ Getting All Messages ============
  void getMessages({required String receiverId}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy(
          'dateTime',
          descending: true,
        )
        .snapshots()
        .listen((event) {
      messages = [];
      for (var element in event.docs) {
        messages.add(MessageModel.fromJson(element.data()));
      }
      emit(GetMessagesSuccessState());
    });
  }

  List<UserModel> searchList = [];
  bool isSearching = false;

  //============ Inverting The Search State ============
  void invertIsSearching() {
    isSearching = !isSearching;
    emit(InvertIsSearchingSuccessState());
  }

  //============ Rebuilding The Search List ============
  void rebuildSearchList(List<UserModel> list) {
    emit(SearchListUpdateSuccessState(list));
  }
}
