import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/models/comment_model.dart';
import '../../../../core/models/like_model.dart';
import '../../../../core/models/message_model.dart';
import '../../../../core/models/post_model.dart';
import '../../../../core/models/user_model.dart';
import '../../../../core/utils/cache_helper.dart';
import '../../../../core/utils/helper.dart';
import '../../../../features/chat/presentation/views/chats_view.dart';
import '../../../../features/feeds/presentation/views/feeds_view.dart';
import '../../../../features/profile/presentation/views/me_view.dart';
import '../../../../features/users/presentation/views/users_view.dart';
import '../../../domain/app_repo.dart';
import 'app_states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit(this.appRepo) : super(AppInitialState());

  static AppCubit getObject(context) => BlocProvider.of(context);

  AppRepo appRepo;

  int currentIndex = 0;

  //============ Bottom Nav Bar Screens ============
  List<Widget> bottomNavScreens = [
    const FeedsView(),
    const ChatsView(),
    const UsersView(),
    const MeView(),
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
      label: "Me",
    ),
  ];

  void changeBottomNavIndex(int index) {
    if (index == 1 || index == 2) getAllUsers();
    currentIndex = index;

    emit(ChangeBottomNavState());
  }

  // =============== Users Logic ===============
  List<UserModel> users = [];

  void getAllUsers() {
    if (users.isEmpty) {
      appRepo.getAllUsers().then((value) {
        for (var element in value.docs) {
          if (element.data()['uId'] != Helper.model!.uId)
            users.add(UserModel.fromJson(element.data()));
        }
        emit(GetAllUserSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(GetAllUserErrorState(error.toString()));
      });
    }
  }

  void getUserData(String? uId) {
    emit(GetUserLoadingState());

    // Storing The Current User Id
    uId = CacheHelper.getStringData(key: 'uId');

    appRepo.getUserData(uId).then((value) {
      Helper.model = UserModel.fromJson(value.data()!);
      emit(GetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetUserErrorState(error.toString()));
    });
  }

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
      image: image ?? Helper.model!.image,
      cover: cover ?? Helper.model!.cover,
      email: Helper.model!.email,
      uId: Helper.model!.uId,
      isEmailVerified: false,
    );

    appRepo.updateUser(userModel: userModel).then((value) {
      getUserData(Helper.uId);
    }).catchError((error) {
      emit(UserUpdateErrorState());
    });
  }

  // =============== ProfileImage Logic ===============
  File? profileImage;
  ImagePicker picker = ImagePicker();

  Future<void> getProfileImage({required ImageSource source}) async {
    await appRepo.getProfileImage(source: source).then((value) {
      if (value != null) {
        profileImage = File(value.path);
        emit(ProfileImagePickedSuccessState());
      } else {
        print("No image selected");
        emit(ProfileImagePickedErrorState());
      }
    });
  }

  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
    required BuildContext context,
  }) {
    emit(UploadingProfileImageLoadingState());
    appRepo.uploadProfileImage(profileImage: profileImage).then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(UploadProfileImageSuccessState());
        updateUser(
          name: name,
          phone: phone,
          bio: bio,
          image: value,
        );
        Helper.buildSnackBar(
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

  // =============== CoverImage Logic ===============
  File? coverImage;

  Future<void> getCoverImage({required ImageSource source}) async {
    await appRepo.getCoverImage(source: source).then((value) {
      if (value != null) {
        coverImage = File(value.path);
        emit(CoverImagePickedSuccessState());
      } else {
        print("No image selected");
        emit(CoverImagePickedErrorState());
      }
    });
  }

  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
    required BuildContext context,
  }) {
    emit(UploadingCoverImageLoadingState());
    appRepo.uploadCoverImage(coverImage: coverImage).then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUser(
          name: name,
          phone: phone,
          bio: bio,
          cover: value,
        );
        Helper.buildSnackBar(
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

  // =============== Posts Logic ===============
  void createPost({
    required String date,
    required String time,
    required String text,
    String? postImage,
  }) {
    emit(CreatePostLoadingState());

    PostModel postModel = PostModel(
      name: Helper.model!.name,
      image: Helper.model!.image,
      uId: Helper.model!.uId,
      date: date,
      time: time,
      text: text,
      postImage: postImage ?? "",
      likes: 0,
      comments: 0,
      dateTime: Timestamp.now(),
    );

    // Storing The Post Info In Firebase
    appRepo.createPost(postModel: postModel).then((value) {
      emit(CreatePostSuccessState());
      text = '';
      postImage = null;
    }).catchError((error) {
      print(error.toString());
      emit(CreatePostErrorState(error.toString()));
    });
  }

  void deletePost({
    required String postId,
    required BuildContext context,
  }) {
    emit(DeletePostLoadingState());

    // Delet The Post Info From Firebase
    appRepo.deletePost(postId: postId).then((value) {
      emit(DeletePostSuccessState());
      Helper.buildSnackBar(
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

  Future<void> getPostImage({required ImageSource source}) async {
    await appRepo.getPostImage(source: source).then((value) {
      if (value != null) {
        postImage = File(value.path);
        emit(PostImagePickedSuccessState());
      } else {
        print("No image has been selected");
        emit(PostImagePickedErrorState());
      }
    });
  }

  void uploadPostImage({
    required String date,
    required String time,
    required String text,
  }) {
    emit(CreatePostLoadingState());
    appRepo.uploadPostImage(postImage: postImage).then((value) {
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

  void removePostImage() {
    postImage = null;
    emit(PostImageRemovedState());
  }

  List<PostModel> posts = [];

  void getPosts() {
    appRepo.getPosts().listen((event) async {
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

  void likePost({required String postId}) {
    LikesModel likesModel = LikesModel(
      uId: Helper.model!.uId,
      name: Helper.model!.name,
      dateTime: DateTime.now().toString(),
    );

    appRepo
        .likePost(
      likesModel: likesModel,
      postId: postId,
    )
        .then((value) {
      getPosts();
      emit(LikePostSuccessState());
    }).catchError((error) {
      emit(LikePostErrorState(error.toString()));
    });
  }

  Future<bool> likedByMe({required String postId}) async {
    bool isLikedByMe = false;
    appRepo.likeByMe(postId: postId).then((post) async {
      var likes = await post.reference.collection('likes').get();
      for (var element in likes.docs) {
        if (element.id == Helper.model!.uId) {
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

  // =============== Comments Logic ===============
  void typeNewComment({
    String? commentText,
    required String postId,
    required String time,
    required String date,
    Map<String, dynamic>? commentImage,
  }) {
    emit(CommentCreatedLoadingState());

    CommentModel commentModel = CommentModel(
      name: Helper.model!.name,
      image: Helper.model!.image,
      uId: Helper.model!.uId,
      commentImage: commentImage ?? {},
      commentText: commentText ?? '',
      time: time,
      date: date,
      dateTime: Timestamp.now(),
    );

    appRepo
        .typeNewComment(
      commentModel: commentModel,
      postId: postId,
    )
        .then((value) {
      getPosts();
      emit(CommentCreatedSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(CommentCreatedErrorState(error.toString()));
    });
  }

  File? commentImage;

  Future<void> getCommentImage({required ImageSource source}) async {
    await appRepo.getCommentImage(source: source).then((value) {
      if (value != null) {
        commentImage = File(value.path);
        emit(CommentImagePickedSuccessState());
      } else {
        print("No image selected");
        emit(CommentImagePickedErrorState());
      }
    });
  }

  void uploadCommentImage({
    String? commentText,
    required String postId,
    required String time,
    required String date,
  }) {
    emit(UploadCommentImageLoadingState());

    appRepo.uploadCommentImage(commentImage: commentImage).then((value) {
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

  void removeCommentImage() {
    commentImage = null;
    emit(CommentImageRemovedSuccessState());
  }

  List<CommentModel> comments = [];

  void getComments({required String postId}) {
    appRepo.getComments(postId: postId).listen((event) {
      comments.clear();
      for (var element in event.docs) {
        comments.add(CommentModel.fromJson(element.data()));
        emit(GetCommentsSuccessState());
      }
    });
  }

  // =============== Chat & Messages Logic ===============
  void sendMessage({
    required String receiverId,
    required String receiverName,
    required String date,
    required String time,
    String? text,
    Map<String, dynamic>? messageImage,
  }) {
    MessageModel messageModel = MessageModel(
      senderId: Helper.model!.uId,
      senderName: Helper.model!.name,
      receiverId: receiverId,
      receiverName: receiverName,
      time: time,
      date: date,
      messageText: text ?? '',
      messageImage: messageImage ?? {},
      dateTime: Timestamp.now(),
    );

    // Setting up sender Chats
    appRepo
        .settingUpSenderChat(
      receiverId: receiverId,
      messageModel: messageModel,
    )
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
    });

    // Setting up receiver Chats
    appRepo
        .settingUpReceiverChat(
      receiverId: receiverId,
      messageModel: messageModel,
    )
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
    });
  }

  File? messageImage;

  Future<void> getMessageImage({required ImageSource source}) async {
    await appRepo.getMessageImage(source: source).then((value) {
      if (value != null) {
        messageImage = File(value.path);
        emit(MessageImagePickedSuccessState());
      } else {
        print("No image selected");
        emit(MessageImagePickedErrorState());
      }
    });
  }

  void uploadMessageImage({
    String? text,
    required String receiverId,
    required String receiverName,
    required String date,
    required String time,
  }) {
    emit(UploadMessageImageLoadingState());
    appRepo.uploadMessageImage(messageImage: messageImage).then((value) {
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

  void removeMessageImage() {
    messageImage = null;
    emit(RemovedMessageImageSuccessState());
  }

  List<MessageModel> messages = [];

  void getMessages({required String receiverId}) {
    appRepo.getMessages(receiverId: receiverId).listen((event) {
      messages = [];
      for (var element in event.docs) {
        messages.add(MessageModel.fromJson(element.data()));
      }
      emit(GetMessagesSuccessState());
    });
  }

  void onChangeText(value, text) {
    text = value;
    emit(OnChangeTextSuccessState());
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
