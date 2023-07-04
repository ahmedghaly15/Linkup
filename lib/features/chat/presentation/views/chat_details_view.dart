import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../core/global/app_styles.dart';
import '../../../../core/models/user_model.dart';
import '../../../../layout/presenetation/view/manager/app_cubit.dart';
import '../../../../layout/presenetation/view/manager/app_states.dart';
import '../../../users/presentation/views/user_profile_view.dart';
import '/core/global/app_navigator.dart';
import '/core/utils/helper.dart';
import '/features/chat/presentation/widgets/chat_details_view_body.dart';

class ChatDetailsView extends StatelessWidget {
  ChatDetailsView({Key? key, required this.userModel}) : super(key: key);

  final UserModel userModel;

  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        AppCubit.getObject(context).getMessages(
          receiverId: userModel.uId!,
        );

        return BlocBuilder<AppCubit, AppStates>(
          builder: (context, state) {
            AppCubit cubit = AppCubit.getObject(context);

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
      title: InkWell(
        onTap: () => AppNavigator.navigateTo(
          screen: UserProfileView(userModel: userModel),
        ),
        child: Row(
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
              style: AppStyles.bodyLarge.copyWith(
                fontWeight: FontWeight.bold,
                color: Get.isDarkMode ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
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
