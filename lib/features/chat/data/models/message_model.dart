import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class MessageModel extends Equatable {
  final String? senderId;
  final String? senderName;
  final String? receiverId;
  final String? receiverName;
  final String? time;
  final String? date;
  final String? messageText;
  final Map<String, dynamic>? messageImage;
  final Timestamp? dateTime;

  const MessageModel({
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

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      senderId: json['senderId'] as String?,
      senderName: json['senderName'] as String?,
      receiverId: json['receiverId'] as String?,
      receiverName: json['receiverName'] as String?,
      messageImage: json['messageImage'] as Map<String, dynamic>?,
      time: json['time'] as String?,
      date: json['date'] as String?,
      messageText: json['messageText'] as String?,
      dateTime: json['dateTime'] as Timestamp?,
    );
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

  @override
  List<Object?> get props => [
        senderId,
        senderName,
        receiverId,
        receiverName,
        messageImage,
        date,
        time,
        messageText,
        dateTime,
      ];
}
