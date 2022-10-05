import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/common/values/strings.dart';
import 'package:hi_doctor_v2/app/modules/home/controllers/doctor_controller.dart';
import 'package:hi_doctor_v2/app/modules/message/chat_page.dart';
import 'package:hi_doctor_v2/app/modules/message/models/chat_peer.dart';
import 'package:hi_doctor_v2/app/routes/app_pages.dart';
import 'package:intl/intl.dart';

class ChatTile extends StatelessWidget {
  final DocumentSnapshot document;
  final _cDoctor = Get.put(DoctorController());

  ChatTile({super.key, required this.document});

  final _textStyle = const TextStyle(
    color: Colors.black54,
  );

  @override
  Widget build(BuildContext context) {
    ChatPeer chatPeer = ChatPeer.fromDocument(document);
    return FutureBuilder<bool>(
      future: _cDoctor.getDoctorWithId(chatPeer.doctorId),
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data == true) {
            final fullName = '${_cDoctor.doctor.lastName} ${_cDoctor.doctor.firstName}';
            return GestureDetector(
              onTap: () => Get.toNamed(
                Routes.CHAT,
                arguments: ChatPageArguments(
                  peerId: chatPeer.doctorId,
                  peerName: fullName,
                  peerAvatar: _cDoctor.doctor.avatar!,
                ),
              ),
              child: Container(
                height: 75.sp,
                padding: EdgeInsets.all(12.sp),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(Constants.textFieldRadius.sp),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 55.sp,
                      height: 55.sp,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(width: 10.sp),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${Strings.doctor.tr} $fullName',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: 6.sp,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  chatPeer.lastMessage,
                                  overflow: TextOverflow.ellipsis,
                                  style: _textStyle,
                                ),
                              ),
                              Text(
                                DateFormat('dd MMM kk:mm')
                                    .format(DateTime.fromMillisecondsSinceEpoch(int.parse(chatPeer.lastTimeStamp))),
                                style:
                                    TextStyle(color: Colors.blueGrey[300], fontSize: 12, fontStyle: FontStyle.italic),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        }
        return const Center(
          child: Text('Loading'),
        );
      },
    );
  }
}
