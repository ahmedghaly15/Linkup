import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/config/themes/cubit/themes_cubit.dart';
import 'package:social_app/core/utils/app_colors.dart';
import 'package:social_app/features/linkup/presentation/cubits/linkup_cubit.dart';
import 'package:social_app/features/linkup/presentation/widgets/custom_bottom_nav_bar.dart';
import 'package:social_app/features/linkup/presentation/widgets/custom_search_field.dart';
import 'package:social_app/features/linkup/presentation/widgets/linkup_view_body.dart';
import 'package:social_app/features/linkup/presentation/widgets/new_post_floating_button.dart';

class LinkupView extends StatelessWidget {
  const LinkupView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LinkupCubit, LinkupState>(
      builder: (context, state) {
        final LinkupCubit cubit = BlocProvider.of<LinkupCubit>(context);

        return Scaffold(
          // appBar: _buildAppBar(context, cubit),
          body: const LinkupViewBody(),
          bottomNavigationBar: CustomBottomNavigationBar(cubit: cubit),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: const NewPostFloatingButton(),
        );
      },
    );
  }

  AppBar _buildAppBar(BuildContext context, LinkupCubit cubit) {
    return AppBar(
      title:
          cubit.isSearching ? CustomSearchField(cubit: cubit) : const Text(""),
      leading: BlocBuilder<ThemesCubit, ThemeData>(
        builder: (context, themeState) {
          return IconButton(
            onPressed: () =>
                BlocProvider.of<ThemesCubit>(context).toggleTheme(),
            icon: Icon(
              cubit.currentIndex == 2
                  ? themeState.brightness == Brightness.dark
                      ? Icons.wb_sunny_outlined
                      : Icons.nightlight_round_outlined
                  : null,
              size: 28.w,
              color: themeState.brightness == Brightness.dark
                  ? Colors.white
                  : AppColors.darkGreyClr,
            ),
          );
        },
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
    );
  }
}
