import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/core/models/user_model.dart';
import 'package:social_app/config/themes/app_colors.dart';
import 'package:social_app/core/utils/app_assets.dart';
import 'package:social_app/core/widgets/custom_circle_icon_button.dart';
import 'package:social_app/core/widgets/custom_text_form_field.dart';
import 'package:social_app/core/widgets/get_image_icon_button.dart';
import 'package:social_app/features/chat/domain/entities/send_message_params.dart';
import 'package:social_app/features/chat/presentation/cubits/chat_cubit.dart';

class CustomMessengerField extends StatefulWidget {
  const CustomMessengerField({
    super.key,
    required this.user,
  });

  final UserModel user;

  @override
  State<CustomMessengerField> createState() => _CustomMessengerFieldState();
}

class _CustomMessengerFieldState extends State<CustomMessengerField> {
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Flexible(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            color: Helper.isDark(context)
                ? AppColors.darkPrimaryColor
                : AppColors.scaffoldBackgroundClr,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Row(
                children: <Widget>[
                  GetImageIconButton(
                    onPressed: () {
                      BlocProvider.of<ChatCubit>(context).getMessageImage(
                        source: ImageSource.camera,
                      );
                    },
                    icon: Icons.camera_alt_rounded,
                  ),
                  GetImageIconButton(
                    onPressed: () {
                      BlocProvider.of<ChatCubit>(context).getMessageImage(
                        source: ImageSource.gallery,
                      );
                    },
                    icon: Icons.image_rounded,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          CustomTextFormField(
                            controller: _messageController,
                            enableSuggestions: true,
                            textCapitalization: TextCapitalization.sentences,
                            maxLines: null,
                            keyboardType: TextInputType.multiline,
                            hintText: '',
                            hasPrefixIcon: false,
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            filled: false,
                            contentPadding: EdgeInsets.only(
                              left: 5.w,
                              right: 16.w,
                            ),
                            onChanged: (value) {
                              setState(() {
                                _messageController.text = value;
                              });
                            },
                          ),
                          if (BlocProvider.of<ChatCubit>(context)
                                  .messageImage !=
                              null) ...[
                            SizedBox(height: 4.h),
                            Stack(
                              alignment: AlignmentDirectional.topEnd,
                              children: <Widget>[
                                Container(
                                  height: 120.h,
                                  margin: EdgeInsets.only(
                                    right: 8.w,
                                    bottom: 8.h,
                                  ),
                                  width: double.infinity,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8.r),
                                    ),
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: FileImage(
                                        BlocProvider.of<ChatCubit>(context)
                                            .messageImage!,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 10.h,
                                  right: 16.w,
                                  child: CircleAvatar(
                                    radius: 15.r,
                                    backgroundColor: Colors.white,
                                    child: IconButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: () =>
                                          BlocProvider.of<ChatCubit>(context)
                                              .removeMessageImage(),
                                      icon: Icon(
                                        Icons.close,
                                        color: AppColors.primaryColor,
                                        size: 20.w,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        CustomCircleIconButton(
          onPressed: (_messageController.text.trim().isEmpty &&
                  BlocProvider.of<ChatCubit>(context).messageImage == null)
              ? null
              : () => _sendMessage(context),
          icon: Image.asset(AppAssets.iconsSend),
          backgroundColor: (_messageController.text.trim().isEmpty &&
                  BlocProvider.of<ChatCubit>(context).messageImage == null)
              ? Colors.grey
              : AppColors.primaryColor,
        ),
      ],
    );
  }

  void _sendMessage(BuildContext context) {
    if (BlocProvider.of<ChatCubit>(context).messageImage == null) {
      BlocProvider.of<ChatCubit>(context).sendMessage(
        params: SendMessageParams(
          receiverId: widget.user.uId!,
          receiverName: widget.user.name!,
          date: Helper.getDate(),
          time: TimeOfDay.now().format(context),
          text: _messageController.text.trim(),
        ),
      );
    }
    if (BlocProvider.of<ChatCubit>(context).messageImage != null) {
      BlocProvider.of<ChatCubit>(context).uploadMessageImage(
        params: SendMessageParams(
          receiverId: widget.user.uId!,
          receiverName: widget.user.name!,
          date: Helper.getDate(),
          time: TimeOfDay.now().format(context),
          text: _messageController.text.trim(),
        ),
      );
    }
    _messageController.clear();
    BlocProvider.of<ChatCubit>(context).removeMessageImage();
  }
}
