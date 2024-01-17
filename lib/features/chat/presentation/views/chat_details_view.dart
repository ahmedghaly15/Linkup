import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/models/user_model.dart';
import 'package:social_app/config/themes/app_colors.dart';
import 'package:social_app/config/themes/app_text_styles.dart';
import 'package:social_app/core/widgets/cached_image_error_icon.dart';
import 'package:social_app/core/widgets/get_back_arrow.dart';
import 'package:social_app/features/chat/presentation/cubits/chat_cubit.dart';
import 'package:social_app/features/chat/presentation/widgets/chat_details_view_body.dart';

class ChatDetailsView extends StatelessWidget {
  const ChatDetailsView({
    super.key,
    required this.user,
  });

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        BlocProvider.of<ChatCubit>(context).getMessages(receiverId: user.uId!);

        return Scaffold(
          appBar: _chatDetailsAppBar(),
          body: ChatDetailsViewBody(user: user),
        );
      },
    );
  }

  AppBar _chatDetailsAppBar() {
    return AppBar(
      elevation: 1.h,
      title: Row(
        children: <Widget>[
          Hero(
            tag: user.uId!,
            child: CachedNetworkImage(
              imageUrl: user.image!,
              errorWidget: (context, error, _) => const CachedImageErrorIcon(),
              imageBuilder: (_, image) {
                return CircleAvatar(
                  backgroundImage: image,
                  radius: 20.r,
                  backgroundColor: AppColors.primaryColor,
                );
              },
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
