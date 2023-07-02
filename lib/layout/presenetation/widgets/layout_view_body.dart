import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import '../../../core/global/app_colors.dart';
import '../../cubit/cubit.dart';

class LayoutViewBody extends StatelessWidget {
  const LayoutViewBody({Key? key, required this.cubit}) : super(key: key);

  final SocialAppCubit cubit;

  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      condition: cubit.model != null,
      builder: (context) => cubit.bottomNavScreens[cubit.currentIndex],
      fallback: (context) => const Center(
        child: CircularProgressIndicator(
          color: AppColors.primaryColor,
        ),
      ),
    );
  }
}
