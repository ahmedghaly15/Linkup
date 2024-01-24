import 'package:flutter/material.dart';
import 'package:social_app/core/utils/app_assets.dart';

class EmptyUsersView extends StatelessWidget {
  const EmptyUsersView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        AppAssets.imagesNoUsers,
        fit: BoxFit.fill,
      ),
    );
  }
}
