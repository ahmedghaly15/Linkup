import 'package:flutter/material.dart';
import 'package:social_app/config/themes/app_colors.dart';
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
      leading: hasLeading
          ? CustomGetBackButton(
              hasShadow: true,
              onPressed: backOnPressed,
            )
          : const SizedBox(),
      backgroundColor: Helper.isDark(context)
          ? AppColors.darkPrimaryColor
          : AppColors.lightWhiteBlue,
      title: Text(
        title,
        style: AppTextStyles.textStyle20Bold,
      ),
      centerTitle: true,
    );
  }
}
