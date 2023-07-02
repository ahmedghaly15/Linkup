import 'package:flutter/material.dart';

import '../../../../core/global/app_navigator.dart';
import '../../../../core/global/app_styles.dart';
import '../../../../core/models/post_model.dart';
import '../../../../core/utils/helper.dart';
import '/features/feeds/presentation/views/comments_view.dart';

class WriteCommentInputField extends StatelessWidget {
  const WriteCommentInputField({
    Key? key,
    required this.model,
  }) : super(key: key);

  final PostModel model;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Row(
            children: <Widget>[
              CircleAvatar(
                radius: 18,
                backgroundImage: NetworkImage(
                  Helper.model!.image!,
                ),
              ),
              const SizedBox(width: 10),
              TextButton(
                onPressed: () {
                  AppNavigator.navigateTo(
                    screen: CommentsView(
                      postId: model.postId,
                      postUid: model.uId,
                    ),
                  );
                },
                child: Text(
                  "Write a comment...",
                  style: AppStyles.bodySmall.copyWith(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
