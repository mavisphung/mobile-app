import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/storage/box.dart';

class MessageController extends GetxController {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final _userInfo = Box.userInfo;

  int get userId => _userInfo!.id!;

  MessageController();

  Future<void> insertDataFirestore(String collectionPath, String docPath, Map<String, dynamic> dataNeedUpdate) {
    return _firebaseFirestore.collection(collectionPath).doc(docPath).set(dataNeedUpdate);
  }

  Future<void> updateDataFirestore(String collectionPath, String docPath, Map<String, dynamic> dataNeedUpdate) {
    DocumentReference documentReference = _firebaseFirestore.collection(collectionPath).doc(docPath);

    return _firebaseFirestore.runTransaction((transaction) async {
      transaction.update(
        documentReference,
        dataNeedUpdate,
      );
    });
  }

  Future<bool> hasGroupChatDocument(String groupChatId) async {
    final snapshot = await _firebaseFirestore.collection(Constants.pathMessageCollection).doc(groupChatId).get();
    if (snapshot.data() == null) return false;
    return true;
  }

  Stream<QuerySnapshot> getAllGroupChatStream(int limit) {
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

  Future<void> sendMessage(String content, int type, String groupChatId, int currentUserId, int peerId) {
    DocumentReference documentReference = _firebaseFirestore
        .collection(Constants.pathMessageCollection)
        .doc(groupChatId)
        .collection(groupChatId)
        .doc(DateTime.now().millisecondsSinceEpoch.toString());

    // ChatMessage chatMessage = ChatMessage(
    //   idFrom: currentUserId,
    //   idTo: peerId,
    //   timestamp: DateTime.now().millisecondsSinceEpoch.toString(),
    //   content: content,
    //   type: type,
    // );

    return _firebaseFirestore.runTransaction((transaction) async {
      transaction.set(
        documentReference,
        // chatMessage.toJson(),
        {
          Constants.idFrom: currentUserId,
          Constants.idTo: peerId,
          Constants.timestamp: DateTime.now().millisecondsSinceEpoch.toString(),
          Constants.content: content,
          Constants.type: type,
        },
      );
    });
  }

  @override
  void dispose() {
    _firebaseFirestore.terminate();
    super.dispose();
  }
}
