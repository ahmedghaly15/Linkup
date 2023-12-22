import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/config/themes/cubit/themes_cubit.dart';
import 'package:social_app/core/utils/app_navigator.dart';

class GetBackArrow extends StatelessWidget {
  const GetBackArrow({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemesCubit, ThemeData>(builder: (context, state) {
      return IconButton(
        onPressed: () => context.getBack(),
        icon: Icon(
          Icons.arrow_back_ios_new,
          color: state.brightness == Brightness.light
              ? Colors.black
              : Colors.white,
          size: 28.w,
        ),
      );
    });
  }
}
