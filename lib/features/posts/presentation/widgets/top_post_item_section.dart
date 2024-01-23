import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/config/themes/app_colors.dart';
import 'package:social_app/config/themes/app_text_styles.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/core/widgets/custom_toast.dart';
import 'package:social_app/core/widgets/post_information.dart';
import 'package:social_app/features/posts/data/models/post_model.dart';
import 'package:social_app/features/posts/presentation/cubits/get_posts/get_posts_cubit.dart';
import 'package:social_app/features/posts/presentation/cubits/posts/posts_cubit.dart';
import 'package:social_app/features/users/presentation/cubits/user_cubit.dart';

class TopPostItemSection extends StatelessWidget {
  const TopPostItemSection({
    super.key,
    required this.post,
  });

  final PostModel post;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Flexible(child: PostInformation(post: post)),
        post.user!.uId == Helper.currentUser!.uId
            ? BlocConsumer<PostsCubit, PostsState>(
                listener: (context, state) =>
                    _controlFeedsState(state, context),
                builder: (context, state) {
                  return PopupMenuButton(
                    icon: Icon(
                      Icons.more_horiz,
                      color: Helper.isDark(context)
                          ? AppColors.scaffoldBackgroundClr
                          : AppColors.darkPrimaryColor,
                      size: 25.w,
                    ),
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 'deletePost',
                        child: Text(
                          'Delete',
                          style: AppTextStyles.textStyle16SemiBold,
                        ),
                      ),
                    ],
                    onSelected: (value) async {
                      if (value == 'deletePost') {
                        BlocProvider.of<PostsCubit>(context).deletePost(
                          postId: post.postId!,
                          context: context,
                        );
                      }
                    },
                  );
                })
            : const SizedBox(),
      ],
    );
  }

  void _controlFeedsState(PostsState state, BuildContext context) {
    if (state is DeletePostSuccess) {
      _handleDeletePostSuccess(context);
    }
  }

  void _handleDeletePostSuccess(BuildContext context) {
    BlocProvider.of<GetPostsCubit>(context).getPosts().then((value) {
      BlocProvider.of<UserCubit>(context)
          .getUserPosts(uId: Helper.uId!)
          .then((value) {
        CustomToast.showToast(
          text: 'Post deleted successfully',
          state: CustomToastState.success,
        );
      });
    });
  }
}
