import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/config/themes/app_text_styles.dart';
import 'package:social_app/config/themes/cubit/themes_cubit.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/config/themes/app_colors.dart';
import 'package:social_app/features/chat/presentation/widgets/custom_search_field.dart';
import 'package:social_app/features/following_and_followers/presentation/cubit/get_followers/get_followers_cubit.dart';

class ChatsSliverAppBar extends StatelessWidget {
  const ChatsSliverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetFollowersCubit, GetFollowersState>(
      builder: (context, state) {
        final GetFollowersCubit cubit =
            BlocProvider.of<GetFollowersCubit>(context);

        return SliverToBoxAdapter(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                onPressed: () =>
                    BlocProvider.of<ThemesCubit>(context).toggleTheme(),
                icon: Icon(
                  Helper.isDark(context)
                      ? Icons.wb_sunny_outlined
                      : Icons.nightlight_round_outlined,
                  size: 28.w,
                  color: Helper.isDark(context)
                      ? Colors.white
                      : AppColors.darkPrimaryColor,
                ),
              ),
              Expanded(
                child: cubit.isSearching
                    ? const CustomSearchField()
                    : Text(
                        "Chats",
                        style: AppTextStyles.textStyle20Bold,
                        textAlign: TextAlign.center,
                      ),
              ),
              IconButton(
                onPressed: () => cubit.invertIsSearching(),
                icon: Icon(
                  cubit.isSearching ? Icons.cancel : Icons.search_rounded,
                  size: 28.w,
                  color: Helper.isDark(context)
                      ? Colors.white
                      : AppColors.darkPrimaryColor,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
