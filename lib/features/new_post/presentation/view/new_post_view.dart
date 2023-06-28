import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:social_app/core/utils/helper.dart';
import 'package:social_app/features/new_post/presentation/widgets/new_post_view_body.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';

import '../../../../core/models/user_model.dart';
import '../../../../shared/constants.dart';

class NewPostView extends StatelessWidget {
  const NewPostView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocialAppCubit, SocialAppStates>(
      builder: (context, state) {
        SocialAppCubit cubit = SocialAppCubit.getObject(context);
        UserModel model = cubit.model!;
        TextEditingController textController = TextEditingController();
        return Scaffold(
          backgroundColor: context.theme.colorScheme.background,
          appBar: buildAppBar(context, cubit, textController),
          body: NewPostViewBody(
            cubit: cubit,
            model: model,
            textController: textController,
            state: state,
          ),
        );
      },
    );
  }

  AppBar buildAppBar(BuildContext context, SocialAppCubit cubit,
      TextEditingController textController) {
    return appBarBuilder(
      context: context,
      title: "Create Post",
      centerTitle: false,
      actions: <Widget>[
        defaultTextButton(
          onPressed: () {
            FocusScope.of(context).unfocus();
            if (cubit.postImage == null) {
              cubit.createPost(
                date: getDate(),
                time: DateFormat.jm().format(DateTime.now()),
                text: textController.text,
              );
            } else {
              cubit.uploadPostImage(
                date: getDate(),
                time: DateFormat.jm().format(DateTime.now()),
                text: textController.text,
              );
            }
          },
          title: 'POST',
        ),
      ],
    );
  }
}
