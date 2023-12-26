import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/features/linkup/presentation/cubits/linkup_cubit.dart';

class LinkupViewBody extends StatelessWidget {
  const LinkupViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LinkupCubit, LinkupState>(
      builder: (context, state) {
        final LinkupCubit cubit = BlocProvider.of<LinkupCubit>(context);

        return WillPopScope(
          onWillPop: () {
            if (cubit.currentIndex == 1 && cubit.isSearching) {
              cubit.invertIsSearching();
              return Future.value(false);
            }
            if (cubit.currentIndex != 0) {
              cubit.changeBottomNavToHome(context);
              return Future.value(false);
            }
            return Future.value(true);
          },
          child: cubit.getBody()[cubit.currentIndex],
        );
      },
    );
  }
}
