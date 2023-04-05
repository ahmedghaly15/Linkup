import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/shared/constants.dart';
import 'package:social_app/styles/iconbroken.dart';

import '../modules/new_post/new_post_screen.dart';
import '../styles/colors.dart';

class SocialAppLayout extends StatelessWidget {
  const SocialAppLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit, SocialAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        SocialAppCubit cubit = SocialAppCubit.getObject(context);
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            appBar: AppBar(
              // title: Text(cubit.titles[cubit.currentIndex]),
              actions: <Widget>[
                IconButton(
                  onPressed: () {},
                  icon: const Icon(IconBroken.notification),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(IconBroken.search),
                ),
              ],
            ),
            body: ConditionalBuilder(
              condition: cubit.model != null,
              builder: (context) => cubit.bottomNavScreens[cubit.currentIndex],
              fallback: (context) => const Center(
                child: CircularProgressIndicator(
                  color: defaultColor,
                ),
              ),
            ),
            bottomNavigationBar: BottomAppBar(
              shape: const CircularNotchedRectangle(),
              notchMargin: 0.1,
              clipBehavior: Clip.antiAlias,
              child: BottomNavigationBar(
                backgroundColor: Colors.white,
                items: cubit.bottomNavItems,
                currentIndex: cubit.currentIndex,
                onTap: (int index) => cubit.changeBottomNavIndex(index),
                type: BottomNavigationBarType.fixed,
                selectedLabelStyle:
                    const TextStyle(fontWeight: FontWeight.bold),
                showSelectedLabels: true,
                showUnselectedLabels: false,
                selectedItemColor: defaultColor,
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton(
                onPressed: () => navigateTo(context, const NewPostScreen()),
                backgroundColor: defaultColor,
                child: const Icon(IconBroken.paperUpload),
              ),
            ),
          ),
        );
      },
    );
  }
}
