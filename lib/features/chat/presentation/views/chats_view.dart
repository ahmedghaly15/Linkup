import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../linkup/presentation/views/manager/app_cubit.dart';
import '../../../../linkup/presentation/views/manager/app_states.dart';
import '../../../../core/utils/app_colors.dart';
import '/features/chat/presentation/widgets/chat_item.dart';

class ChatsView extends StatelessWidget {
  const ChatsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(
      builder: (context, state) {
        AppCubit cubit = AppCubit.getObject(context);
        return ConditionalBuilder(
          condition: cubit.users.isNotEmpty,
          builder: (context) {
            return ListView.builder(
              padding: const EdgeInsets.only(bottom: 35),
              itemCount: cubit.isSearching
                  ? cubit.searchList.length
                  : cubit.users.length,
              itemBuilder: (context, index) => ChatItem(
                model: cubit.isSearching
                    ? cubit.searchList[index]
                    : cubit.users[index],
              ),
            );
          },
          fallback: (contxt) => const Center(
            child: CircularProgressIndicator(color: AppColors.primaryColor),
          ),
        );
      },
    );
  }
}
