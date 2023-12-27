import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/config/themes/cubit/themes_cubit.dart';
import 'package:social_app/core/utils/app_text_styles.dart';

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
    return BlocBuilder<ThemesCubit, ThemeData>(
      builder: (context, themeState) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              date,
              style: AppTextStyles.textStyle13.copyWith(
                color: themeState.brightness == Brightness.dark
                    ? Colors.white54
                    : Colors.black38,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Container(
                width: 5.w,
                height: 5.w,
                decoration: BoxDecoration(
                  color: themeState.brightness == Brightness.dark
                      ? Colors.grey
                      : Colors.black45,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Text(
              time,
              style: AppTextStyles.textStyle13.copyWith(
                color: themeState.brightness == Brightness.dark
                    ? Colors.white54
                    : Colors.black38,
              ),
            ),
          ],
        );
      },
    );
  }
}
