import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/config/themes/app_colors.dart';
import 'package:social_app/core/widgets/post_information.dart';
import 'package:social_app/features/posts/data/models/post_model.dart';
import 'package:social_app/features/posts/presentation/widgets/custom_divider.dart';
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
      margin: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
        bottom: 24.h,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 8.0.w,
        vertical: 10.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16.r)),
        color:
            Helper.isDark(context) ? AppColors.darkPrimaryColor : Colors.white,
        boxShadow: <BoxShadow>[
          Helper.postShadow(context),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          PostInformation(post: post),
          Padding(
            padding: EdgeInsetsDirectional.only(
              start: 5.w,
              end: 5.w,
              top: 15.h,
            ),
            child: const CustomDivider(),
          ),
          PostTextAndImage(post: post),
          LikesAndComments(post: post),
        ],
      ),
    );
  }
}
