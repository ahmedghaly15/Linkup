import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/global/app_styles.dart';
import '../../../../core/models/post_model.dart';
import '../../../../core/utils/helper.dart';
import '../../../../layout/presenetation/view/manager/app_cubit.dart';

class TopPostItemSection extends StatelessWidget {
  const TopPostItemSection({
    super.key,
    required this.model,
  });

  final PostModel model;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage(model.image!),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    model.name!,
                    style: AppStyles.bodyLarge.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  // const SizedBox(width: 5),
                  // Icon(
                  //   Helper.model!.name == "Ahmed Ghaly" ||
                  //           Helper.model!.name == "Abo Ghaly"
                  //       ? Icons.verified
                  //       : null,
                  //   size: 16,
                  //   color: Colors.blue,
                  // ),
                ],
              ),
              Text(
                "${model.date} at ${model.time}",
                style: AppStyles.caption,
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () {
            AppCubit.getObject(context).deletePost(
              postId: model.postId!,
              context: context,
            );
          },
          icon: Icon(
            model.uId == Helper.model!.uId ? Icons.delete : Icons.more_horiz,
            size: 25,
            color: model.uId == Helper.model!.uId
                ? Colors.red
                : (Get.isDarkMode ? Colors.white : Colors.black),
          ),
        ),
      ],
    );
  }
}
