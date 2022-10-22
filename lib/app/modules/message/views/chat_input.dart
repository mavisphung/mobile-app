import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/modules/message/chat_page.dart';

class ChatInput extends StatelessWidget {
  final TextEditingController inputController;
  final Function(String, int) onMessageSend;

  const ChatInput({
    super.key,
    required this.inputController,
    required this.onMessageSend,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.sp,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(0, 8),
            blurRadius: 8.sp,
          ),
        ],
        color: Colors.white,
      ),
      child: Row(
        children: <Widget>[
          // Button send image
          Material(
            color: Colors.white,
            child: IconButton(
              icon: const Icon(CupertinoIcons.photo_fill),
              onPressed: () {
                // getImage();
              },
              color: Colors.black,
            ),
          ),
          // Edit text
          Flexible(
            child: TextField(
              onSubmitted: (value) => onMessageSend(inputController.text, TypeMessage.text),
              style: const TextStyle(color: Colors.black, fontSize: 15),
              controller: inputController,
              decoration: InputDecoration.collapsed(
                hintText: 'Type your message...',
                hintStyle: TextStyle(color: Colors.blueGrey.shade200),
              ),
            ),
          ),
          // Button send message
          Material(
            color: Colors.white,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: IconButton(
                icon: const Icon(PhosphorIcons.paper_plane_right_fill),
                onPressed: () => onMessageSend(inputController.text, TypeMessage.text),
                color: AppColors.secondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
