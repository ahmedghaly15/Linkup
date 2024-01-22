import 'package:flutter/material.dart';
import 'package:social_app/core/models/user_model.dart';
import 'package:social_app/features/chat/presentation/widgets/chat_details_view_body.dart';

class ChatDetailsView extends StatelessWidget {
  const ChatDetailsView({
    super.key,
    required this.user,
  });

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ChatDetailsViewBody(user: user));
  }
}
