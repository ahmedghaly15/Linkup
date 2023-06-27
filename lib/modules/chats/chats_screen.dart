import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../core/models/user_model.dart';
import '/layout/cubit/cubit.dart';
import '/layout/cubit/states.dart';
import '/shared/constants.dart';
import '/styles/thems.dart';
import 'chat_details_screen.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit, SocialAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        SocialAppCubit cubit = SocialAppCubit.getObject(context);
        return ConditionalBuilder(
          condition: cubit.users.isNotEmpty,
          builder: (context) {
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: cubit.isSearching
                  ? cubit.searchList.length
                  : cubit.users.length,
              itemBuilder: (context, index) => buildChatItem(
                context: context,
                model: cubit.isSearching
                    ? cubit.searchList[index]
                    : cubit.users[index],
              ),
            );
          },
          fallback: (contxt) => const Center(
              child: CircularProgressIndicator(color: defaultColor)),
        );
      },
    );
  }

  Widget buildChatItem({
    required BuildContext context,
    required UserModel model,
  }) =>
      InkWell(
        onTap: () => navigateTo(context, ChatDetailsScreen(userModel: model)),
        child: Card(
          color: Get.isDarkMode ? darkHeaderClr.withOpacity(0) : Colors.white,
          margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.025,
            vertical: 4,
          ),
          elevation: 1.5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
            child: ListTile(
              // ============== User Profile Picture ==============
              leading: Hero(
                tag: model.uId!,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(model.image!),
                  radius: 28,
                ),
              ),
              // ============== Username ==============
              title: Text(
                model.name!,
                style: bodyLarge.copyWith(fontWeight: FontWeight.bold),
              ),
              // ============== User's Bio ==============
              subtitle: Text(
                model.bio!,
                style: caption.copyWith(fontSize: 14),
                maxLines: 1,
              ),
            ),
          ),
        ),
      );
}
