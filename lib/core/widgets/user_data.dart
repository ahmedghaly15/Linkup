import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/themes/app_text_styles.dart';

class UserData extends StatelessWidget {
  const UserData({
    super.key,
    required this.count,
    required this.label,
  });

  final int count;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: <Widget>[
          Text(
            "$count",
            style: AppTextStyles.textStyle18,
          ),
          SizedBox(height: 5.h),
          Text(
            label,
            style: AppTextStyles.textStyle16,
          ),
        ],
      ),
    );
  }
}
