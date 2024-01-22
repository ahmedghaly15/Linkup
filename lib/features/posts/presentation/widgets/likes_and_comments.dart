import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/config/router/routes.dart';
import 'package:social_app/config/themes/app_colors.dart';
import 'package:social_app/core/utils/app_assets.dart';
import 'package:social_app/core/utils/app_navigator.dart';
import 'package:social_app/core/utils/app_strings.dart';
import 'package:social_app/config/themes/app_text_styles.dart';
import 'package:social_app/features/comments/domain/entities/comments_view_params.dart';
import 'package:social_app/features/posts/data/models/post_model.dart';
import 'package:social_app/features/posts/presentation/cubits/posts/posts_cubit.dart';
import 'package:social_app/service_locator.dart';

class LikesAndComments extends StatelessWidget {
  const LikesAndComments({
    super.key,
    required this.post,
  });

  final PostModel post;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostsCubit, PostsState>(
      builder: (context, state) {
        PostsCubit cubit = BlocProvider.of<PostsCubit>(context);

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            InkWell(
              onLongPress: () {
                context.navigateTo(
                  routeName: Routes.postLikesRoute,
                  arguments: post.postId,
                );
              },
              child: StreamBuilder<bool>(
                  stream: BlocProvider.of<PostsCubit>(context)
                      .likedPostsByMe(postId: post.postId!),
                  builder: (context, snapshot) {
                    bool isPostLikedByMe = snapshot.data ?? false;

                    return TextButton.icon(
                      onPressed: () {
                        isPostLikedByMe
                            ? cubit.unLikePost(
                                postId: post.postId!,
                                context: context,
                              )
                            : cubit.likePost(
                                postId: post.postId!,
                                context: context,
                              );
                      },
                      icon: isPostLikedByMe
                          ? Image.asset(AppAssets.iconsRedLike)
                          : Image.asset(AppAssets.iconsLike),
                      label: StreamBuilder(
                        stream: _likesStream(),
                        builder: (context, snapshot) {
                          int likesCount = snapshot.data?.docs.length ?? 0;

                          return Text(
                            "$likesCount Likes",
                            style: AppTextStyles.textStyle15.copyWith(
                              color: AppColors.lightGrey,
                            ),
                          );
                        },
                      ),
                    );
                  }),
            ),
            TextButton.icon(
              onPressed: () {
                context.navigateTo(
                  routeName: Routes.commentsRoute,
                  arguments: CommentsViewParams(
                    postId: post.postId,
                    postUserId: post.user!.uId,
                  ),
                );
              },
              icon: Image.asset(AppAssets.iconsComment),
              label: StreamBuilder(
                  stream: _commentsStream(),
                  builder: (context, snapshot) {
                    int commentsCount = snapshot.data?.docs.length ?? 0;

                    return Text(
                      "$commentsCount comments",
                      style: AppTextStyles.textStyle13.copyWith(
                        color: AppColors.lightGrey,
                      ),
                    );
                  }),
            ),
          ],
        );
      },
    );
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> _commentsStream() {
    return getIt
        .get<FirebaseFirestore>()
        .collection(AppStrings.posts)
        .doc(post.postId)
        .collection(AppStrings.comments)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> _likesStream() {
    return getIt
        .get<FirebaseFirestore>()
        .collection(AppStrings.posts)
        .doc(post.postId)
        .collection(AppStrings.likes)
        .snapshots();
  }
}
