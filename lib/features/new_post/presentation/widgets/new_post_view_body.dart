import 'package:flutter/material.dart';

import '../../../../core/utils/size_config.dart';
import '../../../../layout/presentation/view/manager/app_cubit.dart';
import '../../../../layout/presentation/view/manager/app_states.dart';
import '/core/global/app_colors.dart';
import '/core/models/user_model.dart';
import 'add_photos_and_tags_buttons.dart';
import 'new_post_text_field.dart';
import 'post_image.dart';
import 'user_name_and_image.dart';

class NewPostViewBody extends StatelessWidget {
  const NewPostViewBody({
    Key? key,
    required this.cubit,
    required this.state,
    required this.textController,
    required this.model,
  }) : super(key: key);

  final AppCubit cubit;
  final TextEditingController textController;
  final UserModel model;
  final AppStates state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          if (state is CreatePostLoadingState)
            const LinearProgressIndicator(color: AppColors.primaryColor),
          if (state is CreatePostLoadingState)
            SizedBox(
              height: SizeConfig.screenHeight! * 0.01,
            ),
          UserNameAndImage(model: model),
          SizedBox(
            height: SizeConfig.screenHeight! * 0.006,
          ),
          NewPostTextField(textController: textController, model: model),
          SizedBox(
            height: SizeConfig.screenHeight! * 0.01,
          ),
          if (cubit.postImage != null) PostImage(cubit: cubit),
          SizedBox(
            height: SizeConfig.screenHeight! * 0.008,
          ),
          AddPhotosAndTagsButtons(cubit: cubit),
        ],
      ),
    );
  }
}
