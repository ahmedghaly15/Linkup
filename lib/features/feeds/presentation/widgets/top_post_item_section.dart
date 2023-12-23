import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/config/themes/cubit/themes_cubit.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/core/models/post_model.dart';
import 'package:social_app/core/utils/app_colors.dart';
import 'package:social_app/core/utils/app_text_styles.dart';

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
        CachedNetworkImage(
          imageUrl: post.image!,
          imageBuilder: (_, image) {
            return CircleAvatar(
              backgroundImage: image,
              radius: 25.r,
              backgroundColor: AppColors.primaryColor,
            );
          },
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                post.name!,
                style: AppTextStyles.textStyle16SemiBold,
              ),
              Text(
                "${post.date} at ${post.time}",
                style: AppTextStyles.textStyle13,
              ),
            ],
          ),
        ),
        BlocBuilder<ThemesCubit, ThemeData>(
          builder: (context, state) {
            return IconButton(
              onPressed: () {
                // AppCubit.getObject(context).deletePost(
                //   postId: post.postId!,
                //   context: context,
                // );
              },
              icon: Icon(
                post.uId == Helper.currentUser!.uId
                    ? Icons.delete
                    : Icons.more_horiz,
                size: 25.w,
                color: post.uId == Helper.currentUser!.uId
                    ? Colors.red
                    : (state.brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black),
              ),
            );
          },
        ),
      ],
    );
  }
}
