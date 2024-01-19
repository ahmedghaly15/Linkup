import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/config/themes/app_colors.dart';
import 'package:social_app/config/themes/app_text_styles.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/core/widgets/post_information.dart';
import 'package:social_app/features/posts/data/models/post_model.dart';
import 'package:social_app/features/posts/presentation/cubits/posts_cubit.dart';

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
        post.uId == Helper.currentUser!.uId
            ? PopupMenuButton(
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
                    BlocProvider.of<PostsCubit>(context)
                        .deletePost(postId: post.postId!);
                  }
                },
              )
            : const SizedBox(),
      ],
    );
  }
}
