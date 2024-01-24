import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/core/utils/app_constants.dart';
import 'package:social_app/features/following_and_followers/presentation/widgets/shimmer_follower_user_item.dart';

class ShimmerFollowersTab extends StatelessWidget {
  const ShimmerFollowersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      physics: AppConstants.physics,
      gridDelegate: Helper.followersGridViewGridDelegate(),
      itemBuilder: (BuildContext context, int index) =>
          const ShimmerFollowerUserItem(),
      itemCount: 12,
    );
  }
}
