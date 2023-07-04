import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/global/app_styles.dart';
import '../../../../core/models/comment_model.dart';
import '../../../../core/utils/size_config.dart';

class CommentItemContent extends StatelessWidget {
  const CommentItemContent({Key? key, required this.commentModel})
      : super(key: key);

  final CommentModel commentModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          commentModel.name!,
          style: AppStyles.bodySmall.copyWith(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        if (commentModel.commentText != null)
          SizedBox(
            height: SizeConfig.screenHeight! * 0.02,
          ),
        if (commentModel.commentText != null)
          Text(
            commentModel.commentText!,
            style: AppStyles.bodySmall.copyWith(
              fontWeight: FontWeight.w500,
              height: 1,
              letterSpacing: 0.5,
            ),
            maxLines: null,
          ),
        if (commentModel.commentText != null)
          SizedBox(
            height: SizeConfig.screenHeight! * 0.01,
          ),
        if (commentModel.commentImage!['image'] != null)
          Container(
            width: double.infinity,
            height: 150,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  commentModel.commentImage!['image'],
                ),
              ),
            ),
          ),
        SizedBox(
          height: SizeConfig.screenHeight! * 0.02,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              "${commentModel.date}",
              style: AppStyles.caption.copyWith(
                color: Get.isDarkMode ? Colors.white54 : Colors.black38,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Container(
                width: 5,
                height: 5,
                decoration: BoxDecoration(
                  color: Get.isDarkMode ? Colors.grey : Colors.black45,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Text(
              "${commentModel.time}",
              style: AppStyles.caption.copyWith(
                color: Get.isDarkMode ? Colors.white54 : Colors.black38,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
