import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/config/themes/cubit/themes_cubit.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/config/themes/app_colors.dart';
import 'package:social_app/core/widgets/get_back_arrow.dart';

class CustomAuthSliverAppBar extends StatelessWidget {
  const CustomAuthSliverAppBar({
    super.key,
    required this.hasLeading,
  });

  final bool hasLeading;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: hasLeading ? const GetBackArrow() : const SizedBox(),
      actions: <Widget>[
        BlocBuilder<ThemesCubit, ThemeData>(
          builder: (context, state) {
            return IconButton(
              onPressed: () {
                BlocProvider.of<ThemesCubit>(context).toggleTheme();
              },
              icon: Icon(
                Helper.isDark(state)
                    ? Icons.wb_sunny_outlined
                    : Icons.nightlight_round_outlined,
                size: 28.w,
                color:
                    Helper.isDark(state) ? Colors.white : AppColors.darkGreyClr,
              ),
            );
          },
        ),
      ],
    );
  }
}
