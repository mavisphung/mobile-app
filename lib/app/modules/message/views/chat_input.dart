import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/util/utils.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/common/values/strings.dart';
import 'package:hi_doctor_v2/app/data/custom_controller.dart';
import 'package:hi_doctor_v2/app/modules/message/chat_page.dart';
import 'package:hi_doctor_v2/app/modules/message/controllers/message_controller.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_card.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_icon_button.dart';

// ignore: must_be_immutable
class ChatInput extends StatelessWidget {
  final void Function(int, String?) onMessageSend;
  final _cCustom = Get.put(CustomController());
  final _cMessage = Get.find<MessageController>();
  String? imgURl;

  ChatInput({
    super.key,
    required this.onMessageSend,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      verticalPadding: 5,
      horizontalPadding: 0,
      child: Row(
        children: <Widget>[
          CustomIconButton(
            onPressed: () async {
              var isFromCamera = await Utils.showConfirmDialog(
                Strings.imageSourceMsg,
                cancelText: Strings.gallery,
                confirmText: Strings.camera,
              );
              if (isFromCamera != null) {
                final url = await _cCustom.getImage(isFromCamera);
                if (url != null) {
                  imgURl = url;
                  _cMessage.inputController.text = '[hình ảnh]';
                }
              }
            },
            icon: Icon(CupertinoIcons.photo_fill, color: AppColors.grey600),
          ),
          // Edit text
          Flexible(
            child: TextField(
              onSubmitted: (value) => onMessageSend(TypeMessage.TEXT.index, null),
              style: const TextStyle(fontSize: 15),
              controller: _cMessage.inputController,
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.grey200,
                hintText: 'Nhập tin nhắn gửi cho bác sĩ',
                hintStyle: TextStyle(color: Colors.grey.shade700),
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
            onPressed: () {
              if (imgURl == null) {
                onMessageSend(TypeMessage.TEXT.index, null);
                return;
              }
              onMessageSend(TypeMessage.IMAGE.index, imgURl);
              imgURl = null;
            },
            icon: Icon(PhosphorIcons.paper_plane_right_fill, color: AppColors.primary),
          ),
        ],
      ),
    );
  }
}
