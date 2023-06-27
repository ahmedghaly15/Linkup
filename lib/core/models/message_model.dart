import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String? senderId;
  String? senderName;
  String? receiverId;
  String? receiverName;
  String? time;
  String? date;
  String? messageText;
  Map<String, dynamic>? messageImage;
  Timestamp? dateTime;

  MessageModel({
    this.receiverId,
    this.receiverName,
    this.senderId,
    this.senderName,
    this.time,
    this.date,
    this.dateTime,
    this.messageText,
    this.messageImage,
  });

  MessageModel.fromJson(Map<String, dynamic> json) {
    senderId = json['senderId'];
    senderName = json['senderName'];
    receiverId = json['receiverId'];
    receiverName = json['receiverName'];
    messageImage = json['messageImage'];
    time = json['time'];
    date = json['date'];
    messageText = json['messageText'];
    dateTime = json['dateTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'senderId': senderId,
      'senderName': senderName,
      'receiverId': receiverId,
      'receiverName': receiverName,
      'messageImage': messageImage,
      'date': date,
      'time': time,
      'messageText': messageText,
      'dateTime': dateTime,
    };
  }
}
