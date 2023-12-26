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
  Future<QuerySnapshot<Map<String, dynamic>>> getPosts() async {
    return await getIt
        .get<FirebaseFirestore>()
        .collection(AppStrings.posts)
        .orderBy(
          'dateTime',
          descending: true,
        )
        .get();
  }

  @override
  Future<DocumentReference<Map<String, dynamic>>> createPost({
    required CreatePostParams createPostParams,
  }) async {
    final PostModel post = PostModel(
      name: Helper.currentUser!.name,
      image: Helper.currentUser!.image,
      uId: Helper.currentUser!.uId,
      date: createPostParams.date,
      time: createPostParams.time,
      text: createPostParams.text,
      postImage: createPostParams.postImage ?? '',
      likes: 0,
      comments: 0,
      dateTime: Timestamp.now(),
    );

    return await getIt
        .get<FirebaseFirestore>()
        .collection(AppStrings.posts)
        .add(post.toJson());
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
    return await ImagePicker().pickImage(source: source);
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
      uId: Helper.currentUser!.uId,
      name: Helper.currentUser!.name,
      email: Helper.currentUser!.email,
      profileImage: Helper.currentUser!.image,
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
  Future<List<PostModel>> likedPostsByMe() async {
    List<PostModel> likedPosts = <PostModel>[];

    final posts =
        await getIt.get<FirebaseFirestore>().collection(AppStrings.posts).get();

    for (var post in posts.docs) {
      var likes = await post.reference.collection(AppStrings.likes).get();

      for (var element in likes.docs) {
        if (element.id == Helper.currentUser!.uId) {
          likedPosts.add(PostModel.fromJson(post.data()));
        }
      }
    }

    return likedPosts;
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> peopleLikeThePost({
    required String postId,
  }) {
    return FirebaseFirestore.instance
        .collection(AppStrings.posts)
        .doc(postId)
        .collection(AppStrings.likes)
        .snapshots();
  }
}