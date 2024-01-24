import 'package:flutter/material.dart';
import 'package:social_app/features/posts/presentation/widgets/shimmer_post_item.dart';

class ShimmerPosts extends StatelessWidget {
  const ShimmerPosts({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => const ShimmerPostItem(),
        childCount: 15,
      ),
    );
  }
}
