// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:hi_doctor_v2/app/common/constants.dart';

class ChatMessage {
  int senderId;
  int receiverId;
  String content;
  int createdAt;
  int type;

  ChatMessage({
    required this.senderId,
    required this.receiverId,
    required this.content,
    required this.createdAt,
    required this.type,
  });

  Map<String, dynamic> toJson() {
    return {
      Constants.senderId: senderId,
      Constants.receiverId: receiverId,
      Constants.content: content,
      Constants.createdAt: createdAt,
      Constants.type: type,
    };
  }

  factory ChatMessage.fromDocument(DocumentSnapshot doc) {
    int senderId = doc.get(Constants.senderId);
    int receiverId = doc.get(Constants.receiverId);
    String content = doc.get(Constants.content);
    int createdAt = doc.get(Constants.createdAt);
    int type = doc.get(Constants.type);
    return ChatMessage(senderId: senderId, receiverId: receiverId, content: content, createdAt: createdAt, type: type);
  }
}
