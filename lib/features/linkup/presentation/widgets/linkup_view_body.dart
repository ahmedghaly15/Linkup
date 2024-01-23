import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/features/following_and_followers/presentation/cubit/get_followers/get_followers_cubit.dart';
import 'package:social_app/features/linkup/presentation/cubits/linkup_cubit.dart';

class LinkupViewBody extends StatelessWidget {
  const LinkupViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LinkupCubit, LinkupState>(
      builder: (context, state) {
        final LinkupCubit linkupCubit = BlocProvider.of<LinkupCubit>(context);

        return BlocBuilder<GetFollowersCubit, GetFollowersState>(
            builder: (context, state) {
          final GetFollowersCubit followersCubit =
              BlocProvider.of<GetFollowersCubit>(context);

          return WillPopScope(
            onWillPop: () {
              if (followersCubit.isSearching) {
                followersCubit.invertIsSearching();
                return Future.value(false);
              }

              if (linkupCubit.currentIndex != 0) {
                linkupCubit.changeBottomNavToHome(context);
                return Future.value(false);
              }

              return Future.value(true);
            },
            child: linkupCubit.getBody()[linkupCubit.currentIndex],
          );
        });
      },
    );
  }
}
