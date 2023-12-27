import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/config/themes/cubit/themes_cubit.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/core/utils/app_colors.dart';
import 'package:social_app/features/chat/presentation/widgets/custom_search_field.dart';
import 'package:social_app/features/users/presentation/cubits/user_cubit.dart';

class ChatsSliverAppBar extends StatelessWidget {
  const ChatsSliverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        final UserCubit cubit = BlocProvider.of<UserCubit>(context);

        return SliverAppBar(
          title: cubit.isSearching
              ? CustomSearchField(cubit: cubit)
              : const SizedBox(),
          leading: BlocBuilder<ThemesCubit, ThemeData>(
            builder: (context, themeState) {
              return IconButton(
                onPressed: () =>
                    BlocProvider.of<ThemesCubit>(context).toggleTheme(),
                icon: Icon(
                  Helper.isDark(themeState)
                      ? Icons.wb_sunny_outlined
                      : Icons.nightlight_round_outlined,
                  size: 28.w,
                  color: Helper.isDark(themeState)
                      ? Colors.white
                      : AppColors.darkGreyClr,
                ),
              );
            },
          ),
          actions: <Widget>[
            IconButton(
              onPressed: () => cubit.invertIsSearching(),
              icon: Icon(
                cubit.isSearching ? Icons.cancel : Icons.search_rounded,
                color: AppColors.primaryColor,
              ),
            ),
          ],
        );
      },
    );
  }
}