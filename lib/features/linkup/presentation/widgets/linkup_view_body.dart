import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/features/linkup/presentation/cubits/linkup_cubit.dart';
import 'package:social_app/features/posts/presentation/cubits/posts_cubit.dart';
import 'package:social_app/features/users/presentation/cubits/user_cubit.dart';

class LinkupViewBody extends StatelessWidget {
  const LinkupViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LinkupCubit, LinkupState>(
      builder: (context, state) {
        final LinkupCubit linkupCubit = BlocProvider.of<LinkupCubit>(context);

        return BlocBuilder<UserCubit, UserState>(builder: (context, state) {
          final UserCubit userCubit = BlocProvider.of<UserCubit>(context);

          return WillPopScope(
            onWillPop: () {
              if (userCubit.isSearching) {
                userCubit.invertIsSearching();
                return Future.value(false);
              }

              if (linkupCubit.currentIndex != 0) {
                if (linkupCubit.currentIndex == 3) {
                  BlocProvider.of<PostsCubit>(context).getPosts();
                }
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
