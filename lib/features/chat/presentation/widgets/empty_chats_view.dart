import 'package:flutter/material.dart';
import 'package:social_app/core/utils/app_assets.dart';

class EmptyChatsView extends StatelessWidget {
  const EmptyChatsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: Center(
        child: Image.asset(
          AppAssets.imagesChat,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
