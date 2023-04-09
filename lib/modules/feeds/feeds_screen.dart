import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/modules/comments/comments_screen.dart';
import 'package:social_app/shared/constants.dart';
import 'package:social_app/styles/colors.dart';
import 'package:social_app/styles/iconbroken.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({super.key});

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
                Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  elevation: 5,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: const <Widget>[
                      Image(
                        image: NetworkImage(
                          'https://img.freepik.com/premium-photo/group-people-jumping-mountain-sunset-friends-party-happy-time_33755-6224.jpg?size=626&ext=jpg&ga=GA1.1.825316313.1674289475&semt=sph',
                        ),
                        width: double.infinity,
                        fit: BoxFit.cover,
                        height: 200,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        child: Text(
                          "Communicate With Friends",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
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
          fallback: (context) => const Center(
            child: CircularProgressIndicator(
              color: defaultColor,
            ),
          ),
        );
      },
    );
  }

  Widget buildPostItem(BuildContext context, PostModel model, int index) =>
      Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
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
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1.5,
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
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    height: 1.5,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.more_horiz,
                      size: 23,
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
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                  letterSpacing: 0.5,
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(
              //     bottom: 10,
              //     top: 5,
              //   ),
              //   child: SizedBox(
              //     width: double.infinity,
              //     child: Wrap(
              //       children: <Widget>[
              //         Padding(
              //           padding: const EdgeInsetsDirectional.only(
              //             end: 5,
              //           ),
              //           child: SizedBox(
              //             height: 25,
              //             child: MaterialButton(
              //               onPressed: () {},
              //               minWidth: 1.0,
              //               padding: EdgeInsets.zero,
              //               child: const Text(
              //                 "#software",
              //                 style: TextStyle(color: Colors.blue),
              //               ),
              //             ),
              //           ),
              //         ),
              //         Padding(
              //           padding: const EdgeInsetsDirectional.only(end: 5),
              //           child: SizedBox(
              //             height: 25,
              //             child: MaterialButton(
              //               onPressed: () {},
              //               minWidth: 1.0,
              //               padding: EdgeInsets.zero,
              //               child: const Text(
              //                 "#flutter",
              //                 style: TextStyle(color: Colors.blue),
              //               ),
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
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
                        onTap: () {},
                        child: Row(
                          children: <Widget>[
                            const Icon(
                              IconBroken.heart,
                              size: 20,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              "${model.likes} Likes",
                              // "${SocialAppCubit.getObject(context).likes[index]} Likes",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          // SocialAppCubit.getObject(context)
                          //     .getComments(postId: model.postId!);
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
                              IconBroken.chat,
                              size: 20,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              "${model.comments} comments",
                              style: Theme.of(context).textTheme.bodySmall,
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
                              // SocialAppCubit.getObject(context)
                              //     .getComments(postId: model.postId!);
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
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    fontSize: 14,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      await SocialAppCubit.getObject(context)
                          .likedByMe(postId: model.postId!);
                    },
                    child: Row(
                      children: <Widget>[
                        const Icon(
                          IconBroken.heart,
                          size: 18,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          "Like",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
