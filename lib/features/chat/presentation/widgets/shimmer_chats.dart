import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/features/chat/presentation/widgets/shimmer_chat_item.dart';

class ShimmerChats extends StatelessWidget {
  const ShimmerChats({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.only(
        bottom: 35.h,
        left: 10.w,
        right: 10.w,
      ),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => const ShimmerChatItem(),
          childCount: 12,
        ),
      ),
    );
  }
}
