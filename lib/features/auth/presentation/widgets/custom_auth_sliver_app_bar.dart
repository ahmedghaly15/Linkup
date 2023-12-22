import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/config/themes/cubit/themes_cubit.dart';
import 'package:social_app/core/utils/app_colors.dart';

class CustomAuthSliverAppBar extends StatelessWidget {
  const CustomAuthSliverAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(leading: BlocBuilder<ThemesCubit, ThemeData>(
      builder: (context, state) {
        return IconButton(
          onPressed: () {
            BlocProvider.of<ThemesCubit>(context).toggleTheme();
          },
          icon: Icon(
            state.brightness == Brightness.dark
                ? Icons.wb_sunny_outlined
                : Icons.nightlight_round_outlined,
            size: 28,
            color: state.brightness == Brightness.dark
                ? Colors.white
                : AppColors.darkGreyClr,
          ),
        );
      },
    ));
  }
}
