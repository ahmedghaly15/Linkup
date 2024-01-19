import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/models/user_model.dart';
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

        return Scaffold(body: ChatDetailsViewBody(user: user));
      },
    );
  }
}
