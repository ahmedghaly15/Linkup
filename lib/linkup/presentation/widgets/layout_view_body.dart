import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/helpers/helper.dart';
import '../views/manager/app_cubit.dart';

class LayoutViewBody extends StatelessWidget {
  const LayoutViewBody({Key? key, required this.cubit}) : super(key: key);

  final AppCubit cubit;

  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      condition: Helper.currentUser != null,
      builder: (context) => cubit.bottomNavScreens[cubit.currentIndex],
      fallback: (context) => const Center(
        child: CircularProgressIndicator(
          color: AppColors.primaryColor,
        ),
      ),
    );
  }
}
