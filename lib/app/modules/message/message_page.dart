import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/common/values/strings.dart';
import 'package:hi_doctor_v2/app/modules/message/controllers/message_controller.dart';
import 'package:hi_doctor_v2/app/modules/message/views/chat_tile.dart';
import 'package:hi_doctor_v2/app/modules/widgets/my_appbar.dart';

class MessagePage extends StatelessWidget {
  MessagePage({Key? key}) : super(key: key);

  final MessageController _cMessage = Get.put(MessageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: MyAppBar(
        title: Strings.message.tr,
        hasBackBtn: false,
      ),
      body: Column(
        children: [
          const Text('HELOO'),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: StreamBuilder<QuerySnapshot>(
                stream: _cMessage.getGroupChatStream(20),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) print('NO DATA');
                  if (snapshot.hasData) {
                    if (snapshot.data!.docs.isNotEmpty) {
                      return ListView.builder(
                        padding: const EdgeInsets.all(10),
                        itemBuilder: (context, index) => ChatTile(document: snapshot.data!.docs[index]),
                        itemCount: snapshot.data?.docs.length,
                      );
                    } else {
                      return const Center(
                        child: Text("No users"),
                      );
                    }
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.blueGrey,
                        strokeWidth: 10.0,
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
