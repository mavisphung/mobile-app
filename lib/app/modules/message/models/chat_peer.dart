// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/util/extensions.dart';

class ChatPeer {
  int doctorId;
  int doctorAccountId;
  String lastMessage;
  String lastTimeStamp;

  ChatPeer({
    required this.doctorId,
    required this.doctorAccountId,
    required this.lastMessage,
    required this.lastTimeStamp,
  });

  factory ChatPeer.fromDocument(DocumentSnapshot doc) {
    late int doctorId;
    late int doctorAccountId;
    late String lastMessage;
    late String lastTimeStamp;
    try {
      doctorId = doc.get(Constants.doctorId);
      doctorAccountId = doc.get(Constants.doctorAccountId);
      lastMessage = doc.get(Constants.lastMessage);
      lastTimeStamp = doc.get(Constants.lastTimeStamp);
    } catch (e) {
      'CANNOT GET GROUP CHAT INFO'.debugLog('FIREBASE');
    }
    return ChatPeer(
      doctorId: doctorId,
      doctorAccountId: doctorAccountId,
      lastMessage: lastMessage,
      lastTimeStamp: lastTimeStamp,
    );
  }
}
