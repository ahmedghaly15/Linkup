import 'package:flutter/material.dart';
import 'package:social_app/core/utils/app_assets.dart';

class EmptyPosts extends StatelessWidget {
  const EmptyPosts({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppAssets.imagesNoPosts,
      fit: BoxFit.fill,
    );
  }
}
