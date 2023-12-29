import 'package:flutter/material.dart';
import 'package:social_app/core/utils/app_assets.dart';

class EmptyPostView extends StatelessWidget {
  const EmptyPostView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        AppAssets.imagesNoPosts,
        fit: BoxFit.fill,
      ),
    );
  }
}
