import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/models/comment_model.dart';
import '../../../../core/utils/size_config.dart';
import '../../../../layout/presenetation/view/manager/app_cubit.dart';
import '/features/feeds/presentation/widgets/comment_item.dart';
import '/features/feeds/presentation/widgets/commenter_field.dart';

class CommentsViewBody extends StatelessWidget {
  const CommentsViewBody({
    Key? key,
    required this.comments,
    required this.commentText,
    required this.commentController,
    required this.cubit,
    required this.postId,
    required this.commentImage,
  }) : super(key: key);

  final List<CommentModel> comments;
  final String commentText;
  final File? commentImage;
  final TextEditingController commentController;
  final AppCubit cubit;
  final String postId;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                    return CommentItem(
                      commentModel: comments[index],
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(
                    height: SizeConfig.screenHeight! * 0.006,
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
                          color: Get.isDarkMode ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          SizedBox(
            height: SizeConfig.screenHeight! * 0.01,
          ),
          CommenterField(
            commentText: commentText,
            commentController: commentController,
            context: context,
            cubit: cubit,
            postId: postId,
          ),
        ],
      ),
    );
  }
}
