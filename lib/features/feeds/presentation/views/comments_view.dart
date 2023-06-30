import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:social_app/core/global/app_styles.dart';
import 'package:social_app/features/feeds/presentation/widgets/comments_view_body.dart';
import 'package:social_app/layout/cubit/states.dart';

import '../../../../core/models/comment_model.dart';
import '../../../../core/utils/helper.dart';
import '../../../../layout/cubit/cubit.dart';

class CommentsView extends StatelessWidget {
  CommentsView({Key? key, this.postId, this.postUid}) : super(key: key);

  final String? postId;
  final String? postUid;

  final TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String? postId = this.postId;
    return Builder(builder: (context) {
      // Getting The Comments And The User's Data
      SocialAppCubit.getObject(context).getComments(postId: postId!);
      SocialAppCubit.getObject(context).getUserData(postUid);

      return BlocBuilder<SocialAppCubit, SocialAppStates>(
        builder: (context, state) {
          SocialAppCubit cubit = SocialAppCubit.getObject(context);
          List<CommentModel> comments = cubit.comments;

          return Scaffold(
            backgroundColor: context.theme.colorScheme.background,
            appBar: buildAppBar(context, comments),
            body: CommentsViewBody(
              comments: comments,
              commentText: commentController.text,
              cubit: cubit,
              postId: postId,
              commentController: commentController,
              commentImage: cubit.commentImage,
            ),
          );
        },
      );
    });
  }

  AppBar buildAppBar(BuildContext context, List<CommentModel> comments) {
    return AppBar(
      backgroundColor: context.theme.colorScheme.background,
      automaticallyImplyLeading: true,
      title: Text(
        "Comments",
        style: AppStyles.appBarTitleStyle,
      ),
      leading: IconButton(
        onPressed: () {
          comments.clear();
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back_ios,
          color: Get.isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      systemOverlayStyle: setSystemOverlayStyle(),
    );
  }
}
