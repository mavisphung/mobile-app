import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/modules/message/chat_page.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_icon_button.dart';

class ChatInput extends StatelessWidget {
  final TextEditingController inputController;
  final void Function(int) onMessageSend;

  const ChatInput({
    super.key,
    required this.inputController,
    required this.onMessageSend,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.sp,
      decoration: BoxDecoration(
        color: AppColors.grey200,
      ),
      child: Row(
        children: <Widget>[
          // Button send image
          CustomIconButton(
            onPressed: () {
              // getImage();
            },
            icon: Icon(CupertinoIcons.photo_fill, color: AppColors.grey600),
          ),
          // Edit text
          Flexible(
            child: TextField(
              onSubmitted: (value) => onMessageSend(TypeMessage.TEXT.index),
              style: const TextStyle(fontSize: 15),
              controller: inputController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Type your message...',
                hintStyle: TextStyle(color: Colors.blueGrey.shade200),
                contentPadding:
                    EdgeInsets.only(top: 10.sp, bottom: 10.sp, left: Constants.padding.sp, right: Constants.padding.sp),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
          ),
          // Button send message
          CustomIconButton(
            onPressed: () => onMessageSend(TypeMessage.TEXT.index),
            icon: Icon(PhosphorIcons.paper_plane_right_fill, color: AppColors.primary),
          ),
        ],
      ),
    );
  }
}
