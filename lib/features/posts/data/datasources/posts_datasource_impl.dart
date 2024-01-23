import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/core/utils/app_strings.dart';
import 'package:social_app/features/posts/data/datasources/posts_datasource.dart';
import 'package:social_app/features/posts/data/models/like_model.dart';
import 'package:social_app/features/posts/data/models/post_model.dart';
import 'package:social_app/features/posts/domain/entities/create_post_params.dart';
import 'package:social_app/service_locator.dart';

class PostsDataSourceImpl implements PostsDataSource {
  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getPosts() {
    return getIt
        .get<FirebaseFirestore>()
        .collection(AppStrings.posts)
        .orderBy(
          'dateTime',
          descending: true,
        )
        .snapshots();
  }

  @override
  Future<DocumentReference<Map<String, dynamic>>> createPost({
    required CreatePostParams createPostParams,
  }) async {
    final PostModel post = PostModel(
      user: Helper.currentUser,
      date: createPostParams.date,
      time: createPostParams.time,
      text: createPostParams.text,
      postImage: createPostParams.postImage ?? '',
      dateTime: Timestamp.now(),
    );

    // final DocumentReference<Map<String, dynamic>> userPost = await getIt
    //     .get<FirebaseFirestore>()
    //     .collection(AppStrings.users)
    //     .doc(Helper.uId)
    //     .collection(AppStrings.posts)
    //     .add(post.toJson());

    final DocumentReference<Map<String, dynamic>> documentReference =
        await getIt
            .get<FirebaseFirestore>()
            .collection(AppStrings.posts)
            .add(post.toJson());

    final String postId = documentReference.id;
    // final String userPostId = userPost.id;

    await documentReference.update({'postId': postId});

    // await userPost.update({'postId': userPostId});

    return documentReference;
  }

  @override
  Future<void> deletePost({required String postId}) async {
    await getIt
        .get<FirebaseFirestore>()
        .collection(AppStrings.posts)
        .doc(postId)
        .delete();
  }

  @override
  Future<XFile?> getPostImage({required ImageSource source}) async {
    return await getIt.get<ImagePicker>().pickImage(source: source);
  }

  @override
  Future<TaskSnapshot> uploadPostImage({File? postImage}) async {
    return await firebase_storage.FirebaseStorage.instance
        .ref()
        .child(
            '${AppStrings.posts}/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage);
  }

  @override
  Future<void> likePost({required String postId}) async {
    final LikeModel likeModel = LikeModel(
      user: Helper.currentUser,
      dateTime: DateTime.now().toString(),
    );

    return await getIt
        .get<FirebaseFirestore>()
        .collection(AppStrings.posts)
        .doc(postId)
        .collection(AppStrings.likes)
        .doc(Helper.currentUser!.uId)
        .set(likeModel.toJson());
  }

  @override
  Future<void> unLikePost({required String postId}) async {
    return await getIt
        .get<FirebaseFirestore>()
        .collection(AppStrings.posts)
        .doc(postId)
        .collection(AppStrings.likes)
        .doc(Helper.currentUser!.uId)
        .delete();
  }

  @override
  Stream<bool> likedPostsByMe({required String postId}) {
    return getIt
        .get<FirebaseFirestore>()
        .collection(AppStrings.posts)
        .doc(postId)
        .collection(AppStrings.likes)
        .snapshots()
        .map((querySnapshot) {
      for (var item in querySnapshot.docs) {
        if (item.data()['user']['uId'] == Helper.currentUser!.uId) {
          return true;
        }
      }
      return false;
    });
  }
}
