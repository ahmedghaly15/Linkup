import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/utils/app_text_styles.dart';
import 'package:social_app/core/widgets/date_and_time.dart';
import 'package:social_app/features/comments/data/models/comment_model.dart';

class CommentItemContent extends StatelessWidget {
  const CommentItemContent({
    Key? key,
    required this.comment,
  }) : super(key: key);

  final CommentModel comment;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          comment.name!,
          style: AppTextStyles.textStyle17Bold,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        if (comment.commentText != null) ...[
          SizedBox(height: 8.h),
          Text(
            comment.commentText!,
            style: AppTextStyles.textStyle16,
            maxLines: null,
          ),
        ],
        if (comment.commentImage!['image'] != null &&
            comment.commentText != null)
          SizedBox(height: 8.h),
        if (comment.commentImage!['image'] != null)
          Container(
            width: double.infinity,
            height: 150.h,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8.r)),
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(
                  comment.commentImage!['image'],
                ),
              ),
            ),
          ),
        SizedBox(height: 15.h),
        DateAndTime(
          date: comment.date!,
          time: comment.time!,
        ),
      ],
    );
  }
}
