import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/storage/box.dart';
import 'package:hi_doctor_v2/app/modules/message/models/chat_message.dart';

class MessageController extends GetxController {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  int get userId => Box.getCacheUser().id!;

  Future<void> setDataFirestore(String collectionPath, String docPath, Map<String, dynamic> dataNeedInsert) {
    return _firebaseFirestore.collection(collectionPath).doc(docPath).set(dataNeedInsert);
  }

  Stream<QuerySnapshot> getAllGroupChatStream(int limit) {
    return _firebaseFirestore
        .collection(Constants.pathMessageCollection)
        .where(Constants.supervisorId, isEqualTo: userId)
        .limit(limit)
        .snapshots();
  }

  Stream<QuerySnapshot> getChatStream(String groupChatId, int limit) {
    return _firebaseFirestore
        .collection(Constants.pathMessageCollection)
        .doc(groupChatId)
        .collection(groupChatId)
        .orderBy(Constants.createdAt, descending: true)
        .limit(limit)
        .snapshots();
  }

  Future<void> sendMessage(String content, int type, String groupChatId, int supervisorId, int peerId) {
    DocumentReference documentReference =
        _firebaseFirestore.collection(Constants.pathMessageCollection).doc(groupChatId).collection(groupChatId).doc();

    ChatMessage chatMessage = ChatMessage(
      senderId: supervisorId,
      receiverId: peerId,
      content: content,
      createdAt: Timestamp.now().millisecondsSinceEpoch,
      type: type,
    );

    return _firebaseFirestore.runTransaction((transaction) async {
      transaction.set(
        documentReference,
        chatMessage.toJson(),
      );
    });
  }

  @override
  void dispose() {
    _firebaseFirestore.terminate();
    super.dispose();
  }
}
