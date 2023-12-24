import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/features/feeds/data/models/post_model.dart';
import 'package:social_app/core/utils/app_text_styles.dart';
import 'package:social_app/features/linkup/presentation/views/manager/app_cubit.dart';

class LikesAndComments extends StatelessWidget {
  const LikesAndComments({
    Key? key,
    required this.post,
  }) : super(key: key);

  final PostModel post;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 15.h),
      child: Row(
        children: <Widget>[
          Expanded(
            child: InkWell(
              onTap: () {
// TODO: try to change the color of favorite to red if the post is likedByMe
                AppCubit.getObject(context).likedByMe(postId: post.postId!);
                // Helper.buildSnackBar(
                //   message: "Liked Successfully",
                //   state: SnackBarStates.success,
                //   context: context,
                // );
              },
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.favorite_border,
                    size: 18.w,
                    color: Colors.grey,
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    "${post.likes} Likes",
                    style: AppTextStyles.textStyle13,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                // TODO: navigate to comment view
                // AppNavigator.navigateTo(
                //   screen: CommentsView(
                //     postId: model.postId,
                //     postUid: model.uId,
                //   ),
                // );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Icon(
                    Icons.comment,
                    size: 18.w,
                    color: Colors.grey,
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    "${post.comments} comments",
                    style: AppTextStyles.textStyle13,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
