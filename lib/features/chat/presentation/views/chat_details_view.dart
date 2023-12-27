import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/config/router/routes.dart';
import 'package:social_app/core/models/user_model.dart';
import 'package:social_app/core/utils/app_navigator.dart';
import 'package:social_app/core/utils/app_text_styles.dart';
import 'package:social_app/core/widgets/get_back_arrow.dart';
import 'package:social_app/features/chat/presentation/cubits/chat_cubit.dart';
import 'package:social_app/features/chat/presentation/widgets/chat_details_view_body.dart';

class ChatDetailsView extends StatelessWidget {
  const ChatDetailsView({
    Key? key,
    required this.user,
  }) : super(key: key);

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        BlocProvider.of<ChatCubit>(context).getMessages(receiverId: user.uId!);

        return Scaffold(
          appBar: _chatDetailsAppBar(context),
          body: ChatDetailsViewBody(user: user),
        );
      },
    );
  }

  AppBar _chatDetailsAppBar(BuildContext context) {
    return AppBar(
      elevation: 1.h,
      title: Row(
        children: <Widget>[
          Hero(
            tag: user.uId!,
            child: InkWell(
              onTap: () {
                context.navigateTo(
                  routeName: Routes.userProfileRoute,
                  arguments: user,
                );
              },
              child: CircleAvatar(
                backgroundImage: NetworkImage(user.image!),
                radius: 20.0.r,
              ),
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              user.name!,
              style: AppTextStyles.textStyle18Bold,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      leading: const GetBackArrow(),
    );
  }
}
