import 'package:flutter/material.dart';
import 'package:social_app/features/linkup/presentation/cubits/linkup_cubit.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  final LinkupCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: cubit.getBottomNavItems(),
      currentIndex: cubit.currentIndex,
      onTap: (int index) => cubit.changeBottomNavIndex(index, context),
    );
  }
}
