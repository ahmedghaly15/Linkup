import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/config/router/routes.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/core/utils/app_colors.dart';
import 'package:social_app/core/utils/app_navigator.dart';
import 'package:social_app/core/utils/app_strings.dart';
import 'package:social_app/core/utils/app_text_styles.dart';
import 'package:social_app/features/comments/domain/entities/comments_view_params.dart';
import 'package:social_app/features/posts/data/models/post_model.dart';

class PostItemFooter extends StatelessWidget {
  const PostItemFooter({
    Key? key,
    required this.post,
  }) : super(key: key);

  final PostModel post;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        CachedNetworkImage(
          imageUrl: Helper.currentUser!.image!,
          imageBuilder: (_, image) {
            return CircleAvatar(
              backgroundImage: image,
              radius: 18.r,
              backgroundColor: AppColors.primaryColor,
            );
          },
        ),
        SizedBox(width: 10.w),
        TextButton(
          onPressed: () {
            context.navigateTo(
              routeName: Routes.commentsRoute,
              arguments: CommentsViewParams(
                postId: post.postId,
                postUserId: post.uId,
              ),
            );
          },
          child: Text(
            "Write a comment...",
            style: AppTextStyles.textStyle15.copyWith(color: Colors.grey),
          ),
        ),
        const Spacer(),
        StreamBuilder(
          stream: _likesStream(),
          builder: (context, snapshot) {
            int likesCount = snapshot.data?.docs.length ?? 0;

            return TextButton(
              onPressed: () {
                context.navigateTo(
                  routeName: Routes.postLikes,
                  arguments: post.postId,
                );
              },
              child: Text(
                "$likesCount Likes",
                style: AppTextStyles.textStyle15.copyWith(color: Colors.grey),
              ),
            );
          },
        )
      ],
    );
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> _likesStream() {
    return FirebaseFirestore.instance
        .collection(AppStrings.posts)
        .doc(post.postId)
        .collection(AppStrings.likes)
        .snapshots();
  }
}