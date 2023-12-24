import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/core/utils/app_colors.dart';
import 'package:social_app/core/utils/app_text_styles.dart';

class WriteCommentInputField extends StatelessWidget {
  const WriteCommentInputField({Key? key}) : super(key: key);

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
        Expanded(
          child: InkWell(
            onTap: () {
              // AppNavigator.navigateTo(
              //   screen: CommentsView(
              //     postId: model.postId,
              //     postUid: model.uId,
              //   ),
              // );
            },
            child: Text(
              "Write a comment...",
              style: AppTextStyles.textStyle13,
            ),
          ),
        ),
      ],
    );
  }
}
