import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/core/utils/app_strings.dart';
import 'package:social_app/features/chat/data/datasources/chat_datasource.dart';
import 'package:social_app/features/chat/data/models/message_model.dart';
import 'package:social_app/features/chat/domain/entities/send_message_params.dart';
import 'package:social_app/features/chat/domain/entities/setting_up_chat_params.dart';
import 'package:social_app/service_locator.dart';

class ChatDataSourceImpl implements ChatDataSource {
  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getMessages({
    required String receiverId,
  }) {
    return getIt
        .get<FirebaseFirestore>()
        .collection(AppStrings.users)
        .doc(Helper.currentUser!.uId)
        .collection(AppStrings.chats)
        .doc(receiverId)
        .collection(AppStrings.messages)
        .orderBy(
          'dateTime',
          descending: true,
        )
        .snapshots();
  }

  Future<DocumentReference<Map<String, dynamic>>> _settingUpSenderChat({
    required SettingUpChatParams settingUpChatParams,
  }) async {
    return await getIt
        .get<FirebaseFirestore>()
        .collection(AppStrings.users)
        .doc(Helper.currentUser!.uId)
        .collection(AppStrings.chats)
        .doc(settingUpChatParams.receiverId)
        .collection(AppStrings.messages)
        .add(settingUpChatParams.messageModel.toJson());
  }

  Future<DocumentReference<Map<String, dynamic>>> _settingUpReceiverChat({
    required SettingUpChatParams settingUpChatParams,
  }) async {
    return await getIt
        .get<FirebaseFirestore>()
        .collection(AppStrings.users)
        .doc(settingUpChatParams.receiverId)
        .collection(AppStrings.chats)
        .doc(Helper.currentUser!.uId)
        .collection(AppStrings.messages)
        .add(settingUpChatParams.messageModel.toJson());
  }

  @override
  Future<void> sendMessage({
    required SendMessageParams sendMessageParams,
  }) async {
    MessageModel messageModel = MessageModel(
      senderId: Helper.currentUser!.uId,
      senderName: Helper.currentUser!.name,
      receiverId: sendMessageParams.receiverId,
      receiverName: sendMessageParams.receiverName,
      time: sendMessageParams.time,
      date: sendMessageParams.date,
      messageText: sendMessageParams.text ?? '',
      messageImage: sendMessageParams.messageImage ?? {},
      dateTime: Timestamp.now(),
    );

    _settingUpSenderChat(
      settingUpChatParams: SettingUpChatParams(
        receiverId: sendMessageParams.receiverId,
        messageModel: messageModel,
      ),
    ).then((value) {
      _settingUpReceiverChat(
        settingUpChatParams: SettingUpChatParams(
          receiverId: sendMessageParams.receiverId,
          messageModel: messageModel,
        ),
      );
    });
  }

  @override
  Future<XFile?> getMessageImage({required ImageSource source}) async {
    return await ImagePicker().pickImage(source: source);
  }

  @override
  Future<TaskSnapshot> uploadMessageImage({File? messageImage}) async {
    return await firebase_storage.FirebaseStorage.instance
        .ref()
        .child(
          '${AppStrings.messages}/${Uri.file(messageImage!.path).pathSegments.last}',
        )
        .putFile(messageImage);
  }
}
