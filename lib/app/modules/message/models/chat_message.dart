import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:hi_doctor_v2/app/common/constants.dart';

class ChatMessage {
  int idFrom;
  int idTo;
  String timestamp;
  String content;
  int type;

  ChatMessage({
    required this.idFrom,
    required this.idTo,
    required this.timestamp,
    required this.content,
    required this.type,
  });

  Map<String, dynamic> toJson() {
    return {
      Constants.idFrom: idFrom,
      Constants.idTo: idTo,
      Constants.timestamp: timestamp,
      Constants.content: content,
      Constants.type: type,
    };
  }

  factory ChatMessage.fromDocument(DocumentSnapshot doc) {
    int idFrom = doc.get(Constants.idFrom);
    int idTo = doc.get(Constants.idTo);
    String timestamp = doc.get(Constants.timestamp);
    String content = doc.get(Constants.content);
    int type = doc.get(Constants.type);
    return ChatMessage(idFrom: idFrom, idTo: idTo, timestamp: timestamp, content: content, type: type);
  }
}
