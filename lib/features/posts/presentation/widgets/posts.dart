import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/utils/app_constants.dart';
import 'package:social_app/features/posts/data/models/post_model.dart';
import 'package:social_app/features/posts/presentation/widgets/post_item.dart';

class Posts extends StatelessWidget {
  const Posts({
    super.key,
    required this.posts,
  });

  final List<PostModel> posts;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.only(top: 10.h, bottom: 15.h),
        physics: AppConstants.physics,
        itemBuilder: (context, index) => PostItem(
          post: posts[index],
        ),
        separatorBuilder: (context, index) => SizedBox(height: 24.h),
        itemCount: posts.length,
      ),
    );
  }
}
