import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:skeletons/skeletons.dart';

import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/util/transformation.dart';
import 'package:hi_doctor_v2/app/common/values/strings.dart';
import 'package:hi_doctor_v2/app/modules/home/controllers/doctor_controller.dart';
import 'package:hi_doctor_v2/app/modules/message/chat_page.dart';
import 'package:hi_doctor_v2/app/modules/message/models/chat_peer.dart';
import 'package:hi_doctor_v2/app/modules/widgets/image_container.dart';
import 'package:hi_doctor_v2/app/routes/app_pages.dart';

class ChatTile extends StatelessWidget {
  final DocumentSnapshot document;
  final _cDoctor = Get.put(DoctorController());

  ChatTile({super.key, required this.document});

  final _textStyle = const TextStyle(
    color: Colors.black54,
  );

  String _getDate(int timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    final now = DateTime.now();
    if (date.year == now.year && date.month == now.month && date.day == now.day) {
      return DateFormat('kk:mm').format(date);
    }
    if (date.year == now.year) {
      return DateFormat('dd MMM').format(date);
    }
    return DateFormat('dd MMM yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    ChatPeer chatPeer = ChatPeer.fromDocument(document);
    return FutureBuilder<bool>(
      future: _cDoctor.getDoctorWithId(chatPeer.doctorId),
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data == true) {
            final doctorName = Tx.getDoctorName(_cDoctor.doctor.lastName, _cDoctor.doctor.firstName);
            return InkWell(
              onTap: () => Get.toNamed(
                Routes.CHAT,
                arguments: ChatPageArguments(
                  peerId: chatPeer.doctorId,
                  peerName: doctorName,
                  peerAvatar: _cDoctor.doctor.avatar!,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 7.sp,
                  horizontal: 15.sp,
                ),
                child: Row(
                  children: [
                    ImageContainer(
                      width: 55,
                      height: 55,
                      imgUrl: _cDoctor.doctor.avatar,
                    ).circle(),
                    SizedBox(width: 10.sp),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            doctorName,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 15.sp,
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
                                _getDate(int.parse(chatPeer.lastTimeStamp)),
                                style: TextStyle(
                                  color: Colors.blueGrey[300],
                                  fontSize: 12,
                                ),
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
        return SkeletonListTile(
          leadingStyle: const SkeletonAvatarStyle(
            width: 55,
            height: 55,
            shape: BoxShape.circle,
          ),
          hasSubtitle: true,
          titleStyle: SkeletonLineStyle(width: 150.sp),
          padding: EdgeInsets.symmetric(
            horizontal: Constants.padding.sp,
            vertical: 8.sp,
          ),
        );
      },
    );
  }
}
