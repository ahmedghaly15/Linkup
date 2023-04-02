import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/styles/iconbroken.dart';

import '../styles/colors.dart';

class SocialAppLayout extends StatelessWidget {
  const SocialAppLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit, SocialAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        SocialAppCubit cubit = SocialAppCubit.getObject(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.titles[cubit.currentIndex]),
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
            condition: SocialAppCubit.getObject(context).model != null,
            builder: (context) {
              return Column(
                children: const <Widget>[],
              );
            },
            fallback: (context) => const Center(
              child: CircularProgressIndicator(
                color: defaultColor,
              ),
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: cubit.bottomNavItems,
            currentIndex: cubit.currentIndex,
            onTap: (int index) => cubit.changeBottomNavIndex(index),
            type: BottomNavigationBarType.shifting,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
            showSelectedLabels: true,
            showUnselectedLabels: false,
          ),
        );
      },
    );
  }
}
