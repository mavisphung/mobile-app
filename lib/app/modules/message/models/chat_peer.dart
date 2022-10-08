// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/util/extensions.dart';

class ChatPeer {
  int doctorId;
  String lastMessage;
  String lastTimeStamp;

  ChatPeer({
    required this.doctorId,
    required this.lastMessage,
    required this.lastTimeStamp,
  });

  factory ChatPeer.fromDocument(DocumentSnapshot doc) {
    int doctorId = 0;
    String lastMessage = '';
    String lastTimeStamp = '';
    try {
      doctorId = doc.get(Constants.doctorId);
      lastMessage = doc.get(Constants.lastMessage);
      lastTimeStamp = doc.get(Constants.lastTimeStamp);
    } catch (e) {
      'CANNOT GET FIELD'.debugLog('FIREBASE');
    }
    return ChatPeer(
      doctorId: doctorId,
      lastMessage: lastMessage,
      lastTimeStamp: lastTimeStamp,
    );
  }
}
