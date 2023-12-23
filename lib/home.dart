import 'package:flutter/material.dart';
import 'package:social_app/core/helpers/cache_helper.dart';
import 'package:social_app/core/utils/app_strings.dart';
import 'package:social_app/core/utils/app_text_styles.dart';
import 'package:social_app/service_locator.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            getIt.get<CacheHelper>().removeData(key: AppStrings.uId);
          },
          child: Text(
            'Home',
            style: AppTextStyles.textStyle50Bold,
          ),
        ),
      ),
    );
  }
}
