import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/storage/storage.dart';
import 'package:hi_doctor_v2/app/models/user_info.dart';
import 'package:hi_doctor_v2/app/modules/message/models/chat_message.dart';

class MessageController extends GetxController {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final _userInfo = Storage.getValue<UserInfo2>(CacheKey.USER_INFO.name);

  int get userId => _userInfo!.id!;

  MessageController();

  Future<void> updateDataFirestore(String collectionPath, String docPath, Map<String, dynamic> dataNeedUpdate) {
    return _firebaseFirestore.collection(collectionPath).doc(docPath).update(dataNeedUpdate);
  }

  Stream<QuerySnapshot> getGroupChatStream(int limit) {
    return _firebaseFirestore
        .collection(Constants.pathMessageCollection)
        .where(Constants.patientId, isEqualTo: userId)
        .limit(limit)
        .snapshots();
  }

  Stream<QuerySnapshot> getChatStream(String groupChatId, int limit) {
    return _firebaseFirestore
        .collection(Constants.pathMessageCollection)
        .doc(groupChatId)
        .collection(groupChatId)
        .orderBy(Constants.timestamp, descending: true)
        .limit(limit)
        .snapshots();
  }

  void sendMessage(String content, int type, String groupChatId, int currentUserId, int peerId) {
    DocumentReference documentReference = _firebaseFirestore
        .collection(Constants.pathMessageCollection)
        .doc(groupChatId)
        .collection(groupChatId)
        .doc(DateTime.now().millisecondsSinceEpoch.toString());

    ChatMessage chatMessage = ChatMessage(
      idFrom: currentUserId,
      idTo: peerId,
      timestamp: DateTime.now().millisecondsSinceEpoch.toString(),
      content: content,
      type: type,
    );

    FirebaseFirestore.instance.runTransaction((transaction) async {
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
