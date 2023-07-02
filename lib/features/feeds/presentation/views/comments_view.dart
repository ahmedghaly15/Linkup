import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../core/models/comment_model.dart';
import '../../../../core/utils/helper.dart';
import '../../../../layout/presenetation/view/manager/app_cubit.dart';
import '../../../../layout/presenetation/view/manager/app_states.dart';
import '/core/global/app_styles.dart';
import '/features/feeds/presentation/widgets/comments_view_body.dart';

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
      AppCubit.getObject(context).getComments(postId: postId!);
      AppCubit.getObject(context).getUserData(postUid);

      return BlocBuilder<AppCubit, AppStates>(
        builder: (context, state) {
          AppCubit cubit = AppCubit.getObject(context);
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
      systemOverlayStyle: Helper.setSystemOverlayStyle(),
    );
  }
}
