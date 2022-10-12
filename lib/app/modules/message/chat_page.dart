import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/modules/message/controllers/message_controller.dart';
import 'package:hi_doctor_v2/app/modules/message/models/chat_message.dart';
import 'package:hi_doctor_v2/app/modules/widgets/my_appbar.dart';
import 'package:intl/intl.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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

  final TextEditingController textEditingController = TextEditingController();
  final ScrollController listScrollController = ScrollController();
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _cMessage = MessageController();
    groupChatId = '${_cMessage.userId}-${widget.arguments.peerId}';

    listScrollController.addListener(_scrollListener);
    // _readLocal();
  }

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

  void onSendMessage(String content, int type) async {
    int peerId = widget.arguments.peerId;
    groupChatId = '${_cMessage.userId}-$peerId';
    if (content.trim().isNotEmpty) {
      textEditingController.clear();
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

  Widget buildItem(int index, DocumentSnapshot? document) {
    if (document != null) {
      ChatMessage messageChat = ChatMessage.fromDocument(document);
      if (messageChat.idFrom == _cMessage.userId) {
        // Right (my message)
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            messageChat.type == TypeMessage.text
                // Text
                ? Container(
                    padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                    width: 200,
                    decoration: BoxDecoration(color: Colors.blueGrey[50], borderRadius: BorderRadius.circular(8)),
                    margin: EdgeInsets.only(bottom: isLastMessageRight(index) ? 20 : 10, right: 10),
                    child: Text(
                      messageChat.content,
                      style: const TextStyle(color: Colors.black),
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        );
      } else {
        // Left (peer message)
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  isLastMessageLeft(index)
                      ? Material(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(18),
                          ),
                          clipBehavior: Clip.hardEdge,
                          child: CircleAvatar(backgroundColor: Colors.blueGrey[300]),
                        )
                      : Container(width: 35),
                  messageChat.type == TypeMessage.text
                      ? Container(
                          padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                          width: 200,
                          decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(8)),
                          margin: const EdgeInsets.only(left: 10),
                          child: Text(
                            messageChat.content,
                            style: const TextStyle(color: Colors.white),
                          ),
                        )
                      : const SizedBox.shrink(),
                ],
              ),

              // Time
              isLastMessageLeft(index)
                  ? Container(
                      margin: const EdgeInsets.only(left: 50, top: 5, bottom: 5),
                      child: Text(
                        DateFormat('dd MMM kk:mm')
                            .format(DateTime.fromMillisecondsSinceEpoch(int.parse(messageChat.timestamp))),
                        style: TextStyle(color: Colors.blueGrey[300], fontSize: 12, fontStyle: FontStyle.italic),
                      ),
                    )
                  : const SizedBox.shrink()
            ],
          ),
        );
      }
    } else {
      return const SizedBox.shrink();
    }
  }

  bool isLastMessageLeft(int index) {
    if ((index > 0 && listMessage[index - 1].get(Constants.idFrom) == _cMessage.userId) || index == 0) {
      return true;
    } else {
      return false;
    }
  }

  bool isLastMessageRight(int index) {
    if ((index > 0 && listMessage[index - 1].get(Constants.idFrom) != _cMessage.userId) || index == 0) {
      return true;
    } else {
      return false;
    }
  }

  // void onBackPress() {
  //   _cMessage.updateDataFirestore(
  //     Constants.pathUserCollection,
  //     currentUserId,
  //     {Constants.chattingWith: null},
  //   );
  //   Navigator.pop(context);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: widget.arguments.peerName,
      ),
      body: Column(
        children: <Widget>[
          // List of messages
          buildListMessage(),
          // Input content
          buildInput(),
        ],
      ),
    );
  }

  Widget buildInput() {
    return Container(
      width: double.infinity,
      height: 50,
      decoration:
          BoxDecoration(border: Border(top: BorderSide(color: Colors.blueGrey[50]!, width: 0.5)), color: Colors.white),
      child: Row(
        children: <Widget>[
          // Button send image
          Material(
            color: Colors.white,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 1),
              child: IconButton(
                icon: const Icon(Icons.image),
                onPressed: () {
                  // getImage();
                },
                color: Colors.black,
              ),
            ),
          ),
          // Edit text
          Flexible(
            child: TextField(
              onSubmitted: (value) {
                onSendMessage(textEditingController.text, TypeMessage.text);
              },
              style: const TextStyle(color: Colors.black, fontSize: 15),
              controller: textEditingController,
              decoration: InputDecoration.collapsed(
                hintText: 'Type your message...',
                hintStyle: TextStyle(color: Colors.blueGrey[300]),
              ),
              focusNode: focusNode,
              autofocus: true,
            ),
          ),

          // Button send message
          Material(
            color: Colors.white,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: IconButton(
                icon: const Icon(Icons.send),
                onPressed: () => onSendMessage(textEditingController.text, TypeMessage.text),
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildListMessage() {
    return Flexible(
      child: groupChatId.isNotEmpty
          ? StreamBuilder<QuerySnapshot>(
              stream: _cMessage.getChatStream(groupChatId, _limit),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  listMessage = snapshot.data!.docs;
                  if (listMessage.isNotEmpty) {
                    return ListView.builder(
                      padding: const EdgeInsets.all(10),
                      itemBuilder: (context, index) => buildItem(index, snapshot.data?.docs[index]),
                      itemCount: snapshot.data?.docs.length,
                      reverse: true,
                      controller: listScrollController,
                    );
                  } else {
                    return const Center(child: Text("No message here yet..."));
                  }
                } else {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.deepPurple,
                    ),
                  );
                }
              },
            )
          : const Center(
              child: CircularProgressIndicator(
                color: Colors.deepPurple,
              ),
            ),
    );
  }
}
