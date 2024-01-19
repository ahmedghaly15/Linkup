import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/config/themes/app_colors.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/core/utils/app_assets.dart';
import 'package:social_app/features/linkup/presentation/cubits/linkup_cubit.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LinkupCubit, LinkupState>(
      builder: (context, state) {
        final LinkupCubit cubit = BlocProvider.of<LinkupCubit>(context);

        double changePositionedOfLine() {
          switch (BlocProvider.of<LinkupCubit>(context).currentIndex) {
            case 0:
              return 15.w;

            case 1:
              return 115.w;

            case 2:
              return 215.w;

            case 3:
              return 312.w;

            default:
              return 0;
          }
        }

        List<String> icons = const <String>[
          AppAssets.iconsHome,
          AppAssets.iconsChat,
          AppAssets.iconsUser,
          AppAssets.iconsNotification,
        ];

        return BottomAppBar(
          color: Helper.isDark(context)
              ? AppColors.darkPrimaryColor
              : AppColors.primaryColor,
          shape: const CircularNotchedRectangle(),
          notchMargin: 8.h,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              icons.length,
              (index) => Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                    style: ButtonStyle(
                      padding: MaterialStatePropertyAll(
                        EdgeInsets.symmetric(horizontal: 16.w),
                      ),
                    ),
                    onPressed: () => cubit.changeBottomNavIndex(index, context),
                    icon: Image.asset(icons[index]),
                  ),
                  if (cubit.currentIndex == index) ...[
                    SizedBox(height: 4.h),
                    Container(
                      width: 23.w,
                      height: 3.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5.r)),
                      ),
                    ),
                  ],
                ],
              ),
              growable: false,
            ),
          ),
        );
      },
    );
  }
}
