import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';

import 'package:hi_doctor_v2/app/modules/message/chat_page.dart';
import 'package:hi_doctor_v2/app/modules/message/models/chat_message.dart';
import 'package:intl/intl.dart';

class ChatBubble extends StatelessWidget {
  final int userId;
  final int index;
  final DocumentSnapshot? document;
  final List<QueryDocumentSnapshot> listMessage;
  final String peerAvatar;

  const ChatBubble({
    super.key,
    required this.userId,
    required this.document,
    required this.index,
    required this.listMessage,
    required this.peerAvatar,
  });

  String getDate(String timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp));
    final now = DateTime.now();
    if (date.year == now.year && date.month == now.month && date.day == now.day) {
      return DateFormat('kk:mm').format(date);
    }
    return DateFormat('dd MMM kk:mm').format(date);
  }

  Widget getDateWidget(EdgeInsets padding, String timestamp) {
    return Padding(
      padding: padding,
      child: Text(
        getDate(timestamp),
        style: TextStyle(color: Colors.blueGrey[300], fontSize: 12, fontStyle: FontStyle.italic),
      ),
    );
  }

  bool isLastMessageLeft(int index) {
    if ((index > 0 && listMessage[index - 1].get(Constants.idFrom) == userId) || index == 0) {
      return true;
    } else {
      return false;
    }
  }

  bool isLastMessageRight(int index) {
    if ((index > 0 && listMessage[index - 1].get(Constants.idFrom) != userId) || index == 0) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (document != null) {
      ChatMessage messageChat = ChatMessage.fromDocument(document!);
      if (messageChat.idFrom == userId) {
        // Right (my message)
        return Padding(
          padding: EdgeInsets.only(bottom: 10.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  messageChat.type == TypeMessage.text
                      ? Container(
                          constraints: BoxConstraints(
                            maxWidth: 250.sp,
                          ),
                          padding: EdgeInsets.fromLTRB(15.sp, 10.sp, 15.sp, 10.sp),
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(8.sp),
                          ),
                          margin: EdgeInsets.only(right: 10.sp),
                          child: Text(
                            messageChat.content,
                            style: const TextStyle(color: Colors.white),
                          ),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
              if (isLastMessageRight(index))
                getDateWidget(
                  EdgeInsets.only(right: 10.sp, top: 5.sp, bottom: 5.sp),
                  messageChat.timestamp,
                ),
            ],
          ),
        );
      } else {
        // Left (peer message)
        return Padding(
          padding: EdgeInsets.only(bottom: 10.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  isLastMessageLeft(index)
                      ? Container(
                          width: 35.sp,
                          height: 35.sp,
                          decoration: BoxDecoration(
                            color: AppColors.grey300,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(peerAvatar),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : SizedBox(width: 35.sp),
                  messageChat.type == TypeMessage.text
                      ? Container(
                          constraints: BoxConstraints(
                            maxWidth: 230.sp,
                          ),
                          padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 15.sp),
                          decoration: BoxDecoration(
                            color: Colors.blueGrey.shade50,
                            borderRadius: BorderRadius.circular(8.sp),
                          ),
                          margin: EdgeInsets.only(left: 10.sp),
                          child: Text(
                            messageChat.content,
                            style: const TextStyle(color: Colors.black),
                          ),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
              // Time
              isLastMessageLeft(index)
                  ? getDateWidget(
                      EdgeInsets.only(left: 50.sp, top: 5.sp, bottom: 5.sp),
                      messageChat.timestamp,
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
}
