import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/config/themes/cubit/themes_cubit.dart';
import 'package:social_app/core/utils/app_colors.dart';
import 'package:social_app/features/chat/presentation/widgets/custom_search_field.dart';
import 'package:social_app/features/linkup/presentation/cubits/linkup_cubit.dart';

class ChatsSliverAppBar extends StatelessWidget {
  const ChatsSliverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LinkupCubit, LinkupState>(
      builder: (context, state) {
        final LinkupCubit cubit = BlocProvider.of<LinkupCubit>(context);

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
                  themeState.brightness == Brightness.dark
                      ? Icons.wb_sunny_outlined
                      : Icons.nightlight_round_outlined,
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
