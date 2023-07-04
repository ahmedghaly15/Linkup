import 'package:flutter/material.dart';

import '../../../../core/models/user_model.dart';
import '../../../../core/utils/size_config.dart';

class MeProfileAndCoverImages extends StatelessWidget {
  const MeProfileAndCoverImages({
    Key? key,
    required this.userModel,
  }) : super(key: key);

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: <Widget>[
        Align(
          alignment: AlignmentDirectional.topCenter,
          child: Container(
            height: SizeConfig.screenHeight! * 0.25,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
              ),
              image: DecorationImage(
                image: NetworkImage(userModel.cover!),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        CircleAvatar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          radius: 54,
          child: CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(userModel.image!),
          ),
        ),
      ],
    );
  }
}
