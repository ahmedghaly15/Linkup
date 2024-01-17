import 'package:flutter/material.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/core/widgets/custom_text_form_field.dart';

class NewPostTextField extends StatelessWidget {
  const NewPostTextField({
    super.key,
    required this.textController,
  });

  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      maxLines: null,
      controller: textController,
      enableSuggestions: true,
      textCapitalization: TextCapitalization.sentences,
      keyboardType: TextInputType.multiline,
      hintText:
          "What's in your mind, ${Helper.currentUser!.name!.split(' ')[0]}",
      border: InputBorder.none,
      enabledBorder: InputBorder.none,
      focusedBorder: InputBorder.none,
    );
  }
}
