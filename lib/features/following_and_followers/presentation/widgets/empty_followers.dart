import 'package:flutter/material.dart';
import 'package:social_app/core/utils/app_assets.dart';

class EmptyFollowers extends StatelessWidget {
  const EmptyFollowers({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        AppAssets.imagesEmptyFollowers,
        fit: BoxFit.fill,
      ),
    );
  }
}
