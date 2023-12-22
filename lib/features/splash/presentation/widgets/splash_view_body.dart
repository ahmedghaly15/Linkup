import 'package:flutter/widgets.dart';
import 'package:social_app/core/utils/app_assets.dart';

class SplashViewBody extends StatelessWidget {
  const SplashViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(AppAssets.appIcon),
    );
  }
}
