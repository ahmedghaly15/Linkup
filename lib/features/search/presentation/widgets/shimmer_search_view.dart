import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/widgets/shimmer_person.dart';

class ShimmerSearchView extends StatelessWidget {
  const ShimmerSearchView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(vertical: 16.w),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return const ShimmerPerson();
          },
          childCount: 8,
        ),
      ),
    );
  }
}
