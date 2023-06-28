import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/global/app_styles.dart';
import '../../../../core/models/user_model.dart';

class NewPostTextField extends StatelessWidget {
  const NewPostTextField({
    Key? key,
    required this.textController,
    required this.model,
  }) : super(key: key);

  final TextEditingController textController;
  final UserModel model;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: SingleChildScrollView(
          child: TextFormField(
            maxLines: null,
            controller: textController,
            enableSuggestions: true,
            style: AppStyles.bodySmall.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.normal,
              height: 1.4,
              letterSpacing: 0.8,
            ),
            cursorColor: Get.isDarkMode ? Colors.white60 : Colors.black,
            textCapitalization: TextCapitalization.sentences,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              hintText: "What's in your mind, ${model.name!.split(' ')[0]}",
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}
