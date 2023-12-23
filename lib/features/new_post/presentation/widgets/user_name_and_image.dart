import 'package:flutter/material.dart';

import '../../../../core/utils/app_text_styles.dart';
import '../../../../core/models/user_model.dart';

class UserNameAndImage extends StatelessWidget {
  const UserNameAndImage({
    Key? key,
    required this.model,
  }) : super(key: key);

  final UserModel model;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        CircleAvatar(
          backgroundImage: NetworkImage(model.image!),
          radius: 25,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            model.name!,
            style: AppTextStyles.textStyle18.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ],
    );
  }
}
