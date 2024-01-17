import 'package:flutter/material.dart';
import 'package:social_app/config/themes/app_text_styles.dart';
import 'package:social_app/core/widgets/get_back_arrow.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({
    super.key,
    required this.title,
    this.backOnPressed,
  });

  final String title;
  final VoidCallback? backOnPressed;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Text(
        title,
        style: AppTextStyles.textStyle23Bold,
      ),
      centerTitle: true,
      leading: GetBackArrow(
        onPressed: backOnPressed,
      ),
    );
  }
}
