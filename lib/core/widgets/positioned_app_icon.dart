import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/utils/app_assets.dart';

class PositionedAppIcon extends StatelessWidget {
  const PositionedAppIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -30.h,
      child: CircleAvatar(
        backgroundColor: const Color(0xff032a49),
        radius: 24.r,
        child: Image.asset(AppAssets.appIcon),
      ),
    );
  }
}
