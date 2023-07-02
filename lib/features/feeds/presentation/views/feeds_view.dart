import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/helper.dart';
import '../../../../layout/presenetation/view/manager/app_cubit.dart';
import '../../../../layout/presenetation/view/manager/app_states.dart';
import '/features/feeds/presentation/widgets/post_item.dart';

class FeedsView extends StatelessWidget {
  const FeedsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(
      builder: (context, state) {
        return ConditionalBuilder(
          condition: AppCubit.getObject(context).posts.isNotEmpty &&
              Helper.model != null,
          builder: (context) => SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: <Widget>[
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => PostItem(
                    context: context,
                    postModel: AppCubit.getObject(context).posts[index],
                  ),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 8),
                  itemCount: AppCubit.getObject(context).posts.length,
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
