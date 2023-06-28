import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:social_app/core/global/app_navigator.dart';
import 'package:social_app/features/new_post/presentation/view/new_post_view.dart';

import '../styles/theme_services.dart';
import '/layout/cubit/cubit.dart';
import '/layout/cubit/states.dart';
import '../styles/thems.dart';

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
          child: WillPopScope(
            onWillPop: () {
              if (cubit.isSearching) {
                cubit.invertIsSearching();
                return Future.value(false);
              }
              return Future.value(true);
            },
            child: Scaffold(
              backgroundColor: context.theme.colorScheme.background,
              appBar: AppBar(
                backgroundColor: context.theme.colorScheme.background,
                title: cubit.isSearching
                    ? buildSearchField(cubit)
                    : const Text(""),
                leading: IconButton(
                  onPressed: () async {
                    ThemeServices().switchTheme();
                  },
                  icon: Icon(
                    Get.isDarkMode
                        ? Icons.wb_sunny_outlined
                        : Icons.nightlight_round_outlined,
                    size: 28,
                    color: Get.isDarkMode ? Colors.white : darkGreyClr,
                  ),
                ),
                actions: <Widget>[
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.notifications, color: defaultColor),
                  ),
                  if (cubit.currentIndex == 1)
                    IconButton(
                      onPressed: () {
                        cubit.invertIsSearching();
                      },
                      icon: Icon(
                        cubit.isSearching ? Icons.cancel : Icons.search_rounded,
                        color: defaultColor,
                      ),
                    ),
                ],
                systemOverlayStyle: SystemUiOverlayStyle(
                  systemNavigationBarColor:
                      Get.isDarkMode ? darkGreyClr : Colors.white,
                  statusBarColor:
                      Get.isDarkMode ? darkGreyClr : Colors.transparent,
                  statusBarBrightness:
                      Get.isDarkMode ? Brightness.light : Brightness.dark,
                ),
              ),
              body: ConditionalBuilder(
                condition: cubit.model != null,
                builder: (context) =>
                    cubit.bottomNavScreens[cubit.currentIndex],
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
                  backgroundColor: Get.isDarkMode ? darkGreyClr : Colors.white,
                  items: cubit.bottomNavItems,
                  currentIndex: cubit.currentIndex,
                  onTap: (int index) => cubit.changeBottomNavIndex(index),
                  type: BottomNavigationBarType.fixed,
                  selectedLabelStyle:
                      const TextStyle(fontWeight: FontWeight.bold),
                  showSelectedLabels: true,
                  showUnselectedLabels: false,
                  selectedItemColor: defaultColor,
                  selectedIconTheme: const IconThemeData(size: 25),
                  unselectedIconTheme: const IconThemeData(size: 22),
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              floatingActionButton: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FloatingActionButton(
                  heroTag: "Floating New Post Button",
                  onPressed: () => AppNavigator.navigateTo(
                    screen: const NewPostView(),
                  ),
                  backgroundColor: defaultColor,
                  child: const Icon(
                    Icons.post_add,
                    size: 25,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildSearchField(SocialAppCubit cubit) {
    return SizedBox(
      height: 70,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          autofocus: true,
          enableSuggestions: true,
          keyboardType: TextInputType.name,
          cursorColor: Colors.grey,
          maxLines: 1,
          decoration: InputDecoration(
            hintText: "Name...",
            hintStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.grey[700],
              letterSpacing: 0.5,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.grey,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: defaultColor,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          onChanged: (value) {
            cubit.searchList.clear();
            for (var user in cubit.users) {
              if (user.name!.toLowerCase().contains(value.toLowerCase())) {
                cubit.searchList.add(user);
                cubit.rebuildSearchList(cubit.searchList);
              }
            }
          },
        ),
      ),
    );
  }
}
