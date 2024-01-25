import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/features/posts/presentation/widgets/shimmer_post_item.dart';

class ShimmerUserPosts extends StatelessWidget {
  const ShimmerUserPosts({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.only(top: 32.h, bottom: 32.h),
      itemCount: 5,
      shrinkWrap: true,
      itemBuilder: (context, index) => const ShimmerPostItem(),
      separatorBuilder: (context, state) => SizedBox(height: 24.h),
    );
  }
}
