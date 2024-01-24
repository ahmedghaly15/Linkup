import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/config/themes/app_text_styles.dart';
import 'package:social_app/core/utils/app_assets.dart';

class EmptyFollowing extends StatelessWidget {
  const EmptyFollowing({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Image.asset(
            AppAssets.imagesEmptyFollowing,
            fit: BoxFit.fill,
          ),
          SizedBox(height: 4.h),
          Text(
            "Enhance your experience by following interesting people and discovering great content!",
            style: AppTextStyles.textStyle16,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
