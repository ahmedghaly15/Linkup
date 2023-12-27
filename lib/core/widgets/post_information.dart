import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/utils/app_colors.dart';
import 'package:social_app/core/utils/app_text_styles.dart';
import 'package:social_app/core/widgets/cached_image_error_icon.dart';
import 'package:social_app/features/posts/data/models/post_model.dart';

class PostInformation extends StatelessWidget {
  const PostInformation({
    super.key,
    required this.post,
  });

  final PostModel post;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        CachedNetworkImage(
          errorWidget: (context, error, _) => const CachedImageErrorIcon(),
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
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                post.name!,
                style: AppTextStyles.textStyle16SemiBold,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                "${post.date} at ${post.time}",
                style: AppTextStyles.textStyle13,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
