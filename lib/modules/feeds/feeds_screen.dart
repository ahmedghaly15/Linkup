import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:social_app/styles/thems.dart';

import '/layout/cubit/cubit.dart';
import '/layout/cubit/states.dart';
import '/models/post_model.dart';
import '/modules/comments/comments_screen.dart';
import '/shared/constants.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit, SocialAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: SocialAppCubit.getObject(context).posts.isNotEmpty &&
              SocialAppCubit.getObject(context).model != null,
          builder: (context) => SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: <Widget>[
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => buildPostItem(
                    context,
                    SocialAppCubit.getObject(context).posts[index],
                    index,
                  ),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 8),
                  itemCount: SocialAppCubit.getObject(context).posts.length,
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
          fallback: (context) => const Column(
            children: <Widget>[],
          ),
        );
      },
    );
  }

  Widget buildPostItem(
    BuildContext context,
    PostModel model,
    int index,
  ) =>
      Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        color: Get.isDarkMode ? darkGreyClr.withOpacity(0) : Colors.white,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(model.image!),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              model.name!,
                              style: bodyLarge.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                            const SizedBox(width: 5),
                            const Icon(
                              Icons.verified,
                              size: 16,
                              color: Colors.blue,
                            ),
                          ],
                        ),
                        Text(
                          "${model.date} at ${model.time}",
                          style: caption,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      SocialAppCubit.getObject(context).deletePost(
                        postId: model.postId!,
                        context: context,
                      );
                    },
                    icon: Icon(
                      model.uId == SocialAppCubit.getObject(context).model!.uId
                          ? Icons.delete
                          : Icons.more_horiz,
                      size: 25,
                      color: model.uId ==
                              SocialAppCubit.getObject(context).model!.uId
                          ? Colors.red
                          : (Get.isDarkMode ? Colors.white : Colors.black),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 15.0,
                  horizontal: 5,
                ),
                child: Container(
                  width: double.infinity,
                  height: 1.5,
                  color: Colors.grey[300],
                ),
              ),
              Text(
                model.text!,
                style: bodySmall.copyWith(letterSpacing: 0.5),
              ),
              if (model.postImage != '')
                Padding(
                  padding: const EdgeInsetsDirectional.only(top: 15),
                  child: Container(
                    height: 180,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          model.postImage!,
                        ),
                      ),
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          SocialAppCubit.getObject(context)
                              .likedByMe(postId: model.postId!);
                          buildSnackBar(
                            message: "Liked Successfully",
                            state: SnackBarStates.success,
                            context: context,
                          );
                        },
                        child: Row(
                          children: <Widget>[
                            const Icon(
                              Icons.favorite_border,
                              size: 18,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              "${model.likes} Likes",
                              style: caption,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          navigateTo(
                            context,
                            CommentsScreen(
                              likes: model.likes,
                              postId: model.postId,
                              postUid: model.uId,
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            const Icon(
                              Icons.comment,
                              size: 18,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              "${model.comments} comments",
                              style: caption,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 15.0,
                  horizontal: 5,
                ),
                child: Container(
                  width: double.infinity,
                  height: 1.5,
                  color: Colors.grey[300],
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Row(
                        children: <Widget>[
                          CircleAvatar(
                            radius: 18,
                            backgroundImage: NetworkImage(
                                SocialAppCubit.getObject(context)
                                    .model!
                                    .image!),
                          ),
                          const SizedBox(width: 10),
                          TextButton(
                            onPressed: () {
                              navigateTo(
                                context,
                                CommentsScreen(
                                  likes: model.likes,
                                  postId: model.postId,
                                  postUid: model.uId,
                                ),
                              );
                            },
                            child: Text(
                              "Write a comment...",
                              style: caption.copyWith(fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
