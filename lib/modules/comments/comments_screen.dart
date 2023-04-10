import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/comment_model.dart';

import '../../shared/constants.dart';
import '../../styles/colors.dart';
// import '../../styles/iconbroken.dart';

class CommentsScreen extends StatelessWidget {
  final int? likes;
  final String? postId;
  final String? postUid;

  // final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();
  // bool autoFocus = true;
  // final String commentText = '';
  CommentsScreen({Key? key, this.likes, this.postId, this.postUid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? postId = this.postId;
    return Builder(builder: (context) {
      SocialAppCubit.getObject(context).getComments(postId: postId!);
      SocialAppCubit.getObject(context).getUserData(postUid);

      return BlocConsumer<SocialAppCubit, SocialAppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          SocialAppCubit cubit = SocialAppCubit.getObject(context);
          // TextEditingController commentController = TextEditingController();

          // var commentImage = CommentModel().commentImage!['image'];
          List<CommentModel> comments = cubit.comments;
          // UserModel user = cubit.model!;

          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: true,
              title: const Text("Comments"),
              leading: IconButton(
                onPressed: () {
                  comments.clear();
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  ConditionalBuilder(
                    condition: comments.isNotEmpty,
                    builder: (context) {
                      return Expanded(
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemCount: comments.length,
                          itemBuilder: (context, index) {
                            return buildCommentItem(
                              context,
                              comments[index],
                            );
                          },
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 5,
                          ),
                        ),
                      );
                    },
                    fallback: (context) {
                      return Expanded(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const <Widget>[
                              Text(
                                "No comments yet.",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  buildCommenterField(
                    commentText: commentController.text,
                    cubit: cubit,
                    postId: postId,
                    commentController: commentController,
                    commentImage: cubit.commentImage,
                    context: context,
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }

  Widget buildCommenterField({
    required String commentText,
    required TextEditingController commentController,
    required BuildContext context,
    required SocialAppCubit cubit,
    required String postId,
    File? commentImage,
  }) {
    // final GlobalKey<FormState> formKey = GlobalKey();

    return Row(
      children: <Widget>[
        Flexible(
          child: Card(
            color: Colors.grey[200],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    cubit.getCommentImage(
                      source: ImageSource.camera,
                    );
                  },
                  icon: const Icon(
                    Icons.camera_alt_rounded,
                    color: defaultColor,
                    size: 25,
                  ),
                ),
                // ============== Pick Image From Gallery Button ==============
                IconButton(
                  onPressed: () {
                    cubit.getCommentImage(
                      source: ImageSource.gallery,
                    );
                  },
                  icon: const Icon(
                    Icons.image_rounded,
                    color: defaultColor,
                    size: 25,
                  ),
                ),
                // ============== Type A New Message TextField ==============
                Expanded(
                  child: SizedBox(
                    height: 50,
                    // width: 50,
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            controller: commentController,
                            autofocus: true,
                            // autocorrect: true,
                            enableSuggestions: true,
                            textCapitalization: TextCapitalization.sentences,
                            maxLines: null,
                            cursorColor: Colors.grey,
                            decoration: const InputDecoration(
                              hintText: 'Write a comment...',
                              // hintStyle: bodyStyle3,
                              suffixIconColor: defaultColor,
                              contentPadding:
                                  EdgeInsets.only(left: 5, right: 10),
                              border: InputBorder.none,
                            ),
                            keyboardType: TextInputType.multiline,
                            onChanged: (value) {
                              cubit.onChangeText(value, commentText);
                              // cubit.changeKey(UniqueKey());
                            },
                            // validator: (value) {
                            //   if (value!.isEmpty)
                            //     return "Can't send a blank comment";
                            //   return null;
                            // },
                          ),
                          if (commentImage != null)
                            Stack(
                              alignment: AlignmentDirectional.topEnd,
                              children: <Widget>[
                                Container(
                                  height: 50,
                                  width: double.infinity,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: FileImage(commentImage),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    radius: 15,
                                    backgroundColor: Colors.white,
                                    child: IconButton(
                                      onPressed: () =>
                                          cubit.removeCommentImage(),
                                      icon: const Icon(
                                        Icons.close,
                                        color: defaultColor,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // ============== Send New Message Button ==============
        TextButton(
          onPressed: (commentText.trim().isEmpty && commentImage == null)
              ? null
              : () {
                  if (cubit.commentImage == null) {
                    cubit.typeNewComment(
                      postId: postId,
                      time: TimeOfDay.now().format(context),
                      date: getDate(),
                      commentText: commentText.trim(),
                    );
                  }
                  if (cubit.commentImage != null) {
                    cubit.uploadCommentImage(
                      postId: postId,
                      time: TimeOfDay.now().format(context),
                      date: getDate(),
                      commentText: commentText.trim(),
                    );
                  }
                  // commentText = '';
                  // commentController.clear();
                  // autoFocus = false;
                  // print(autoFocus);
                  print("before Clear()");
                  // commentController = TextEditingController();
                  commentController.clear();
                  print("After Clear()");
                  // formKey.currentState!.reset();
                  // cubit.resetCommentText(commentText);
                  cubit.removeCommentImage();
                  FocusScope.of(context).unfocus();
                  // formKey.currentState!.reset();
                },
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled)) {
                  return Colors.grey; // Set disabled color
                }
                return defaultColor; // Set enabled color
              },
            ),
            textStyle: MaterialStateProperty.all(
              const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Janna',
              ),
            ),
          ),
          //   if (formKey.currentState!.validate()) {

          // }
          child: const Text(
            "Comment",
          ),
          // icon: const Icon(Icons.send),
          // disabledColor: Colors.grey,
          // iconSize: 30,
          // color: defaultColor,
        ),
      ],
    );
  }

  Widget buildCommentItem(
    BuildContext context,
    CommentModel commentModel,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: <Widget>[
        CircleAvatar(
          backgroundImage: NetworkImage(commentModel.image!),
          radius: 20,
        ),
        // const SizedBox(width: 5),
        Flexible(
          child: Card(
            margin: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 5,
            ),
            color: Colors.grey[300],
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.only(
                bottomEnd: Radius.circular(10.0),
                bottomStart: Radius.circular(10.0),
                topEnd: Radius.circular(10.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 10,
              ),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    commentModel.name!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (commentModel.commentText != null)
                    Text(
                      commentModel.commentText!,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        height: 1,
                        letterSpacing: 0.5,
                        color: Colors.black,
                      ),
                      maxLines: null,
                    ),
                  if (commentModel.commentText != null)
                    const SizedBox(height: 5),
                  if (commentModel.commentImage!['image'] != null)
                    Container(
                      width: double.infinity,
                      height: 150,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            commentModel.commentImage!['image'],
                          ),
                        ),
                      ),
                    ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "${commentModel.date}",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Container(
                          width: 5,
                          height: 5,
                          decoration: const BoxDecoration(
                            color: Colors.black45,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Text(
                        "${commentModel.time}",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
