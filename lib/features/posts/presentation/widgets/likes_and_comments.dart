import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/config/router/routes.dart';
import 'package:social_app/core/utils/app_navigator.dart';
import 'package:social_app/core/utils/app_strings.dart';
import 'package:social_app/core/utils/app_text_styles.dart';
import 'package:social_app/features/comments/domain/entities/comments_view_params.dart';
import 'package:social_app/features/posts/data/models/post_model.dart';
import 'package:social_app/features/posts/presentation/cubits/posts_cubit.dart';
import 'package:social_app/service_locator.dart';

class LikesAndComments extends StatelessWidget {
  const LikesAndComments({
    Key? key,
    required this.post,
  }) : super(key: key);

  final PostModel post;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostsCubit, PostsState>(
      builder: (context, state) {
        PostsCubit cubit = BlocProvider.of<PostsCubit>(context);

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            TextButton.icon(
              onPressed: () {
                cubit.likedPosts.contains(post)
                    ? cubit.unLikePost(postId: post.postId!)
                    : cubit.likePost(postId: post.postId!);
              },
              icon: Icon(
                cubit.likedPosts.contains(post)
                    ? Icons.favorite
                    : Icons.favorite_border,
                size: 18.w,
                color:
                    cubit.likedPosts.contains(post) ? Colors.red : Colors.grey,
              ),
              label: Text(
                "Like",
                style: AppTextStyles.textStyle13.copyWith(color: Colors.grey),
              ),
            ),
            TextButton.icon(
              onPressed: () {
                context.navigateTo(
                  routeName: Routes.commentsRoute,
                  arguments: CommentsViewParams(
                    postId: post.postId,
                    postUserId: post.uId,
                  ),
                );
              },
              icon: Icon(
                Icons.comment,
                size: 18.w,
                color: Colors.grey,
              ),
              label: StreamBuilder(
                  stream: _commentsStream(),
                  builder: (context, snapshot) {
                    int commentsCount = snapshot.data?.docs.length ?? 0;

                    return Text(
                      "$commentsCount comments",
                      style: AppTextStyles.textStyle13.copyWith(
                        color: Colors.grey,
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
}
