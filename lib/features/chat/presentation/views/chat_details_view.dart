import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:social_app/core/global/app_navigator.dart';
import 'package:social_app/core/utils/helper.dart';
import 'package:social_app/features/chat/presentation/widgets/chat_details_view_body.dart';
import 'package:social_app/layout/cubit/states.dart';

import '../../../../core/global/app_styles.dart';
import '../../../../core/models/user_model.dart';
import '../../../../layout/cubit/cubit.dart';

class ChatDetailsView extends StatelessWidget {
  ChatDetailsView({Key? key, required this.userModel}) : super(key: key);

  final UserModel userModel;

  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        SocialAppCubit.getObject(context).getMessages(
          receiverId: userModel.uId!,
        );

        return BlocBuilder<SocialAppCubit, SocialAppStates>(
          builder: (context, state) {
            SocialAppCubit cubit = SocialAppCubit.getObject(context);

            return Scaffold(
              backgroundColor: context.theme.colorScheme.background,
              appBar: buildAppBar(context),
              body: ChatDetailsViewBody(
                cubit: cubit,
                userModel: userModel,
                messageController: messageController,
              ),
            );
          },
        );
      },
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: context.theme.colorScheme.background,
      titleSpacing: 0.0,
      elevation: 1,
      title: Row(
        children: <Widget>[
          Hero(
            tag: userModel.uId!,
            child: CircleAvatar(
              backgroundImage: NetworkImage(userModel.image!),
              radius: 20.0,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            userModel.name!,
            style: AppStyles.bodyLarge.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
      leading: IconButton(
        onPressed: () => AppNavigator.getBack(),
        icon: Icon(
          Icons.arrow_back_ios,
          color: Get.isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      systemOverlayStyle: Helper.setSystemOverlayStyle(),
    );
  }
}
