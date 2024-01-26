import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/features/linkup/presentation/cubits/linkup_cubit.dart';
import 'package:social_app/features/linkup/presentation/widgets/custom_bottom_nav_bar.dart';
import 'package:social_app/features/linkup/presentation/widgets/linkup_view_body.dart';
import 'package:social_app/features/linkup/presentation/widgets/new_post_floating_button.dart';

class LinkupView extends StatelessWidget {
  const LinkupView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LinkupCubit, LinkupState>(
      builder: (context, state) {
        return Scaffold(
          body: const LinkupViewBody(),
          bottomNavigationBar: const CustomBottomNavigationBar(),
          // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton:
              BlocProvider.of<LinkupCubit>(context).currentIndex != 2
                  ? const NewPostFloatingButton()
                  : null,
        );
      },
    );
  }
}
