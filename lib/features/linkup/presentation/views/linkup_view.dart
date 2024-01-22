import 'package:flutter/material.dart';
import 'package:social_app/features/linkup/presentation/widgets/custom_bottom_nav_bar.dart';
import 'package:social_app/features/linkup/presentation/widgets/linkup_view_body.dart';
import 'package:social_app/features/linkup/presentation/widgets/new_post_floating_button.dart';

class LinkupView extends StatelessWidget {
  const LinkupView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LinkupViewBody(),
      bottomNavigationBar: CustomBottomNavigationBar(),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: NewPostFloatingButton(),
    );
  }
}
