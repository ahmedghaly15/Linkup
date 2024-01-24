import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/utils/app_constants.dart';
import 'package:social_app/features/following_and_followers/presentation/widgets/shimmer_following_user_item.dart';

class ShimmerFollowingTab extends StatelessWidget {
  const ShimmerFollowingTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: ListView.builder(
        itemCount: 12,
        physics: AppConstants.physics,
        itemBuilder: (context, index) => const ShimmerFollowingUserItem(),
      ),
    );
  }
}
