import 'package:flutter/material.dart';

import '../../../../core/global/app_styles.dart';
import '../../../../core/models/post_model.dart';
import '../../../../core/utils/helper.dart';
import '../../../../layout/presenetation/view/manager/app_cubit.dart';
import '/core/global/app_navigator.dart';
import '/features/feeds/presentation/views/comments_view.dart';

class LikesAndComments extends StatelessWidget {
  const LikesAndComments({
    Key? key,
    required this.model,
  }) : super(key: key);

  final PostModel model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Row(
        children: <Widget>[
          Expanded(
            child: InkWell(
              onTap: () {
                AppCubit.getObject(context).likedByMe(postId: model.postId!);
                Helper.buildSnackBar(
                  message: "Liked Successfully",
                  state: SnackBarStates.success,
                  context: context,
                );
              },
              child: Row(
                children: <Widget>[
                  const Icon(
                    Icons.favorite_border,
                    size: 18,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    "${model.likes} Likes",
                    style: AppStyles.caption,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                AppNavigator.navigateTo(
                  screen: CommentsView(
                    postId: model.postId,
                    postUid: model.uId,
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  const Icon(
                    Icons.comment,
                    size: 18,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    "${model.comments} comments",
                    style: AppStyles.caption,
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
