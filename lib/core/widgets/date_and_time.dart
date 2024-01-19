import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/config/themes/app_text_styles.dart';

class DateAndTime extends StatelessWidget {
  const DateAndTime({
    super.key,
    required this.date,
    required this.time,
  });

  final String date;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          date,
          style: AppTextStyles.textStyle13.copyWith(
            color: Helper.isDark(context) ? Colors.white54 : Colors.black38,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Container(
            width: 5.w,
            height: 5.w,
            decoration: BoxDecoration(
              color: Helper.isDark(context) ? Colors.grey : Colors.black45,
              shape: BoxShape.circle,
            ),
          ),
        ),
        Text(
          time,
          style: AppTextStyles.textStyle13.copyWith(
            color: Helper.isDark(context) ? Colors.white54 : Colors.black38,
          ),
        ),
      ],
    );
  }
}
