import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/util/utils.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/modules/message/controllers/message_controller.dart';
import 'package:hi_doctor_v2/app/modules/message/views/chat_bubble.dart';
import 'package:hi_doctor_v2/app/modules/message/views/chat_input.dart';
import 'package:hi_doctor_v2/app/modules/widgets/my_appbar.dart';

class TypeMessage {
  static const text = 0;
  static const image = 1;
}

class ChatPageArguments {
  final int peerId;
  final String peerAvatar;
  final String peerName;

  ChatPageArguments({
    required this.peerId,
    required this.peerAvatar,
    required this.peerName,
  });
}

class ChatPage extends StatefulWidget {
  ChatPage({Key? key}) : super(key: key);

  final arguments = Get.arguments as ChatPageArguments;

  @override
  ChatPageState createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> {
  late final MessageController _cMessage;

  List<QueryDocumentSnapshot> listMessage = [];
  int _limit = 20;
  final int _limitIncrement = 20;
  late String groupChatId;

  final inputController = TextEditingController();
  final listScrollController = ScrollController();

  _scrollListener() {
    if (!listScrollController.hasClients) return;
    if (listScrollController.offset >= listScrollController.position.maxScrollExtent &&
        !listScrollController.position.outOfRange &&
        _limit <= listMessage.length) {
      setState(() {
        _limit += _limitIncrement;
      });
    }
  }

  void _readLocal() async {
    await _cMessage.updateDataFirestore(
      Constants.pathMessageCollection,
      groupChatId,
      {
        Constants.isChatting: false,
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _cMessage = Get.put(MessageController());
    groupChatId = '${_cMessage.userId}-${widget.arguments.peerId}';

    listScrollController.addListener(_scrollListener);
    // _readLocal();
  }

  @override
  void dispose() {
    Utils.unfocus();
    inputController.dispose();
    super.dispose();
  }

  void onMessageSend(String content, int type) async {
    int peerId = widget.arguments.peerId;
    groupChatId = '${_cMessage.userId}-$peerId';
    if (content.trim().isNotEmpty) {
      inputController.clear();
      await _cMessage.sendMessage(content, type, groupChatId, _cMessage.userId, widget.arguments.peerId);
      await _cMessage.updateDataFirestore(
        Constants.pathMessageCollection,
        groupChatId,
        {
          Constants.isChatting: true,
        },
      );
      await _cMessage.updateDataFirestore(
        Constants.pathMessageCollection,
        groupChatId,
        {
          Constants.patientId: _cMessage.userId,
        },
      );
      await _cMessage.updateDataFirestore(
        Constants.pathMessageCollection,
        groupChatId,
        {
          Constants.lastMessage: content,
        },
      );
      await _cMessage.updateDataFirestore(
        Constants.pathMessageCollection,
        groupChatId,
        {
          Constants.lastTimeStamp: DateTime.now().millisecondsSinceEpoch.toString(),
        },
      );
      if (listScrollController.hasClients) {
        listScrollController.animateTo(0, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      }
    } else {
      print('CHAT PAGE ERR: Nothing to send');
    }
  }

  Widget buildListMessage() {
    return Flexible(
      child: StreamBuilder<QuerySnapshot>(
        stream: _cMessage.getChatStream(groupChatId, _limit),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            listMessage = snapshot.data!.docs;
            if (listMessage.isNotEmpty) {
              return ListView.builder(
                reverse: true,
                padding: EdgeInsets.all(10.sp),
                itemBuilder: (context, index) => ChatBubble(
                  userId: _cMessage.userId,
                  document: snapshot.data?.docs[index],
                  index: index,
                  listMessage: listMessage,
                  peerAvatar: widget.arguments.peerAvatar,
                ),
                itemCount: snapshot.data?.docs.length,
                controller: listScrollController,
              );
            } else {
              return const Center(child: Text("No message here yet..."));
            }
          } else {
            return Center(
              child: SpinKitChasingDots(
                size: 30.sp,
                color: AppColors.primary.withOpacity(0.3),
              ),
            );
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: widget.arguments.peerName,
      ),
      body: Column(
        children: <Widget>[
          buildListMessage(),
          ChatInput(inputController: inputController, onMessageSend: onMessageSend),
        ],
      ),
    );
  }
}
