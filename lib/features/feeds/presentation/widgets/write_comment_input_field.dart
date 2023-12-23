import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/utils/app_text_styles.dart';

class WriteCommentInputField extends StatelessWidget {
  const WriteCommentInputField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        CircleAvatar(
          radius: 18.r,
          backgroundImage: const NetworkImage(
              'https://img.freepik.com/free-icon/user_318-159711.jpg?size=626&ext=jpg&ga=GA1.2.825316313.1674289475&semt=ais'
              // Helper.currentUser!.image!,
              ),
        ),
        SizedBox(width: 10.w),
        TextButton(
          onPressed: () {
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
      ],
    );
  }
}
