import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../core/services/theme_service.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../widgets/new_post_floating_button.dart';
import '/core/global/app_colors.dart';
import '/core/utils/helper.dart';
import '/layout/presenetation/widgets/custom_search_field.dart';
import '/layout/presenetation/widgets/layout_view_body.dart';
import 'manager/app_cubit.dart';
import 'manager/app_states.dart';

class LayoutView extends StatelessWidget {
  const LayoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(
      builder: (context, state) {
        AppCubit cubit = AppCubit.getObject(context);
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
              appBar: buildAppBar(context, cubit),
              body: LayoutViewBody(cubit: cubit),
              bottomNavigationBar: CustomBottomNavigationBar(cubit: cubit),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              floatingActionButton: const NewPostFloatingButton(),
            ),
          ),
        );
      },
    );
  }

  AppBar buildAppBar(BuildContext context, AppCubit cubit) {
    return AppBar(
      backgroundColor: context.theme.colorScheme.background,
      title:
          cubit.isSearching ? CustomSearchField(cubit: cubit) : const Text(""),
      leading: IconButton(
        onPressed: () {
          BlocProvider.of<ThemeService>(context).toggleTheme();
        },
        icon: Icon(
          cubit.currentIndex == 2
              ? Get.isDarkMode
                  ? Icons.wb_sunny_outlined
                  : Icons.nightlight_round_outlined
              : null,
          size: 28,
          color: Get.isDarkMode ? Colors.white : AppColors.darkGreyClr,
        ),
      ),
      actions: <Widget>[
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications, color: AppColors.primaryColor),
        ),
        if (cubit.currentIndex == 1)
          IconButton(
            onPressed: () {
              cubit.invertIsSearching();
            },
            icon: Icon(
              cubit.isSearching ? Icons.cancel : Icons.search_rounded,
              color: AppColors.primaryColor,
            ),
          ),
      ],
      systemOverlayStyle: Helper.setSystemOverlayStyle(),
    );
  }
}
