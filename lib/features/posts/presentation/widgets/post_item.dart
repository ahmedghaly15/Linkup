import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/config/themes/cubit/themes_cubit.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/config/themes/app_colors.dart';
import 'package:social_app/features/posts/data/models/post_model.dart';
import 'package:social_app/features/posts/presentation/widgets/custom_divider.dart';
import 'package:social_app/features/posts/presentation/widgets/likes_and_comments.dart';
import 'package:social_app/features/posts/presentation/widgets/post_item_footer.dart';
import 'package:social_app/features/posts/presentation/widgets/post_text_and_image.dart';
import 'package:social_app/features/posts/presentation/widgets/top_post_item_section.dart';

class PostItem extends StatelessWidget {
  const PostItem({
    super.key,
    required this.post,
  });

  final PostModel post;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemesCubit, ThemeData>(
      builder: (context, state) => Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        padding: EdgeInsets.symmetric(
          horizontal: 8.0.w,
          vertical: 10.h,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16.r)),
          color: Helper.isDark(state) ? AppColors.darkGreyClr : Colors.white,
          boxShadow: <BoxShadow>[
            Helper.postShadow(state),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TopPostItemSection(post: post),
            Padding(
              padding: EdgeInsetsDirectional.only(
                start: 5.w,
                end: 5.w,
                top: 15.h,
              ),
              child: const CustomDivider(),
            ),
            PostTextAndImage(post: post),
            LikesAndComments(post: post),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: const CustomDivider(),
            ),
            PostItemFooter(post: post),
          ],
        ),
      ),
    );
  }
}
