import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '/layout/cubit/cubit.dart';
import '/layout/cubit/states.dart';
import '/models/user_model.dart';
import '/shared/constants.dart';
import '/styles/thems.dart';

class NewPostScreen extends StatelessWidget {
  const NewPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit, SocialAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        SocialAppCubit cubit = SocialAppCubit.getObject(context);
        UserModel model = cubit.model!;
        TextEditingController textController = TextEditingController();
        return Scaffold(
          backgroundColor: context.theme.colorScheme.background,
          appBar: appBarBuilder(
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
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                if (state is CreatePostLoadingState)
                  const LinearProgressIndicator(color: defaultColor),
                if (state is CreatePostLoadingState) const SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: NetworkImage(model.image!),
                      radius: 25,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        model.name!,
                        style: bodyLarge.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: TextFormField(
                      maxLines: 8,
                      controller: textController,
                      enableSuggestions: true,
                      style: bodySmall.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        height: 1.4,
                        letterSpacing: 0.8,
                      ),
                      cursorColor:
                          Get.isDarkMode ? Colors.white60 : Colors.black,
                      textCapitalization: TextCapitalization.sentences,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        hintText:
                            "What's in your mind, ${model.name!.split(' ')[0]}",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                if (cubit.postImage != null)
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: <Widget>[
                      Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                            image: FileImage(cubit.postImage!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.white,
                          child: IconButton(
                            onPressed: () => cubit.removePostImage(),
                            icon: const Icon(
                              Icons.close,
                              color: defaultColor,
                              size: 25,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 20),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextButton(
                        onPressed: () => buildBottomSheet(
                          type: "Cover",
                          context: context,
                          onPressedCamera: () => cubit.getPostImage(
                            source: ImageSource.camera,
                          ),
                          onPressedGallery: () => cubit.getPostImage(
                            source: ImageSource.gallery,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const <Widget>[
                            Icon(
                              Icons.image,
                              color: defaultColor,
                              size: 22,
                            ),
                            SizedBox(width: 5),
                            Text(
                              "Add photo",
                              style:
                                  TextStyle(fontSize: 16, color: defaultColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          "# Tags",
                          style: TextStyle(fontSize: 16, color: defaultColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
