import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/config/themes/cubit/themes_cubit.dart';
import 'package:social_app/core/utils/app_colors.dart';
import 'package:social_app/features/linkup/presentation/cubits/linkup_cubit.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  final LinkupCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemesCubit, ThemeData>(
      builder: (context, themeState) {
        return BottomNavigationBar(
          backgroundColor: themeState.brightness == Brightness.dark
              ? AppColors.darkGreyClr
              : Colors.white,
          items: cubit.getBottomNavItems(),
          currentIndex: cubit.currentIndex,
          onTap: (int index) => cubit.changeBottomNavIndex(index, context),
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: AppColors.primaryColor,
        );
      },
    );
  }
}
