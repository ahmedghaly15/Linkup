import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/core/entities/no_params.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/features/feeds/data/models/post_model.dart';
import 'package:social_app/features/feeds/domain/entities/create_post_params.dart';
import 'package:social_app/features/feeds/domain/usecases/create_post.dart';
import 'package:social_app/features/feeds/domain/usecases/delete_post.dart';
import 'package:social_app/features/feeds/domain/usecases/get_post_image.dart';
import 'package:social_app/features/feeds/domain/usecases/get_posts.dart';
import 'package:social_app/features/feeds/domain/usecases/upload_post_image.dart';

part 'feeds_state.dart';

class FeedsCubit extends Cubit<FeedsState> {
  final GetPostsUseCase getPostsUseCase;
  final CreatePostUseCase createPostUseCase;
  final DeletePostUseCase deletePostUseCase;
  final GetPostImageUseCase getPostImageUseCase;
  final UploadPostImageUseCase uploadPostImageUseCase;

  FeedsCubit({
    required this.getPostsUseCase,
    required this.createPostUseCase,
    required this.deletePostUseCase,
    required this.getPostImageUseCase,
    required this.uploadPostImageUseCase,
  }) : super(const FeedsInitial());

  void createPost({required CreatePostParams createPostParams}) {
    emit(const CreatePostLoading());

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

    createPostUseCase(post).then((value) {
      value.fold(
        (failure) =>
            emit(CreatePostError(error: failure.failureMsg.toString())),
        (success) {
          postImage = null;
          getPosts();
          emit(CreatePostSuccess(post: post));
        },
      );
    });
  }

  void deletePost({required String postId}) {
    emit(const DeletePostLoading());

    deletePostUseCase(postId).then((value) {
      value.fold(
        (failure) =>
            emit(DeletePostError(error: failure.failureMsg.toString())),
        (success) {
          getPosts();
          emit(const DeletePostSuccess());
        },
      );
    });
  }

  List<PostModel> posts = [];

  void getPosts() {
    emit(const GetPostsLoading());
    getPostsUseCase(const NoParams()).listen((event) async {
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

      emit(GetPostsSuccess(posts: posts));
    }).onError((error) {
      emit(GetPostsError(error: error.toString()));
    });
  }

  File? postImage;

  void getPostImage({required ImageSource source}) {
    getPostImageUseCase(source).then((value) {
      value.fold(
        (failure) =>
            emit(PostImagePickedError(error: failure.failureMsg.toString())),
        (result) {
          if (result != null) {
            postImage = File(result.path);

            emit(PostImagePickedSuccess(postImage: postImage!));
          }
        },
      );
    });
  }

  void uploadPostImage({required CreatePostParams createPostParams}) {
    emit(const UploadPostImageLoading());

    uploadPostImageUseCase(postImage).then((value) {
      value.fold(
        (failure) =>
            emit(UploadPostImageError(error: failure.failureMsg.toString())),
        (result) {
          result.ref.getDownloadURL().then((value) {
            createPost(
              createPostParams: CreatePostParams(
                date: createPostParams.date,
                time: createPostParams.time,
                text: createPostParams.text,
                postImage: value,
              ),
            );
            postImage = null;
            emit(UploadPostImageSuccess(imageUrl: value));
          }).catchError((error) {
            emit(UploadPostImageError(error: error.toString()));
          });
        },
      );
    });
  }

  void removePostImage() {
    postImage = null;
    emit(const PostImageRemoved());
  }
}
