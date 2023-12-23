import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_text_styles.dart';
import '/core/models/post_model.dart';

class PostTextAndImage extends StatelessWidget {
  const PostTextAndImage({Key? key, required this.post}) : super(key: key);

  final PostModel post;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (post.text != null) ...[
          SizedBox(height: 15.h),
          Text(
            'post.text!',
            style: AppTextStyles.textStyle16,
          ),
        ],
        if (post.postImage != '' && post.text != '') SizedBox(height: 15.h),
        if (post.postImage != '')
          Container(
            height: 180.h,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.r),
              image: const DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                    'https://img.freepik.com/free-icon/user_318-159711.jpg?size=626&ext=jpg&ga=GA1.2.825316313.1674289475&semt=ais'),
              ),
            ),
          ),
      ],
    );
  }
}
