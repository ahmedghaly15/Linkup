import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '/layout/cubit/cubit.dart';
import '/layout/cubit/states.dart';
import '/models/comment_model.dart';
import '/shared/constants.dart';
import '/styles/thems.dart';

class CommentsScreen extends StatelessWidget {
  final int? likes;
  final String? postId;
  final String? postUid;

  final TextEditingController commentController = TextEditingController();

  CommentsScreen({Key? key, this.likes, this.postId, this.postUid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? postId = this.postId;
    return Builder(builder: (context) {
      // Getting The Comments And The User's Data
      SocialAppCubit.getObject(context).getComments(postId: postId!);
      SocialAppCubit.getObject(context).getUserData(postUid);

      return BlocConsumer<SocialAppCubit, SocialAppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          SocialAppCubit cubit = SocialAppCubit.getObject(context);
          List<CommentModel> comments = cubit.comments;

          return Scaffold(
            backgroundColor: context.theme.colorScheme.background,
            appBar: AppBar(
              backgroundColor: context.theme.colorScheme.background,
              automaticallyImplyLeading: true,
              title: Text(
                "Comments",
                style: appBarTitleStyle,
              ),
              leading: IconButton(
                onPressed: () {
                  comments.clear();
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Get.isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              systemOverlayStyle: SystemUiOverlayStyle(
                systemNavigationBarColor:
                    Get.isDarkMode ? darkGreyClr : Colors.white,
                statusBarColor: Get.isDarkMode ? darkGreyClr : Colors.white,
                statusBarBrightness:
                    Get.isDarkMode ? Brightness.light : Brightness.dark,
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
                            children: <Widget>[
                              Text(
                                "No comments yet.",
                                style: TextStyle(
                                  color: Get.isDarkMode
                                      ? Colors.white
                                      : Colors.black,
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
    return Row(
      children: <Widget>[
        Flexible(
          child: Card(
            color:
                Get.isDarkMode ? darkGreyClr.withOpacity(0) : Colors.grey[200],
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
                // ============== Type A New Comment TextField ==============
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            controller: commentController,
                            autofocus: true,
                            enableSuggestions: true,
                            textCapitalization: TextCapitalization.sentences,
                            maxLines: null,
                            cursorColor:
                                Get.isDarkMode ? Colors.white60 : Colors.black,
                            style: bodySmall.copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              height: 1.5,
                              letterSpacing: 0.8,
                            ),
                            decoration: const InputDecoration(
                              hintText: 'Write a comment...',
                              suffixIconColor: defaultColor,
                              contentPadding:
                                  EdgeInsets.only(left: 5, right: 10),
                              border: InputBorder.none,
                            ),
                            keyboardType: TextInputType.multiline,
                            onChanged: (value) {
                              cubit.onChangeText(value, commentText);
                            },
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
                  commentController.clear();
                  cubit.removeCommentImage();
                  FocusScope.of(context).unfocus();
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
            textStyle: MaterialStateProperty.all(bodySmall),
          ),
          child: const Text(
            "Comment",
          ),
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
        Flexible(
          child: ChatBubble(
            clipper: ChatBubbleClipper1(type: BubbleType.receiverBubble),
            margin: const EdgeInsets.symmetric(
              horizontal: 2,
              vertical: 5,
            ),
            backGroundColor: Get.isDarkMode
                ? darkGreyClr.withOpacity(0.9)
                : const Color(0xffE7E7ED),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.65,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      commentModel.name!,
                      style: bodySmall.copyWith(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (commentModel.commentText != null)
                      const SizedBox(height: 10),
                    if (commentModel.commentText != null)
                      Text(
                        commentModel.commentText!,
                        style: bodySmall.copyWith(
                          fontWeight: FontWeight.w500,
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
                            image: NetworkImage(
                              commentModel.commentImage!['image'],
                            ),
                          ),
                        ),
                      ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          "${commentModel.date}",
                          style: caption,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Container(
                            width: 5,
                            height: 5,
                            decoration: BoxDecoration(
                              color:
                                  Get.isDarkMode ? Colors.grey : Colors.black45,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        Text(
                          "${commentModel.time}",
                          style: caption,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
