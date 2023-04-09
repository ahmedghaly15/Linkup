import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/comment_model.dart';
import 'package:social_app/models/user_model.dart';

import '../../shared/constants.dart';
import '../../styles/colors.dart';
import '../../styles/iconbroken.dart';

class CommentsScreen extends StatelessWidget {
  final int? likes;
  final String? postId;
  final String? postUid;
  const CommentsScreen({super.key, this.likes, this.postId, this.postUid});

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
          TextEditingController commentController = TextEditingController();
          // var commentImage = CommentModel().commentImage!['image'];
          List<CommentModel> comments = cubit.comments;
          // UserModel user = cubit.model!;

          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: true,
                title: const Text("Comments"),
                leading: IconButton(
                  onPressed: () {
                    comments.clear();
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    IconBroken.arrowLeft_2,
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
                                cubit.model!,
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 10,
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
                    buildSenderField(
                      cubit: cubit,
                      postId: postId,
                      commentComtroller: commentController,
                      commentImage: cubit.commentImage,
                      context: context,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }

  Widget buildSenderField({
    required TextEditingController commentComtroller,
    required BuildContext context,
    required SocialAppCubit cubit,
    required String postId,
    File? commentImage,
  }) =>
      Row(
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
                      SocialAppCubit.getObject(context).getCommentImage(
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
                      SocialAppCubit.getObject(context).getCommentImage(
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
                    child: TextField(
                      controller: commentComtroller,
                      autocorrect: true,
                      enableSuggestions: true,
                      textCapitalization: TextCapitalization.sentences,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      cursorColor: Colors.grey,
                      decoration: const InputDecoration(
                        hintText: 'Type a message...',
                        // hintStyle: bodyStyle3,
                        suffixIconColor: defaultColor,
                        contentPadding: EdgeInsets.only(left: 10.0),
                        border: InputBorder.none,
                      ),
                      onChanged: (val) {
                        // setState(() {
                        //   _enteredMsg = val;
                        // });
                      },
                    ),
                  ),
                  if (commentImage != null)
                    Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: <Widget>[
                        Container(
                          height: 150,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(
                              image: FileImage(commentImage),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.white,
                            child: IconButton(
                              onPressed: () => SocialAppCubit.getObject(context)
                                  .removeCommentImage(),
                              icon: const Icon(
                                Icons.close,
                                color: defaultColor,
                                size: 25,
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
          // ============== Send New Message Button ==============
          IconButton(
            onPressed: () {
              if (commentComtroller.text.trim().isEmpty) null;
              if (cubit.commentImage == null) {
                cubit.typeNewComment(
                  postId: postId,
                  time: TimeOfDay.now().format(context),
                  date: getDate(),
                  commentText: commentComtroller.text.trim(),
                );
              }
              if (cubit.commentImage != null) {
                cubit.uploadCommentImage(
                  postId: postId,
                  time: TimeOfDay.now().format(context),
                  date: getDate(),
                  commentText: commentComtroller.text.trim(),
                );
              }
              commentComtroller.clear();
              cubit.removeCommentImage();
            },
            icon: const Icon(Icons.send),
            disabledColor: Colors.grey,
            iconSize: 30,
            color: defaultColor,
          ),
        ],
      );

  Widget buildCommentItem(
    BuildContext context,
    CommentModel commentModel,
    UserModel userModel,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: <Widget>[
        CircleAvatar(
          backgroundImage: NetworkImage(userModel.image!),
          radius: 20,
        ),
        // const SizedBox(width: 5),
        Flexible(
          child: Card(
            margin: const EdgeInsets.symmetric(
              horizontal: 10,
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
                    userModel.name!,
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
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            commentModel.commentImage!['image'],
                          ),
                        ),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(start: 8.0),
                    child: Text(
                      "${commentModel.date} at ${commentModel.time}",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
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
