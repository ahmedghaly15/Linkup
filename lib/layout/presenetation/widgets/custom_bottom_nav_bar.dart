import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/global/app_colors.dart';
import '../view/manager/app_cubit.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  final AppCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 0.1,
      clipBehavior: Clip.antiAlias,
      child: BottomNavigationBar(
        backgroundColor: Get.isDarkMode ? AppColors.darkGreyClr : Colors.white,
        items: cubit.bottomNavItems,
        currentIndex: cubit.currentIndex,
        onTap: (int index) => cubit.changeBottomNavIndex(index),
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        showSelectedLabels: true,
        showUnselectedLabels: false,
        selectedItemColor: AppColors.primaryColor,
        selectedIconTheme: const IconThemeData(size: 25),
        unselectedIconTheme: const IconThemeData(size: 22),
      ),
    );
  }
}
