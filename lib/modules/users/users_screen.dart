import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/users/user_profile_screen.dart';
import 'package:social_app/shared/constants.dart';
import 'package:social_app/styles/colors.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit, SocialAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: SocialAppCubit.getObject(context).users.isNotEmpty,
          builder: (context) {
            return GridView.builder(
              itemBuilder: (context, index) {
                return buildUserItem(
                  context: context,
                  userModel: SocialAppCubit.getObject(context).users[index],
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
            child: CircularProgressIndicator(color: defaultColor),
          ),
        );
      },
    );
  }

  Widget buildUserItem({
    required BuildContext context,
    required UserModel userModel,
  }) {
    return GestureDetector(
      onTap: () {
        navigateTo(
          context,
          UserProfileScreen(userModel: userModel),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: defaultColor.withOpacity(0.6),
        elevation: 10,
        shadowColor: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 45.5,
              child: CircleAvatar(
                backgroundImage: NetworkImage(userModel.image!),
                radius: 45.5,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              userModel.name!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Colors.white),
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Icon(
                  Icons.touch_app,
                  color: Colors.white,
                  size: 25,
                ),
                const SizedBox(width: 5),
                Text(
                  "Visit",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
