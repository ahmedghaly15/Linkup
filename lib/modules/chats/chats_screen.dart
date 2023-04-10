import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/shared/constants.dart';
import 'package:social_app/styles/colors.dart';
// import 'package:social_app/styles/colors.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../models/user_model.dart';
import '../chat_details/chat_details_screen.dart';

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
              // separatorBuilder: (context, index) => const SizedBox(height: 0),
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
          // color: Get.isDarkMode ? darkHeaderClr : Colors.white,
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
              title: Text(model.name!),

              // ============== User's About ==============
              subtitle: Text(
                model.bio!,
                maxLines: 1,
              ),
            ),
          ),
        ),
      );
}


/*
Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10.0,
        ),
        child: InkWell(
          onTap: () {},
          child: Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20.0,
                horizontal: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const CircleAvatar(
                    radius: 28,
                    backgroundImage: NetworkImage(
                        'https://img.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg?w=1060&t=st=1681075775~exp=1681076375~hmac=2134dd4aa83544d091497538f5048259f46472da4cd87d165f8a09f9da0f0e1b'),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text("Ahmed Ghaly"),
                      const SizedBox(height: 5),
                      Text("Flutter Developer",
                          style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
 */
/*
          My Divider

Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 15.0,
                  horizontal: 5,
                ),
                child: Container(
                  width: double.infinity,
                  height: 1.5,
                  color: Colors.grey[300],
                ),
              ),

 */


/*

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/models/chat_user.dart';
import '/screens/chat_screen.dart';
import '/theme.dart';

class ChatUserCard extends StatefulWidget {
  final ChatUser user;
  const ChatUserCard({super.key, required this.user});

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {
  @override
  Widget build(BuildContext context) {
    return 
  }
}


 */