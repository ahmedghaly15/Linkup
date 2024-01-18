import 'package:flutter/material.dart';
import 'package:social_app/config/themes/app_text_styles.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/core/utils/app_constants.dart';
import 'package:social_app/core/widgets/custom_get_back_button.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({
    super.key,
    required this.title,
    this.backOnPressed,
    this.hasLeading = true,
  });

  final String title;
  final bool hasLeading;
  final VoidCallback? backOnPressed;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      elevation: AppConstants.appBarElevation,
      expandedHeight: AppConstants.expandedHeight,
      flexibleSpace: Container(
        // decoration: Helper.backgroundImageDecoration(),
        // color: Colors.transparent,
        child: hasLeading
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const CustomGetBackButton(),
                  const Spacer(flex: 2),
                  Text(
                    title,
                    style: AppTextStyles.textStyle23Bold.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(flex: 3),
                ],
              )
            : Text(
                title,
                style: AppTextStyles.textStyle23Bold.copyWith(
                  color: Colors.white,
                ),
              ),
      ),
    );
  }
}
