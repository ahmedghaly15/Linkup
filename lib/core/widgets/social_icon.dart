import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:url_launcher/link.dart';

class SocialIcon extends StatelessWidget {
  const SocialIcon({
    super.key,
    required this.url,
    required this.darkModeIcon,
    required this.lightModeIcon,
  });

  final String url;
  final String darkModeIcon;
  final String lightModeIcon;

  @override
  Widget build(BuildContext context) {
    return Link(
      target: LinkTarget.self,
      uri: Uri.parse(url),
      builder: (context, followLink) {
        return IconButton(
          style: ButtonStyle(
            padding: MaterialStatePropertyAll(
              EdgeInsets.symmetric(
                vertical: 8.h,
                horizontal: 8.w,
              ),
            ),
          ),
          onPressed: followLink,
          icon: Image.asset(
            Helper.isDark(context) ? lightModeIcon : darkModeIcon,
          ),
        );
      },
    );
  }
}
