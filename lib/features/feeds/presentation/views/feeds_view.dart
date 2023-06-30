import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/features/feeds/presentation/widgets/post_item.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';

class FeedsView extends StatelessWidget {
  const FeedsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocialAppCubit, SocialAppStates>(
      builder: (context, state) {
        return ConditionalBuilder(
          condition: SocialAppCubit.getObject(context).posts.isNotEmpty &&
              SocialAppCubit.getObject(context).model != null,
          builder: (context) => SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: <Widget>[
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => PostItem(
                    context: context,
                    postModel: SocialAppCubit.getObject(context).posts[index],
                  ),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 8),
                  itemCount: SocialAppCubit.getObject(context).posts.length,
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
          fallback: (context) => const Column(
            children: <Widget>[],
          ),
        );
      },
    );
  }
}
