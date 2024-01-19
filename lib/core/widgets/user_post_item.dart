import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/config/themes/app_colors.dart';
import 'package:social_app/core/widgets/post_information.dart';
import 'package:social_app/features/posts/data/models/post_model.dart';
import 'package:social_app/features/posts/presentation/widgets/likes_and_comments.dart';
import 'package:social_app/features/posts/presentation/widgets/post_text_and_image.dart';

class UserPostItem extends StatelessWidget {
  const UserPostItem({
    super.key,
    required this.post,
  });

  final PostModel post;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      padding: EdgeInsets.only(
        left: 10.w,
        right: 10.w,
        top: 10.h,
        bottom: 2.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(40.r)),
        color: Helper.isDark(context)
            ? AppColors.darkPrimaryColor
            : AppColors.lightWhiteBlue,
        boxShadow: Helper.isDark(context)
            ? <BoxShadow>[
                Helper.postShadow(context),
              ]
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          PostInformation(post: post),
          PostTextAndImage(post: post),
          LikesAndComments(post: post),
        ],
      ),
    );
  }
}
