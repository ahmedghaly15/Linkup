import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:social_app/core/global/app_colors.dart';
import 'package:social_app/features/users/presentation/widgets/user_item.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';

class UsersView extends StatelessWidget {
  const UsersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocialAppCubit, SocialAppStates>(
      builder: (context, state) {
        return ConditionalBuilder(
          condition: SocialAppCubit.getObject(context).users.isNotEmpty,
          builder: (context) {
            return GridView.builder(
              itemBuilder: (context, index) {
                return AnimationConfiguration.staggeredGrid(
                  position: index,
                  duration: const Duration(milliseconds: 650),
                  columnCount: SocialAppCubit.getObject(context).users.length,
                  child: ScaleAnimation(
                    child: FadeInAnimation(
                      child: UserItem(
                        userModel:
                            SocialAppCubit.getObject(context).users[index],
                      ),
                    ),
                  ),
                );
              },
              itemCount: SocialAppCubit.getObject(context).users.length,
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
              scrollDirection: Axis.vertical,
              reverse: false,
              primary: true,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              dragStartBehavior: DragStartBehavior.start,
              clipBehavior: Clip.hardEdge,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300,
                mainAxisExtent: 220,
                mainAxisSpacing: 20,
                crossAxisSpacing: 10,
                childAspectRatio: 3 / 2,
              ),
            );
          },
          fallback: (context) => const Center(
            child: CircularProgressIndicator(color: AppColors.primaryColor),
          ),
        );
      },
    );
  }
}
